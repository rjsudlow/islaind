#!/bin/bash

# Islaind Hugo Theme - Deployment Script
# Supports multiple deployment targets: Netlify, GitHub Pages, AWS S3, and custom servers

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SITE_NAME="Islaind Hugo Theme"
BUILD_DIR="public"
TEMP_DIR="deploy_temp"

# Functions
print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}${SITE_NAME} Deployment${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

check_prerequisites() {
    print_info "Checking prerequisites..."

    # Check Hugo
    if ! command -v hugo &> /dev/null; then
        print_error "Hugo is not installed"
        exit 1
    fi

    # Check Git
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed"
        exit 1
    fi

    print_success "Prerequisites check passed"
}

build_site() {
    print_info "Building site..."

    # Clean previous build
    rm -rf ${BUILD_DIR}

    # Build with Hugo
    if hugo --minify --cleanDestinationDir; then
        print_success "Site built successfully"

        # Show build stats
        if [ -d "${BUILD_DIR}" ]; then
            echo ""
            print_info "Build Statistics:"
            echo "  Total files: $(find ${BUILD_DIR} -type f | wc -l)"
            echo "  Total size: $(du -sh ${BUILD_DIR} | cut -f1)"
            echo "  HTML files: $(find ${BUILD_DIR} -name "*.html" | wc -l)"
            echo "  CSS files: $(find ${BUILD_DIR} -name "*.css" | wc -l)"
            echo "  JS files: $(find ${BUILD_DIR} -name "*.js" | wc -l)"
            echo ""
        fi
    else
        print_error "Build failed"
        exit 1
    fi
}

deploy_netlify() {
    print_info "Deploying to Netlify..."

    if command -v netlify &> /dev/null; then
        if netlify deploy --prod --dir=${BUILD_DIR}; then
            print_success "Deployed to Netlify successfully"
        else
            print_error "Netlify deployment failed"
            exit 1
        fi
    else
        print_error "Netlify CLI is not installed"
        echo "Install with: npm install -g netlify-cli"
        exit 1
    fi
}

deploy_github_pages() {
    print_info "Deploying to GitHub Pages..."

    # Check if we're in a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository"
        exit 1
    fi

    # Check if gh-pages branch exists
    if git show-ref --verify --quiet refs/heads/gh-pages; then
        print_info "gh-pages branch exists, updating..."
    else
        print_info "Creating gh-pages branch..."
        git checkout --orphan gh-pages
        git rm -rf .
        git commit --allow-empty -m "Initial gh-pages commit"
        git checkout main
    fi

    # Create temporary directory
    mkdir -p ${TEMP_DIR}
    cp -r ${BUILD_DIR}/* ${TEMP_DIR}/

    # Switch to gh-pages branch
    git checkout gh-pages

    # Clear current content
    find . -maxdepth 1 -not -name '.git' -not -name '.gitignore' -not -name '.' -not -name '..' -exec rm -rf {} +

    # Copy new content
    cp -r ${TEMP_DIR}/* .

    # Add .nojekyll file
    touch .nojekyll

    # Commit and push
    git add .
    git commit -m "Deploy site - $(date)"
    git push origin gh-pages

    # Switch back to main branch
    git checkout main

    # Clean up
    rm -rf ${TEMP_DIR}

    print_success "Deployed to GitHub Pages successfully"
}

deploy_aws_s3() {
    print_info "Deploying to AWS S3..."

    if [ -z "$AWS_S3_BUCKET" ]; then
        print_error "AWS_S3_BUCKET environment variable not set"
        exit 1
    fi

    if command -v aws &> /dev/null; then
        # Sync to S3
        if aws s3 sync ${BUILD_DIR}/ s3://${AWS_S3_BUCKET} --delete --exact-timestamps; then
            print_success "Synced to S3 successfully"

            # Invalidate CloudFront if distribution ID is provided
            if [ -n "$AWS_CLOUDFRONT_DISTRIBUTION_ID" ]; then
                print_info "Invalidating CloudFront cache..."
                aws cloudfront create-invalidation \
                    --distribution-id ${AWS_CLOUDFRONT_DISTRIBUTION_ID} \
                    --paths "/*"
                print_success "CloudFront cache invalidated"
            fi
        else
            print_error "S3 sync failed"
            exit 1
        fi
    else
        print_error "AWS CLI is not installed"
        exit 1
    fi
}

deploy_ftp() {
    print_info "Deploying via FTP..."

    if [ -z "$FTP_HOST" ] || [ -z "$FTP_USER" ] || [ -z "$FTP_PASS" ]; then
        print_error "FTP credentials not set. Required: FTP_HOST, FTP_USER, FTP_PASS"
        exit 1
    fi

    if command -v lftp &> /dev/null; then
        lftp -c "
            set ftp:ssl-allow no;
            open ftp://${FTP_USER}:${FTP_PASS}@${FTP_HOST};
            lcd ${BUILD_DIR};
            cd ${FTP_PATH:-/public_html};
            mirror --reverse --delete --verbose --exclude-glob .git* --exclude-glob .DS_Store;
            quit
        "
        print_success "FTP deployment completed"
    else
        print_error "lftp is not installed"
        exit 1
    fi
}

deploy_rsync() {
    print_info "Deploying via rsync..."

    if [ -z "$RSYNC_USER" ] || [ -z "$RSYNC_HOST" ] || [ -z "$RSYNC_PATH" ]; then
        print_error "Rsync settings not configured. Required: RSYNC_USER, RSYNC_HOST, RSYNC_PATH"
        exit 1
    fi

    if command -v rsync &> /dev/null; then
        rsync -avz --delete \
            --exclude '.git*' \
            --exclude '.DS_Store' \
            ${BUILD_DIR}/ \
            ${RSYNC_USER}@${RSYNC_HOST}:${RSYNC_PATH}
        print_success "Rsync deployment completed"
    else
        print_error "rsync is not installed"
        exit 1
    fi
}

deploy_docker() {
    print_info "Building and deploying Docker container..."

    if [ -z "$DOCKER_IMAGE_NAME" ]; then
        DOCKER_IMAGE_NAME="caribbean-security-conference"
    fi

    if [ -z "$DOCKER_TAG" ]; then
        DOCKER_TAG="latest"
    fi

    # Create Dockerfile if it doesn't exist
    if [ ! -f "Dockerfile" ]; then
        cat > Dockerfile << 'EOF'
FROM nginx:alpine
COPY public/ /usr/share/nginx/html/
COPY docker/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
EOF
    fi

    # Create nginx config if it doesn't exist
    mkdir -p docker
    if [ ! -f "docker/nginx.conf" ]; then
        cat > docker/nginx.conf << 'EOF'
events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    sendfile on;
    tcp_nopush on;
    tcp_nodelay on;
    keepalive_timeout 65;
    types_hash_max_size 2048;

    gzip on;
    gzip_vary on;
    gzip_min_length 10240;
    gzip_proxied expired no-cache no-store private must-revalidate;
    gzip_types
        text/plain
        text/css
        text/xml
        text/javascript
        application/javascript
        application/xml+rss
        application/json;

    server {
        listen 80;
        server_name _;

        location / {
            root /usr/share/nginx/html;
            index index.html index.htm;
            try_files $uri $uri/ =404;
        }

        location ~* \.(jpg|jpeg|png|gif|ico|css|js)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }
}
EOF
    fi

    # Build Docker image
    if docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} .; then
        print_success "Docker image built successfully"

        # Push to registry if configured
        if [ -n "$DOCKER_REGISTRY" ]; then
            docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
            docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_TAG}
            print_success "Docker image pushed to registry"
        fi
    else
        print_error "Docker build failed"
        exit 1
    fi
}

show_deployment_menu() {
    echo ""
    echo "Available deployment targets:"
    echo "1. Netlify"
    echo "2. GitHub Pages"
    echo "3. AWS S3"
    echo "4. FTP"
    echo "5. Rsync"
    echo "6. Docker"
    echo "7. All configured targets"
    echo ""
    read -p "Select deployment target (1-7): " choice

    case $choice in
        1) deploy_netlify ;;
        2) deploy_github_pages ;;
        3) deploy_aws_s3 ;;
        4) deploy_ftp ;;
        5) deploy_rsync ;;
        6) deploy_docker ;;
        7) deploy_all ;;
        *) print_error "Invalid choice" && exit 1 ;;
    esac
}

deploy_all() {
    print_info "Deploying to all configured targets..."

    # Check which deployment methods are configured
    local targets=()

    if command -v netlify &> /dev/null; then
        targets+=("netlify")
    fi

    if git rev-parse --git-dir > /dev/null 2>&1; then
        targets+=("github")
    fi

    if [ -n "$AWS_S3_BUCKET" ] && command -v aws &> /dev/null; then
        targets+=("s3")
    fi

    if [ -n "$FTP_HOST" ] && command -v lftp &> /dev/null; then
        targets+=("ftp")
    fi

    if [ -n "$RSYNC_HOST" ] && command -v rsync &> /dev/null; then
        targets+=("rsync")
    fi

    if command -v docker &> /dev/null; then
        targets+=("docker")
    fi

    if [ ${#targets[@]} -eq 0 ]; then
        print_warning "No deployment targets configured"
        exit 1
    fi

    print_info "Configured targets: ${targets[*]}"

    for target in "${targets[@]}"; do
        echo ""
        case $target in
            netlify) deploy_netlify ;;
            github) deploy_github_pages ;;
            s3) deploy_aws_s3 ;;
            ftp) deploy_ftp ;;
            rsync) deploy_rsync ;;
            docker) deploy_docker ;;
        esac
    done
}

run_tests() {
    print_info "Running pre-deployment tests..."

    # Check if public directory exists
    if [ ! -d "${BUILD_DIR}" ]; then
        print_error "Build directory not found. Run build first."
        exit 1
    fi

    # Check if index.html exists
    if [ ! -f "${BUILD_DIR}/index.html" ]; then
        print_error "index.html not found in build directory"
        exit 1
    fi

    # Check for broken links (if htmlproofer is available)
    if command -v htmlproofer &> /dev/null; then
        print_info "Checking for broken links..."
        htmlproofer ${BUILD_DIR} --check-html --check-opengraph --check-favicon --allow-hash-href || true
    fi

    print_success "Pre-deployment tests completed"
}

cleanup() {
    print_info "Cleaning up temporary files..."
    rm -rf ${TEMP_DIR}
    print_success "Cleanup completed"
}

main() {
    print_header

    # Set up trap for cleanup
    trap cleanup EXIT

    # Check prerequisites
    check_prerequisites

    # Build site
    build_site

    # Run tests
    run_tests

    # Deploy based on arguments or show menu
    if [ $# -eq 0 ]; then
        show_deployment_menu
    else
        case $1 in
            netlify) deploy_netlify ;;
            github|gh-pages) deploy_github_pages ;;
            s3|aws) deploy_aws_s3 ;;
            ftp) deploy_ftp ;;
            rsync) deploy_rsync ;;
            docker) deploy_docker ;;
            all) deploy_all ;;
            *) print_error "Unknown deployment target: $1" && exit 1 ;;
        esac
    fi

    echo ""
    print_success "Deployment completed successfully!"
    print_info "Site is now live and accessible to users."
}

# Run main function with all arguments
main "$@"
