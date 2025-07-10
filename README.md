# Islaind Hugo Theme - Caribbean Conference Website

A modern, vibrant Hugo theme designed specifically for conferences and events, featuring Caribbean-inspired design elements and comprehensive conference functionality.

## 🏝️ Theme Overview

Islaind is a responsive Hugo theme built for conferences, events, and professional gatherings. It features:

- **Caribbean-inspired color palette** with corals, teals, and tropical accents
- **Modern, clean design** with smooth animations and micro-interactions
- **Fully responsive** mobile-first design
- **Conference-focused sections** including speakers, schedule, pricing, and sponsors
- **SEO optimized** with structured data and meta tags
- **Fast loading** with optimized assets and lazy loading
- **Accessibility compliant** with ARIA labels and semantic HTML

## 🚀 Quick Start

### Prerequisites
- Hugo v0.100.0 or higher
- Git (for cloning and version control)
- Node.js (optional, for advanced asset processing)

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/islaind-hugo-theme.git
cd islaind-hugo-theme
```

2. **Start the development server:**
```bash
hugo server -D
```

3. **Visit your site:**
Open http://localhost:1313 in your browser

### Building for Production

```bash
hugo --minify
```

## 📁 Project Structure

```
islaind-hugo-theme/
├── config.yaml                 # Main configuration
├── content/                    # Site content
│   ├── _index.md              # Homepage content
│   ├── about.md               # About page
│   ├── speakers.md            # Speakers page
│   ├── schedule.md            # Schedule page
│   ├── pricing.md             # Pricing/Registration
│   └── contact.md             # Contact page
├── themes/islaind/            # Theme directory
│   ├── layouts/               # HTML templates
│   │   ├── _default/          # Default layouts
│   │   ├── partials/          # Reusable components
│   │   └── index.html         # Homepage template
│   ├── static/                # Static assets
│   │   ├── css/               # Stylesheets
│   │   ├── js/                # JavaScript files
│   │   └── images/            # Theme images
│   └── theme.toml             # Theme metadata
├── static/                    # Your site assets
│   └── images/                # Your images
├── run.sh                     # Development helper script
├── deploy.sh                  # Deployment script
└── README.md                  # This file
```

## 🎨 Theme Customization

### 1. Site Configuration

Edit `config.yaml` to customize your conference:

```yaml
baseURL: "https://yourconference.com"
title: "Your Conference Name"
theme: "islaind"

params:
  # Basic Information
  author: "Your Organization"
  description: "Your conference description"
  email: "info@yourconference.com"
  phone: "+1-xxx-xxx-xxxx"
  
  # Hero Section
  hero:
    title: "Your Conference Title"
    subtitle: "Your conference tagline"
    background_image: "images/hero-bg.jpg"
    button_text: "Register Now"
    button_link: "/pricing"
  
  # Social Media
  social:
    twitter: "https://twitter.com/yourconf"
    facebook: "https://facebook.com/yourconf"
    linkedin: "https://linkedin.com/company/yourconf"
    instagram: "https://instagram.com/yourconf"
```

### 2. Color Scheme Customization

Edit `themes/islaind/static/css/style.css` to change colors:

```css
:root {
  /* Primary Colors - Change these for your brand */
  --primary-color: #ff6b6b;        /* Main accent color */
  --primary-dark: #ee5a52;         /* Darker shade */
  --primary-light: #ff8e8e;        /* Lighter shade */
  --secondary-color: #4ecdc4;      /* Secondary accent */
  
  /* Caribbean Colors - Adjust for your region */
  --caribbean-blue: #00a8cc;
  --caribbean-teal: #0077b6;
  --caribbean-coral: #ff6b6b;
  --caribbean-gold: #ffd166;
  --caribbean-green: #06d6a0;
}
```

### 3. Typography

Change fonts by updating the CSS variables:

```css
:root {
  --font-primary: "Your-Header-Font", sans-serif;
  --font-secondary: "Your-Body-Font", sans-serif;
}
```

Add Google Fonts in `themes/islaind/layouts/_default/baseof.html`:

```html
<link href="https://fonts.googleapis.com/css2?family=YourFont:wght@300;400;600;700&display=swap" rel="stylesheet">
```

### 4. Logo and Branding

1. **Add your logo** to `static/images/logo.png`
2. **Update configuration:**
```yaml
params:
  logo: "images/logo.png"
  logo_width: "150px"
  favicon: "images/favicon.png"
```

### 5. Navigation Menu

Customize the menu in `config.yaml`:

```yaml
menu:
  main:
    - name: "Home"
      url: "/"
      weight: 1
    - name: "About"
      url: "/about"
      weight: 2
    - name: "Speakers"
      url: "/speakers"
      weight: 3
    # Add more menu items as needed
```

## 📄 Content Management

### Adding New Pages

Create new content files in the `content/` directory:

```bash
hugo new about.md
hugo new speakers.md
hugo new blog/my-post.md
```

### Page Front Matter

Each page should include proper front matter:

```yaml
---
title: "Page Title"
description: "SEO description"
date: 2024-01-15
draft: false
image: "images/page-image.jpg"
tags: ["tag1", "tag2"]
categories: ["category1"]
---
```

### Homepage Sections

The homepage is built with multiple sections. Customize each section by:

1. **Hero Section**: Edit `config.yaml` hero parameters
2. **About Section**: Modify `content/_index.md`
3. **Speakers**: Add speaker content in `content/speakers/`
4. **Schedule**: Update `content/schedule.md`
5. **Sponsors**: Add sponsor logos to `static/images/sponsors/`

## 🖼️ Images and Assets

### Required Images

Place these images in `static/images/`:

- `logo.png` - Your conference logo (300x100px recommended)
- `favicon.png` - Site favicon (32x32px)
- `hero-bg.jpg` - Hero background (1920x1080px)
- `meta-image.jpg` - Social sharing image (1200x630px)
- `about-conference.jpg` - About section image (800x600px)

### Speaker Images

Create speaker images in `static/images/speakers/`:
- `speaker-1.jpg`, `speaker-2.jpg`, etc.
- Recommended size: 400x400px (square)
- High quality, professional headshots

### Sponsor Logos

Add sponsor logos to `static/images/sponsors/`:
- `sponsor-1.png`, `sponsor-2.png`, etc.
- Transparent PNG format preferred
- Consistent sizing (200x100px recommended)

## 🎯 Section-Specific Customization

### Hero Section

Edit the hero section in `themes/islaind/layouts/index.html`:

```html
<section id="hero" class="hero-section">
  <!-- Customize hero content here -->
</section>
```

Update CSS for hero styling:

```css
.hero-section {
  background: linear-gradient(135deg, var(--caribbean-blue), var(--caribbean-teal));
  /* Add your custom hero styles */
}
```

### Speakers Section

Add speaker profiles by creating markdown files in `content/speakers/`:

```markdown
---
title: "Dr. Jane Smith"
role: "Chief Security Officer"
company: "Tech Corp"
image: "images/speakers/jane-smith.jpg"
twitter: "https://twitter.com/janesmith"
linkedin: "https://linkedin.com/in/janesmith"
---

Dr. Jane Smith is a renowned cybersecurity expert...
```

### Schedule Section

The schedule uses Bootstrap tabs. Customize in `themes/islaind/layouts/index.html`:

```html
<div class="tab-content">
  <div class="tab-pane fade show active" id="day1">
    <!-- Add your schedule items here -->
  </div>
</div>
```

### Pricing Section

Update pricing in `content/pricing.md`:

```markdown
## Conference Tickets

### Early Bird Pricing
- **Professional Pass** - $299
- **Student Pass** - $99
- **Government/Non-Profit** - $199
```

## 🎨 Advanced Customization

### Custom CSS

Add custom styles to `themes/islaind/static/css/style.css`:

```css
/* Your custom CSS here */
.custom-section {
  background: var(--primary-color);
  padding: 60px 0;
}
```

### Custom JavaScript

Add custom JavaScript to `themes/islaind/static/js/main.js`:

```javascript
// Your custom JavaScript
document.addEventListener('DOMContentLoaded', function() {
  // Custom functionality
});
```

### New Sections

Create new sections by adding them to `themes/islaind/layouts/index.html`:

```html
<!-- Custom Section -->
<section id="custom" class="custom-section py-5">
  <div class="container">
    <div class="row">
      <div class="col-lg-12">
        <h2 class="section-title">Custom Section</h2>
        <!-- Your content here -->
      </div>
    </div>
  </div>
</section>
```

## 📱 Mobile Optimization

The theme is mobile-first, but you can further optimize:

### Custom Mobile Styles

```css
@media (max-width: 768px) {
  .hero-title {
    font-size: 2rem;
  }
  
  .custom-mobile-style {
    /* Mobile-specific styles */
  }
}
```

### Touch Interactions

Optimize for touch devices:

```css
.btn {
  min-height: 44px; /* Minimum touch target size */
  padding: 12px 24px;
}
```

## 🔧 Development Tools

### Helper Scripts

The theme includes helper scripts:

```bash
# Start development server
./run.sh serve

# Build for production
./run.sh build

# Create new content
./run.sh new

# Deploy to various platforms
./deploy.sh
```

### Live Reload

For development with live reload:

```bash
hugo server -D --navigateToChanged --templateMetrics
```

## 🚀 Deployment

### Netlify

1. Connect your repository to Netlify
2. Set build command: `hugo --minify`
3. Set publish directory: `public`
4. Deploy!

### GitHub Pages

Use the included deployment script:

```bash
./deploy.sh github
```

### Custom Server

Deploy using rsync:

```bash
# Set environment variables
export RSYNC_USER="your-user"
export RSYNC_HOST="your-server.com"
export RSYNC_PATH="/path/to/html"

./deploy.sh rsync
```

## 🔍 SEO Optimization

### Meta Tags

The theme automatically generates meta tags. Customize in `config.yaml`:

```yaml
params:
  meta_description: "Your conference description"
  meta_image: "images/meta-image.jpg"
  google_analytics_id: "GA-XXXXXXXXX"
```

### Structured Data

Add structured data for events:

```json
{
  "@context": "https://schema.org",
  "@type": "Event",
  "name": "Your Conference",
  "startDate": "2024-03-15",
  "endDate": "2024-03-17",
  "location": {
    "@type": "Place",
    "name": "Venue Name",
    "address": "Nassau, Bahamas"
  }
}
```

## 🎭 Animation and Effects

### AOS (Animate On Scroll)

The theme uses AOS for scroll animations:

```html
<div data-aos="fade-up" data-aos-delay="100">
  <!-- Content that fades in on scroll -->
</div>
```

### Custom Animations

Add custom CSS animations:

```css
@keyframes slideIn {
  from {
    transform: translateX(-100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
}

.slide-in {
  animation: slideIn 0.5s ease-out;
}
```

## 🔧 Performance Optimization

### Image Optimization

- Use WebP format when possible
- Compress images before uploading
- Use appropriate image sizes for different screen sizes
- Implement lazy loading (already included)

### CSS/JS Optimization

- Minify CSS and JavaScript (done automatically with Hugo)
- Use CDN for external libraries
- Optimize critical rendering path

### Hugo Optimization

```yaml
# config.yaml
minify:
  disableHTML: false
  disableCSS: false
  disableJS: false
  disableJSON: false
  disableSVG: false
  disableXML: false
```

## 🌐 Internationalization

### Multi-language Support

Add language configurations:

```yaml
languages:
  en:
    title: "Caribbean Security Conference"
    weight: 1
  es:
    title: "Conferencia de Seguridad del Caribe"
    weight: 2
```

### Translation Files

Create translation files in `i18n/`:

```yaml
# i18n/en.yaml
- id: register_now
  translation: "Register Now"
- id: learn_more
  translation: "Learn More"
```

## 🐛 Troubleshooting

### Common Issues

1. **Hugo version compatibility**
   - Ensure you're using Hugo v0.100.0+
   - Check `hugo version`

2. **Images not loading**
   - Verify image paths in `static/images/`
   - Check file permissions

3. **CSS not applying**
   - Clear browser cache
   - Verify CSS file paths

4. **JavaScript errors**
   - Check browser console
   - Verify all dependencies are loaded

### Debug Mode

Enable debug mode for detailed error information:

```bash
hugo server -D --debug --verbose
```

## 📝 Content Writing Tips

### Homepage Content

- Keep hero title under 60 characters
- Write compelling, action-oriented copy
- Include clear value propositions
- Use bullet points for key features

### Speaker Profiles

- Include professional headshots
- Write 2-3 sentence bios
- Highlight relevant expertise
- Include social media links

### Schedule Content

- Be specific about times and locations
- Include session descriptions
- Mention speaker names
- Add track/category information

## 🤝 Contributing

We welcome contributions! To contribute:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Development Guidelines

- Follow existing code style
- Write descriptive commit messages
- Update documentation for new features
- Test on multiple devices/browsers

## 📄 License

This theme is licensed under the MIT License. See LICENSE file for details.

## 🆘 Support

### Documentation

- [Hugo Documentation](https://gohugo.io/documentation/)
- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [AOS Animation Library](https://michalsnik.github.io/aos/)

### Community Support

- **GitHub Issues**: Report bugs and request features
- **Discussions**: Ask questions and share ideas
- **Email**: support@islaind-theme.com

### Professional Support

For custom development and professional support:
- **Email**: pro@islaind-theme.com
- **Consultation**: Available for theme customization
- **Training**: Hugo and theme development workshops

## 🎉 Showcase

Sites using Islaind theme:
- Caribbean Security Conference
- [Add your site here]

## 📊 Analytics and Tracking

### Google Analytics

Add your GA tracking ID:

```yaml
params:
  google_analytics_id: "GA-XXXXXXXXX"
```

### Custom Events

Track custom events:

```javascript
// Custom event tracking
gtag('event', 'registration_click', {
  event_category: 'engagement',
  event_label: 'hero_button'
});
```

## 🔒 Security Considerations

- Keep Hugo and dependencies updated
- Use HTTPS for production sites
- Validate all user inputs
- Implement proper CSP headers
- Regular security audits

## 🎯 Roadmap

Upcoming features:
- [ ] Dark mode toggle
- [ ] More animation options
- [ ] Additional layout variations
- [ ] E-commerce integration
- [ ] Advanced search functionality
- [ ] Social media integration widgets

---

## 📞 Contact

For questions, support, or feedback:

- **Email**: hello@islaind-theme.com
- **Website**: https://islaind-theme.com
- **GitHub**: https://github.com/yourusername/islaind-hugo-theme
- **Twitter**: @IslaindTheme

---

**Happy conferencing! 🏝️**

Built with ❤️ for the Caribbean tech community and beyond.