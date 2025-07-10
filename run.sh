#!/bin/bash

# Islaind Hugo Theme Development Script
# This script helps manage the Hugo site development with Islaind theme

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_help() {
    echo -e "${BLUE}Islaind Hugo Theme Site Manager${NC}"
    echo ""
    echo "Usage: ./run.sh [command]"
    echo ""
    echo "Commands:"
    echo -e "  ${GREEN}serve${NC}      Start development server"
    echo -e "  ${GREEN}build${NC}      Build site for production"
    echo -e "  ${GREEN}clean${NC}      Clean build artifacts"
    echo -e "  ${GREEN}new${NC}        Create new content (interactive)"
    echo -e "  ${GREEN}deploy${NC}     Deploy to production"
    echo -e "  ${GREEN}check${NC}      Check site health"
    echo -e "  ${GREEN}setup${NC}      Initial setup"
    echo -e "  ${GREEN}help${NC}       Show this help"
    echo ""
}

check_hugo() {
    if ! command -v hugo &> /dev/null; then
        echo -e "${RED}Error: Hugo is not installed${NC}"
        echo "Please install Hugo: https://gohugo.io/getting-started/installing/"
        exit 1
    fi

    HUGO_VERSION=$(hugo version | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    echo -e "${GREEN}Hugo version: ${HUGO_VERSION}${NC}"
}

serve() {
    echo -e "${BLUE}Starting development server...${NC}"
    check_hugo

    # Start Hugo server with live reload
    hugo server -D \
        --bind 0.0.0.0 \
        --baseURL http://localhost:1313 \
        --navigateToChanged \
        --templateMetrics \
        --templateMetricsHints \
        --watch \
        --verbose
}

build() {
    echo -e "${BLUE}Building site for production...${NC}"
    check_hugo

    # Clean previous build
    rm -rf public/

    # Build with minification
    hugo --minify \
        --cleanDestinationDir \
        --templateMetrics \
        --verbose

    echo -e "${GREEN}Site built successfully in public/directory${NC}"

    # Show build statistics
    if [ -d "public" ]; then
        echo -e "${YELLOW}Build Statistics:${NC}"
        echo "Total files: $(find public -type f | wc -l)"
        echo "Total size: $(du -sh public | cut -f1)"
        echo "HTML files: $(find public -name "*.html" | wc -l)"
        echo "CSS files: $(find public -name "*.css" | wc -l)"
        echo "JS files: $(find public -name "*.js" | wc -l)"
        echo "Images: $(find public -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.svg" | wc -l)"
    fi
}

clean() {
    echo -e "${BLUE}Cleaning build artifacts...${NC}"

    # Remove build directories
    rm -rf public/
    rm -rf resources/
    rm -rf .hugo_build.lock

    echo -e "${GREEN}Clean completed${NC}"
}

new_content() {
    echo -e "${BLUE}Creating new content...${NC}"
    check_hugo

    echo "What type of content would you like to create?"
    echo "1. Page"
    echo "2. Blog post"
    echo "3. Speaker profile"
    echo "4. Custom"

    read -p "Enter your choice (1-4): " choice

    case $choice in
        1)
            read -p "Enter page name (e.g., 'about'): " name
            hugo new "${name}.md"
            ;;
        2)
            read -p "Enter blog post title (e.g., 'my-first-post'): " title
            hugo new "blog/${title}.md"
            ;;
        3)
            read -p "Enter speaker name (e.g., 'john-doe'): " speaker
            hugo new "speakers/${speaker}.md"
            ;;
        4)
            read -p "Enter content path (e.g., 'section/content-name'): " path
            hugo new "${path}.md"
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            exit 1
            ;;
    esac

    echo -e "${GREEN}Content created successfully${NC}"
}

deploy() {
    echo -e "${BLUE}Deploying to production...${NC}"

    # Build first
    build

    # Check if we have deployment configuration
    if [ -f "deploy.sh" ]; then
        echo -e "${YELLOW}Running custom deployment script...${NC}"
        ./deploy.sh
    else
        echo -e "${YELLOW}No deployment configuration found${NC}"
        echo "Available deployment options:"
        echo "1. Create deploy.sh script for custom deployment"
        echo "2. Use Netlify: netlify deploy --prod --dir=public"
        echo "3. Use GitHub Pages: commit and push to main branch"
        echo "4. Use AWS S3: aws s3 sync public/ s3://your-bucket --delete"
    fi
}

check_site() {
    echo -e "${BLUE}Checking site health...${NC}"
    check_hugo

    echo -e "${YELLOW}Configuration Check:${NC}"
    if [ -f "config.yaml" ]; then
        echo "✓ Configuration file exists"
    else
        echo "✗ Configuration file missing"
    fi

    if [ -d "content" ]; then
        echo "✓ Content directory exists"
        echo "  - Pages: $(find content -name "*.md" | wc -l)"
    else
        echo "✗ Content directory missing"
    fi

    if [ -d "themes/fortify" ]; then
        echo "✓ Theme directory exists"
    else
        echo "✗ Theme directory missing"
    fi

    if [ -d "static" ]; then
        echo "✓ Static directory exists"
    else
        echo "✗ Static directory missing"
    fi

    echo -e "${YELLOW}Theme Check:${NC}"
    if [ -f "themes/fortify/theme.toml" ]; then
        echo "✓ Theme configuration exists"
    else
        echo "✗ Theme configuration missing"
    fi

    if [ -f "themes/fortify/static/css/style.css" ]; then
        echo "✓ Theme CSS exists"
    else
        echo "✗ Theme CSS missing"
    fi

    if [ -f "themes/fortify/static/js/main.js" ]; then
        echo "✓ Theme JavaScript exists"
    else
        echo "✗ Theme JavaScript missing"
    fi

    echo -e "${YELLOW}Content Check:${NC}"
    if [ -f "content/_index.md" ]; then
        echo "✓ Homepage content exists"
    else
        echo "✗ Homepage content missing"
    fi

    # Check for required images
    echo -e "${YELLOW}Asset Check:${NC}"
    required_images=("logo.png" "favicon.png" "hero-bg.jpg" "meta-image.jpg")
    for image in "${required_images[@]}"; do
        if [ -f "static/images/${image}" ] || [ -f "themes/fortify/static/images/${image}" ]; then
            echo "✓ ${image} exists"
        else
            echo "✗ ${image} missing"
        fi
    done

    echo -e "${GREEN}Site check completed${NC}"
}

setup() {
    echo -e "${BLUE}Setting up development environment...${NC}"

    # Check Hugo installation
    check_hugo

    # Create necessary directories
    mkdir -p content/blog
    mkdir -p content/speakers
    mkdir -p static/images
    mkdir -p layouts

    # Create sample images directory structure
    echo -e "${YELLOW}Creating sample image placeholders...${NC}"
    touch static/images/logo.png
    touch static/images/favicon.png
    touch static/images/hero-bg.jpg
    touch static/images/meta-image.jpg
    touch static/images/about-conference.jpg

    # Make scripts executable
    chmod +x run.sh

    echo -e "${GREEN}Setup completed!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Add your images to static/images/"
    echo "2. Customize config.yaml with your information"
    echo "3. Run './run.sh serve' to start development"
    echo "4. Edit content files in content/ directory"
}

# Main script logic
case "${1:-help}" in
    serve|server|dev)
        serve
        ;;
    build|production)
        build
        ;;
    clean)
        clean
        ;;
    new|create)
        new_content
        ;;
    deploy)
        deploy
        ;;
    check|health)
        check_site
        ;;
    setup|init)
        setup
        ;;
    help|--help|-h)
        print_help
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        print_help
        exit 1
        ;;
esac
