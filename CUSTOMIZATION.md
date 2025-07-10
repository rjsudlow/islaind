# Islaind Theme Customization Guide

This guide provides detailed instructions for customizing the Islaind Hugo theme to match your conference branding and requirements.

## 🎨 Quick Theme Customization

### 1. Basic Information Setup

First, update your basic conference information in `config.yaml`:

```yaml
baseURL: "https://yourconference.com"
title: "Your Conference Name 2024"
theme: "islaind"

params:
  author: "Your Organization"
  description: "Your conference description"
  email: "info@yourconference.com"
  phone: "+1-xxx-xxx-xxxx"
  address: "Your Conference Location"
```

### 2. Color Scheme Customization

The Islaind theme uses CSS custom properties (variables) for easy color customization. Edit `themes/islaind/static/css/style.css`:

```css
:root {
  /* Primary Brand Colors */
  --primary-color: #ff6b6b;        /* Main accent color */
  --primary-dark: #ee5a52;         /* Darker shade */
  --primary-light: #ff8e8e;        /* Lighter shade */
  --secondary-color: #4ecdc4;      /* Secondary accent */
  --secondary-dark: #45b7aa;       /* Secondary dark */
  --secondary-light: #6dd5ce;      /* Secondary light */

  /* Regional Theme Colors */
  --caribbean-blue: #00a8cc;       /* Ocean blue */
  --caribbean-teal: #0077b6;       /* Deep teal */
  --caribbean-coral: #ff6b6b;      /* Coral reef */
  --caribbean-gold: #ffd166;       /* Sunset gold */
  --caribbean-green: #06d6a0;      /* Tropical green */
  --caribbean-sunset: #f72585;     /* Sunset pink */
}
```

#### Popular Color Schemes:

**Tech Conference (Blue/Purple):**
```css
--primary-color: #667eea;
--primary-dark: #5a6fd8;
--secondary-color: #764ba2;
```

**Security Conference (Red/Orange):**
```css
--primary-color: #ff6b6b;
--primary-dark: #ee5a52;
--secondary-color: #ffa726;
```

**Academic Conference (Green/Teal):**
```css
--primary-color: #26a69a;
--primary-dark: #00796b;
--secondary-color: #66bb6a;
```

### 3. Typography Customization

Change fonts by updating the font variables:

```css
:root {
  --font-primary: "Montserrat", sans-serif;    /* Headers */
  --font-secondary: "Open Sans", sans-serif;   /* Body text */
  --font-mono: "Fira Code", monospace;         /* Code */
}
```

Add Google Fonts in `themes/islaind/layouts/_default/baseof.html`:

```html
<!-- Add before closing </head> tag -->
<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;600;700&family=Open+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
```

### 4. Logo and Branding

1. **Replace the logo:**
   - Add your logo to `static/images/logo.png`
   - Recommended size: 300x100px (PNG with transparency)

2. **Update configuration:**
```yaml
params:
  logo: "images/logo.png"
  logo_width: "200px"  # Adjust as needed
  favicon: "images/favicon.png"
```

3. **Custom logo styling:**
```css
.navbar-brand img {
  max-height: 50px;
  width: auto;
}
```

## 🏠 Homepage Customization

### Hero Section

The hero section is controlled by both configuration and templates:

**Configuration (config.yaml):**
```yaml
params:
  hero:
    enable: true
    title: "Your Conference Name 2024"
    subtitle: "Join us for the premier event in your field"
    background_image: "images/hero-bg.jpg"
    button_text: "Register Now"
    button_link: "/pricing"
```

**Custom Hero Background:**
```css
.hero-section {
  background: linear-gradient(
    135deg,
    var(--primary-color),
    var(--secondary-color)
  );
  /* Or use an image */
  background-image: url('/images/your-hero-bg.jpg');
  background-size: cover;
  background-position: center;
}
```

### About Section

Edit the about section in `themes/islaind/layouts/index.html`:

```html
<section id="about" class="about-section py-5">
  <div class="container">
    <div class="row align-items-center">
      <div class="col-lg-6 mb-4 mb-lg-0">
        <div class="about-content">
          <h2 class="section-title" data-aos="fade-right">
            About Your Conference
          </h2>
          <p class="lead" data-aos="fade-right" data-aos-delay="100">
            Your conference description here...
          </p>
          <!-- Add your feature items here -->
        </div>
      </div>
      <div class="col-lg-6">
        <div class="about-image" data-aos="fade-left">
          <img src="images/about-conference.jpg" alt="Conference" class="img-fluid rounded">
        </div>
      </div>
    </div>
  </div>
</section>
```

### Statistics Section

Update the stats in `themes/islaind/layouts/index.html`:

```html
<div class="row">
  <div class="col-lg-3 col-md-6 mb-4" data-aos="fade-up">
    <div class="stat-item text-center">
      <div class="stat-number">500+</div>
      <div class="stat-label">Attendees</div>
    </div>
  </div>
  <!-- Add more stat items -->
</div>
```

## 🎤 Speakers Section

### Adding Speakers

Create speaker files in `content/speakers/`:

```bash
hugo new speakers/jane-doe.md
```

**Speaker file format:**
```markdown
---
title: "Dr. Jane Doe"
role: "Chief Technology Officer"
company: "Tech Corp"
image: "images/speakers/jane-doe.jpg"
bio: "Dr. Jane Doe is a renowned expert in cybersecurity..."
twitter: "https://twitter.com/janedoe"
linkedin: "https://linkedin.com/in/janedoe"
website: "https://janedoe.com"
weight: 1
---

Extended biography content goes here...
```

### Speaker Card Styling

Customize speaker cards:

```css
.speaker-card {
  border-radius: var(--border-radius-lg);
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
}

.speaker-card:hover {
  transform: translateY(-10px);
  box-shadow: var(--shadow-lg);
}

.speaker-image {
  height: 300px;
  overflow: hidden;
}

.speaker-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
```

## 📅 Schedule Section

### Schedule Configuration

The schedule uses Bootstrap tabs. Customize in `themes/islaind/layouts/index.html`:

```html
<div class="schedule-nav" data-aos="fade-up">
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item" role="presentation">
      <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#day1">
        <span class="day-number">Day 1</span>
        <span class="day-date">March 15</span>
      </button>
    </li>
    <!-- Add more days -->
  </ul>
</div>
```

### Schedule Content

Add schedule items:

```html
<div class="schedule-item">
  <div class="schedule-time">9:00 AM</div>
  <div class="schedule-info">
    <h5>Session Title</h5>
    <p>Session description</p>
    <span class="speaker-name">Speaker Name</span>
  </div>
</div>
```

## 🏢 Sponsors Section

### Adding Sponsors

1. **Add sponsor logos** to `static/images/sponsors/`
2. **Update the sponsors section** in `themes/islaind/layouts/index.html`:

```html
<div class="sponsor-tier" data-aos="fade-up">
  <h4 class="tier-title">Platinum Sponsors</h4>
  <div class="sponsor-logos">
    <div class="sponsor-logo">
      <img src="images/sponsors/sponsor-1.png" alt="Sponsor 1" class="img-fluid">
    </div>
    <!-- Add more sponsors -->
  </div>
</div>
```

### Sponsor Logo Styling

```css
.sponsor-logo {
  background: var(--white);
  padding: 1.5rem;
  border-radius: var(--border-radius);
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  max-width: 200px;
}

.sponsor-logo img {
  width: 100%;
  height: auto;
  max-height: 60px;
  object-fit: contain;
  filter: grayscale(1);
  transition: var(--transition);
}

.sponsor-logo:hover img {
  filter: grayscale(0);
}
```

## 🎨 Advanced Styling

### Custom Sections

Add new sections to your homepage:

```html
<section id="custom-section" class="py-5">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8 text-center mb-5">
        <h2 class="section-title" data-aos="fade-up">
          Custom Section Title
        </h2>
        <p class="section-subtitle" data-aos="fade-up" data-aos-delay="100">
          Custom section description
        </p>
      </div>
    </div>
    <div class="row">
      <!-- Your custom content here -->
    </div>
  </div>
</section>
```

### Custom CSS Classes

Add utility classes:

```css
/* Custom backgrounds */
.bg-gradient-primary {
  background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
}

.bg-gradient-secondary {
  background: linear-gradient(135deg, var(--secondary-color), var(--secondary-dark));
}

/* Custom text styles */
.text-gradient {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

/* Custom buttons */
.btn-gradient {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  border: none;
  color: white;
  position: relative;
  overflow: hidden;
}

.btn-gradient::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
  transition: left 0.5s;
}

.btn-gradient:hover::before {
  left: 100%;
}
```

## 📱 Mobile Customization

### Responsive Design

Customize mobile breakpoints:

```css
/* Mobile First */
@media (max-width: 575px) {
  .hero-title {
    font-size: 2rem;
  }
  
  .section-title {
    font-size: 1.75rem;
  }
}

/* Tablet */
@media (min-width: 576px) and (max-width: 767px) {
  .hero-title {
    font-size: 2.5rem;
  }
}

/* Desktop */
@media (min-width: 768px) {
  .hero-title {
    font-size: 3.5rem;
  }
}
```

### Mobile Navigation

Customize mobile menu:

```css
@media (max-width: 991px) {
  .navbar-nav {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: var(--border-radius);
    padding: 1rem;
    margin-top: 1rem;
  }
  
  .navbar-nav .nav-link {
    padding: 0.75rem 1rem;
    border-radius: var(--border-radius);
  }
}
```

## 🔧 JavaScript Customization

### Custom Event Handlers

Add to `themes/islaind/static/js/main.js`:

```javascript
// Custom initialization
document.addEventListener('DOMContentLoaded', function() {
  // Your custom JavaScript here
  initCustomFeatures();
});

function initCustomFeatures() {
  // Custom smooth scrolling
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth',
          block: 'start'
        });
      }
    });
  });

  // Custom form handling
  const forms = document.querySelectorAll('.custom-form');
  forms.forEach(form => {
    form.addEventListener('submit', handleFormSubmit);
  });
}

function handleFormSubmit(event) {
  event.preventDefault();
  // Custom form submission logic
  console.log('Form submitted!');
}
```

### Animation Customization

Customize AOS animations:

```javascript
// Initialize AOS with custom settings
AOS.init({
  duration: 1200,
  easing: 'ease-in-out-cubic',
  once: true,
  offset: 100,
  delay: 100
});

// Custom animations
function animateOnScroll() {
  const elements = document.querySelectorAll('.animate-on-scroll');
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('animated');
      }
    });
  });

  elements.forEach(element => {
    observer.observe(element);
  });
}
```

## 📊 Analytics and Tracking

### Google Analytics Setup

Add to `config.yaml`:

```yaml
params:
  google_analytics_id: "GA-XXXXXXXXX"
```

### Custom Event Tracking

```javascript
// Track custom events
function trackEvent(eventName, category, label) {
  if (typeof gtag !== 'undefined') {
    gtag('event', eventName, {
      event_category: category,
      event_label: label
    });
  }
}

// Track registration clicks
document.querySelectorAll('.register-btn').forEach(button => {
  button.addEventListener('click', function() {
    trackEvent('registration_click', 'engagement', 'hero_button');
  });
});
```

## 🔍 SEO Customization

### Meta Tags

Add custom meta tags in `themes/islaind/layouts/_default/baseof.html`:

```html
<head>
  <!-- Your custom meta tags -->
  <meta name="keywords" content="conference, cybersecurity, caribbean, tech">
  <meta name="author" content="Your Organization">
  <meta name="robots" content="index, follow">
  
  <!-- Open Graph -->
  <meta property="og:site_name" content="{{ .Site.Title }}">
  <meta property="og:locale" content="en_US">
  
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content="@yourhandle">
</head>
```

### Structured Data

Add event structured data:

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Event",
  "name": "{{ .Site.Title }}",
  "startDate": "2024-03-15",
  "endDate": "2024-03-17",
  "eventStatus": "https://schema.org/EventScheduled",
  "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode",
  "location": {
    "@type": "Place",
    "name": "Conference Venue",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Nassau",
      "addressRegion": "Bahamas"
    }
  },
  "image": "{{ .Site.BaseURL }}images/meta-image.jpg",
  "description": "{{ .Site.Params.description }}",
  "organizer": {
    "@type": "Organization",
    "name": "{{ .Site.Params.author }}",
    "email": "{{ .Site.Params.email }}"
  }
}
</script>
```

## 🌍 Multi-language Support

### Language Configuration

Add to `config.yaml`:

```yaml
defaultContentLanguage: "en"
languages:
  en:
    title: "Caribbean Security Conference"
    weight: 1
    params:
      description: "Premier cybersecurity conference"
  es:
    title: "Conferencia de Seguridad del Caribe"
    weight: 2
    params:
      description: "Conferencia premier de ciberseguridad"
```

### Translation Files

Create `i18n/en.yaml`:

```yaml
- id: register_now
  translation: "Register Now"
- id: learn_more
  translation: "Learn More"
- id: speakers
  translation: "Speakers"
- id: schedule
  translation: "Schedule"
- id: contact
  translation: "Contact"
```

Create `i18n/es.yaml`:

```yaml
- id: register_now
  translation: "Registrarse Ahora"
- id: learn_more
  translation: "Saber Más"
- id: speakers
  translation: "Oradores"
- id: schedule
  translation: "Horario"
- id: contact
  translation: "Contacto"
```

### Using Translations

In templates:

```html
<a href="/pricing" class="btn btn-primary">
  {{ i18n "register_now" }}
</a>
```

## 🔧 Performance Optimization

### Image Optimization

```css
/* Lazy loading placeholder */
.lazy-image {
  background: linear-gradient(45deg, #f0f0f0, #e0e0e0);
  background-size: 400% 400%;
  animation: loading 2s ease-in-out infinite;
}

@keyframes loading {
  0% { background-position: 0% 50%; }
  50% { background-position: 100% 50%; }
  100% { background-position: 0% 50%; }
}

/* Responsive images */
.responsive-image {
  width: 100%;
  height: auto;
  max-width: 100%;
}
```

### CSS Optimization

```css
/* Critical CSS - Load first */
.hero-section,
.navbar,
.section-title {
  /* Your critical styles */
}

/* Non-critical CSS - Load later */
.animation-class,
.fancy-effects {
  /* Your non-critical styles */
}
```

## 📋 Deployment Checklist

Before deploying your customized theme:

- [ ] Update all placeholder content
- [ ] Replace all placeholder images
- [ ] Update contact information
- [ ] Test on mobile devices
- [ ] Verify all links work
- [ ] Check loading speed
- [ ] Test form submissions
- [ ] Verify social media links
- [ ] Check SEO meta tags
- [ ] Test accessibility
- [ ] Review color contrast
- [ ] Test with screen readers
- [ ] Validate HTML/CSS
- [ ] Test cross-browser compatibility

## 🆘 Common Issues and Solutions

### Issue: Images not loading
**Solution:** Check file paths and ensure images are in `static/images/`

### Issue: CSS not applying
**Solution:** Clear browser cache and check for CSS syntax errors

### Issue: JavaScript errors
**Solution:** Check browser console and verify all dependencies are loaded

### Issue: Mobile layout issues
**Solution:** Test Bootstrap grid classes and responsive utilities

### Issue: Font loading problems
**Solution:** Verify Google Fonts URLs and fallback fonts

## 📞 Support

For additional help with customization:

- **Documentation**: Check the main README.md
- **Issues**: Report bugs on GitHub
- **Community**: Join the Hugo community forums
- **Professional Support**: Contact the theme developers

---

**Happy customizing! 🎨**

Remember to backup your customizations before major updates to the theme.