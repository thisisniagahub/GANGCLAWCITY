/* =========================================
   GANGCLAWCITY Landing Page — Interactive JS
   ========================================= */

(function () {
  'use strict';

  // ─── Particle Canvas ───────────────────────────────────────
  const canvas = document.getElementById('particle-canvas');
  const ctx = canvas.getContext('2d');
  let particles = [];
  let animFrameId;

  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
  }

  function createParticles() {
    particles = [];
    const count = Math.min(Math.floor((canvas.width * canvas.height) / 18000), 80);
    for (let i = 0; i < count; i++) {
      particles.push({
        x: Math.random() * canvas.width,
        y: Math.random() * canvas.height,
        vx: (Math.random() - 0.5) * 0.3,
        vy: (Math.random() - 0.5) * 0.3,
        r: Math.random() * 1.5 + 0.5,
        color: ['#00e5ff', '#e040fb', '#ffc400'][Math.floor(Math.random() * 3)],
        alpha: Math.random() * 0.5 + 0.1,
      });
    }
  }

  function drawParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    for (let i = 0; i < particles.length; i++) {
      const p = particles[i];
      p.x += p.vx;
      p.y += p.vy;

      // Wrap around
      if (p.x < 0) p.x = canvas.width;
      if (p.x > canvas.width) p.x = 0;
      if (p.y < 0) p.y = canvas.height;
      if (p.y > canvas.height) p.y = 0;

      ctx.beginPath();
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
      ctx.fillStyle = p.color;
      ctx.globalAlpha = p.alpha;
      ctx.fill();

      // Draw connections
      for (let j = i + 1; j < particles.length; j++) {
        const q = particles[j];
        const dx = p.x - q.x;
        const dy = p.y - q.y;
        const dist = Math.sqrt(dx * dx + dy * dy);
        if (dist < 120) {
          ctx.beginPath();
          ctx.moveTo(p.x, p.y);
          ctx.lineTo(q.x, q.y);
          ctx.strokeStyle = p.color;
          ctx.globalAlpha = (1 - dist / 120) * 0.08;
          ctx.lineWidth = 0.5;
          ctx.stroke();
        }
      }
    }

    ctx.globalAlpha = 1;
    animFrameId = requestAnimationFrame(drawParticles);
  }

  resizeCanvas();
  createParticles();
  drawParticles();

  let resizeTimeout;
  window.addEventListener('resize', () => {
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(() => {
      resizeCanvas();
      createParticles();
    }, 200);
  });

  // ─── Scroll Reveal ─────────────────────────────────────────
  const revealElements = document.querySelectorAll('.reveal');

  function checkReveal() {
    const windowH = window.innerHeight;
    revealElements.forEach((el) => {
      const top = el.getBoundingClientRect().top;
      if (top < windowH * 0.88) {
        el.classList.add('visible');
      }
    });
  }

  window.addEventListener('scroll', checkReveal, { passive: true });
  window.addEventListener('load', checkReveal);
  // Initial check
  setTimeout(checkReveal, 100);

  // ─── Navbar Scroll ─────────────────────────────────────────
  const navbar = document.getElementById('navbar');

  window.addEventListener(
    'scroll',
    () => {
      if (window.scrollY > 60) {
        navbar.classList.add('scrolled');
      } else {
        navbar.classList.remove('scrolled');
      }
    },
    { passive: true }
  );

  // ─── Mobile Nav Toggle ─────────────────────────────────────
  const navToggle = document.getElementById('nav-toggle');
  const navLinks = document.getElementById('nav-links');

  if (navToggle && navLinks) {
    navToggle.addEventListener('click', () => {
      navLinks.classList.toggle('open');
    });

    // Close on link click
    navLinks.querySelectorAll('a').forEach((link) => {
      link.addEventListener('click', () => {
        navLinks.classList.remove('open');
      });
    });
  }

  // ─── Counter Animation ─────────────────────────────────────
  const counters = document.querySelectorAll('[data-count]');
  let countersDone = false;

  function animateCounters() {
    if (countersDone) return;

    counters.forEach((el) => {
      const top = el.getBoundingClientRect().top;
      if (top < window.innerHeight * 0.9) {
        const target = parseInt(el.getAttribute('data-count'), 10);
        let current = 0;
        const increment = target / 40;
        const timer = setInterval(() => {
          current += increment;
          if (current >= target) {
            el.textContent = target + '+';
            clearInterval(timer);
          } else {
            el.textContent = Math.floor(current);
          }
        }, 30);
      }
    });

    countersDone = true;
  }

  window.addEventListener('scroll', animateCounters, { passive: true });
  setTimeout(animateCounters, 500);

  // ─── Smooth Scroll ─────────────────────────────────────────
  document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
    anchor.addEventListener('click', (e) => {
      const href = anchor.getAttribute('href');
      if (href === '#') return;
      e.preventDefault();
      const target = document.querySelector(href);
      if (target) {
        const yOffset = -70;
        const y = target.getBoundingClientRect().top + window.pageYOffset + yOffset;
        window.scrollTo({ top: y, behavior: 'smooth' });
      }
    });
  });

  // ─── District Card Hover Glow Effect ───────────────────────
  document.querySelectorAll('.district-card').forEach((card) => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;
      card.style.setProperty('--mouse-x', x + 'px');
      card.style.setProperty('--mouse-y', y + 'px');
    });
  });

  // ─── Roadmap Phase Activation on Scroll ────────────────────
  const phases = document.querySelectorAll('.roadmap-phase');

  function checkPhases() {
    phases.forEach((phase) => {
      const top = phase.getBoundingClientRect().top;
      if (top < window.innerHeight * 0.7) {
        phase.classList.add('active');
      }
    });
  }

  window.addEventListener('scroll', checkPhases, { passive: true });
  setTimeout(checkPhases, 300);

  // ─── Architecture Layer Stagger ────────────────────────────
  const archLayers = document.querySelectorAll('.arch-layer');

  function staggerLayers() {
    archLayers.forEach((layer, i) => {
      const top = layer.getBoundingClientRect().top;
      if (top < window.innerHeight * 0.85) {
        setTimeout(() => {
          layer.style.opacity = '1';
          layer.style.transform = 'translateX(0)';
        }, i * 100);
      }
    });
  }

  // Init arch layers hidden
  archLayers.forEach((layer) => {
    layer.style.opacity = '0';
    layer.style.transform = 'translateX(-20px)';
    layer.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
  });

  window.addEventListener('scroll', staggerLayers, { passive: true });
  setTimeout(staggerLayers, 400);

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
      
      // TODO: Replace with actual API endpoint (e.g., Mailchimp, ConvertKit, Supabase)
      // For now, simulate success
      await new Promise(resolve => setTimeout(resolve, 1000));
      
      // Hide form, show success message
      waitlistForm.style.display = 'none';
      successMessage.style.display = 'block';
      
      // Log email (replace with actual API call)
      console.log('Waitlist signup:', email);
      
      // Optional: Send to backend
      // await fetch('/api/waitlist', {
      //   method: 'POST',
      //   headers: { 'Content-Type': 'application/json' },
      //   body: JSON.stringify({ email })
      // });
    });
  }
})();
