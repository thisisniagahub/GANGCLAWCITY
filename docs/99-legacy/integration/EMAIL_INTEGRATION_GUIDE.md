# 📧 Email Capture Integration Guide

**Complete guide untuk connect email form ke backend**

---

## 🎯 Option 1: Mailchimp (Recommended for Beginners)

### **Step 1: Create Mailchimp Account**

1. Go to https://mailchimp.com
2. Click "Sign Up Free"
3. Enter email and create account
4. Verify email

### **Step 2: Create Audience**

1. Click "Audience" in left sidebar
2. Click "Create Audience"
3. Fill in:
   - Audience name: "GANGCLAWCITY Waitlist"
   - Default from email: your@email.com
   - Default from name: GANGCLAWCITY Team

### **Step 3: Create Signup Form**

1. In Audience dashboard, click "Signup forms"
2. Click "Embedded forms"
3. Choose "Classic" form
4. Copy the form action URL

**Example:**
```
https://yourname.us1.list-manage.com/subscribe/post?u=abc123&id=xyz789
```

### **Step 4: Update Landing Page**

Edit `landing-page/index.html`:

```html
<!-- Replace this line -->
<form class="email-form" id="waitlist-form" action="#" method="POST">

<!-- With your Mailchimp URL -->
<form class="email-form" id="waitlist-form" 
      action="https://yourname.us1.list-manage.com/subscribe/post?u=abc123&id=xyz789" 
      method="POST"
      target="_blank">
```

### **Step 5: Add Hidden Fields (Optional)**

```html
<form class="email-form" id="waitlist-form" 
      action="YOUR_MAILCHIMP_URL" 
      method="POST"
      target="_blank">
  
  <!-- Hidden field for group interest -->
  <input type="hidden" name="group[12345][67890]" value="checked">
  
  <!-- Your existing email field -->
  <input type="email" name="EMAIL" required class="email-input">
  
  <!-- Submit button -->
  <button type="submit" class="email-submit">
    Get Early Access
  </button>
</form>
```

**Note:** Mailchimp requires `name="EMAIL"` for the email field.

---

## 🎯 Option 2: Supabase (Recommended for Custom Backend)

### **Step 1: Create Supabase Project**

1. Go to https://supabase.com
2. Click "Start your project"
3. Create new project:
   - Name: GANGCLAWCITY
   - Database password: (save this!)
   - Region: Choose closest to you

### **Step 2: Create Waitlist Table**

In Supabase SQL Editor:

```sql
-- Create waitlist table
CREATE TABLE waitlist (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT UNIQUE NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  source TEXT DEFAULT 'landing_page',
  metadata JSONB DEFAULT '{}'::jsonb
);

-- Create index for faster queries
CREATE INDEX idx_waitlist_email ON waitlist(email);
CREATE INDEX idx_waitlist_created ON waitlist(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Allow anyone to insert (for public signup)
CREATE POLICY "Anyone can add email" 
  ON waitlist 
  FOR INSERT 
  WITH CHECK (true);

-- Allow anyone to read (optional, for admin)
CREATE POLICY "Anyone can view" 
  ON waitlist 
  FOR SELECT 
  USING (true);
```

### **Step 3: Get API Credentials**

1. Go to Settings → API
2. Copy:
   - Project URL: `https://xxxxx.supabase.co`
   - `anon` public key: `eyJhbG...`

### **Step 4: Update Landing Page JavaScript**

Edit `landing-page/script.js`:

```javascript
// ─── Email Capture Form ────────────────────────────────────
const waitlistForm = document.getElementById('waitlist-form');
const successMessage = document.getElementById('success-message');

if (waitlistForm) {
  waitlistForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const emailInput = document.getElementById('email');
    const email = emailInput.value;
    
    // Show loading state
    const submitBtn = waitlistForm.querySelector('.email-submit');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<span>Submitting...</span>';
    submitBtn.disabled = true;
    
    try {
      // Send to Supabase
      const response = await fetch('https://YOUR-PROJECT.supabase.co/rest/v1/waitlist', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': 'YOUR-ANON-KEY',
          'Authorization': 'Bearer YOUR-ANON-KEY'
        },
        body: JSON.stringify({
          email: email,
          source: 'landing_page',
          metadata: {
            userAgent: navigator.userAgent,
            timestamp: new Date().toISOString()
          }
        })
      });
      
      if (response.ok) {
        // Success!
        waitlistForm.style.display = 'none';
        successMessage.style.display = 'block';
        console.log('✅ Email saved to Supabase:', email);
      } else {
        const error = await response.json();
        throw new Error(error.message || 'Failed to save email');
      }
    } catch (error) {
      console.error('❌ Error:', error);
      alert('Sorry, something went wrong. Please try again.');
      
      // Reset button
      submitBtn.innerHTML = originalText;
      submitBtn.disabled = false;
    }
  });
}
```

### **Step 5: Test Integration**

1. Open landing page: http://localhost:8080
2. Enter test email
3. Submit form
4. Check Supabase dashboard → Table Editor → waitlist

---

## 🎯 Option 3: Google Forms (Simplest - Free!)

### **Step 1: Create Google Form**

1. Go to https://forms.google.com
2. Click "+ Create new form"
3. Add title: "GANGCLAWCITY Waitlist"
4. Add question:
   - Type: Short answer
   - Question: "Email address"
   - Required: ✓

### **Step 2: Get Form URL**

1. Click "Send" button (top right)
2. Click link icon 🔗
3. Check "Shorten URL"
4. Copy URL

**Example:**
```
https://docs.google.com/forms/d/e/1FAIpQLSd.../viewform
```

### **Step 3: Replace Form in Landing Page**

Edit `landing-page/index.html`:

```html
<!-- Replace entire form section with Google Form embed -->
<div class="email-capture reveal">
  <h3>🚀 Join the Waitlist</h3>
  <p>Be the first to access GANGCLAWCITY.</p>
  
  <!-- Embed Google Form -->
  <iframe 
    src="YOUR_GOOGLE_FORM_URL?embedded=true" 
    width="100%" 
    height="300" 
    frameborder="0" 
    marginheight="0" 
    marginwidth="0"
    style="border-radius: 12px;"
  >
    Loading…
  </iframe>
</div>
```

---

## 🎯 Option 4: Formspree (Free, No Backend!)

### **Step 1: Create Formspree Account**

1. Go to https://formspree.io
2. Sign up free
3. Create new form

### **Step 2: Get Form Endpoint**

You'll get URL like:
```
https://formspree.io/f/xyzaabcd
```

### **Step 3: Update Form**

Edit `landing-page/index.html`:

```html
<form 
  class="email-form" 
  action="https://formspree.io/f/xyzaabcd" 
  method="POST"
>
  <div class="email-input-group">
    <input
      type="email"
      name="email"
      placeholder="Enter your email"
      required
      class="email-input"
    />
    <button type="submit" class="email-submit">
      Get Early Access
    </button>
  </div>
  <p class="email-privacy">
    🔒 No spam. Unsubscribe anytime.
  </p>
</form>
```

**Done!** Emails will be sent to your Formspree inbox.

---

## 🎯 Option 5: Self-Hosted Backend (Node.js + Express)

### **Step 1: Create Backend Server**

Create `backend/server.js`:

```javascript
const express = require('express');
const cors = require('cors');
const sqlite3 = require('sqlite3').verbose();

const app = express();
const PORT = 3001;

// Middleware
app.use(cors());
app.use(express.json());

// Create database
const db = new sqlite3.Database('./waitlist.db');

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS waitlist (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE NOT NULL,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    )
  `);
});

// Submit email endpoint
app.post('/api/waitlist', (req, res) => {
  const { email } = req.body;
  
  if (!email || !email.includes('@')) {
    return res.status(400).json({ error: 'Invalid email' });
  }
  
  db.run(
    'INSERT INTO waitlist (email) VALUES (?)',
    [email],
    function(err) {
      if (err) {
        if (err.message.includes('UNIQUE')) {
          return res.status(409).json({ error: 'Email already registered' });
        }
        return res.status(500).json({ error: 'Database error' });
      }
      
      res.json({ 
        success: true, 
        message: 'Email added to waitlist',
        id: this.lastID 
      });
    }
  );
});

// Get all emails (admin)
app.get('/api/waitlist', (req, res) => {
  db.all('SELECT * FROM waitlist ORDER BY created_at DESC', (err, rows) => {
    if (err) {
      return res.status(500).json({ error: 'Database error' });
    }
    res.json(rows);
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`✅ Backend running on http://localhost:${PORT}`);
});
```

### **Step 2: Install Dependencies**

```bash
npm init -y
npm install express cors sqlite3
```

### **Step 3: Start Backend**

```bash
node backend/server.js
```

### **Step 4: Update Landing Page**

Edit `landing-page/script.js`:

```javascript
const response = await fetch('http://localhost:3001/api/waitlist', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({ email })
});
```

---

## 📊 Comparison Table

| Option | Difficulty | Cost | Best For |
|--------|-----------|------|----------|
| **Mailchimp** | ⭐ Easy | Free < 2K contacts | Email marketing |
| **Supabase** | ⭐⭐ Medium | Free tier | Custom backend |
| **Google Forms** | ⭐ Easiest | Free | Quick validation |
| **Formspree** | ⭐ Easy | Free 50/month | Simple forms |
| **Self-Hosted** | ⭐⭐⭐ Hard | Free + hosting | Full control |

---

## ✅ Testing Checklist

After integration:

- [ ] Form submits without errors
- [ ] Success message appears
- [ ] Email saved to database/list
- [ ] Duplicate emails handled
- [ ] Invalid emails rejected
- [ ] Mobile responsive
- [ ] Privacy policy linked

---

## 🔒 Security Best Practices

1. **Rate Limiting:**
   ```javascript
   // Limit to 5 submissions per IP per hour
   const rateLimit = require('express-rate-limit');
   
   const limiter = rateLimit({
     windowMs: 60 * 60 * 1000, // 1 hour
     max: 5
   });
   
   app.use('/api/waitlist', limiter);
   ```

2. **Email Validation:**
   ```javascript
   const validator = require('validator');
   
   if (!validator.isEmail(email)) {
     return res.status(400).json({ error: 'Invalid email' });
   }
   ```

3. **CAPTCHA (Optional):**
   ```html
   <!-- Add reCAPTCHA -->
   <div class="g-recaptcha" data-sitekey="YOUR_SITE_KEY"></div>
   ```

---

## 📈 Analytics Integration

Track conversions:

```javascript
// After successful submission
if (typeof gtag !== 'undefined') {
  gtag('event', 'waitlist_signup', {
    event_category: 'conversion',
    event_label: 'Email captured'
  });
}

// Or for Facebook Pixel
if (typeof fbq !== 'undefined') {
  fbq('track', 'Lead');
}
```

---

**Status:** Ready to integrate  
**Time:** 10-30 minutes depending on option  
**Difficulty:** ⭐⭐ (Easy-Medium)

---

**🏙️ GANGCLAWCITY** — Built with ❤️ in Malaysia 🇲🇾
