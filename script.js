(function () {
  "use strict";

  const prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  const navbar = document.getElementById("navbar");
  const navToggle = document.getElementById("nav-toggle");
  const navLinks = document.getElementById("nav-links");
  const counters = document.querySelectorAll("[data-count]");
  const waitlistForm = document.getElementById("waitlist-form");
  const emailInput = document.getElementById("email");
  const successMessage = document.getElementById("success-message");

  function updateNavbar() {
    if (!navbar) {
      return;
    }

    if (window.scrollY > 18) {
      navbar.classList.add("is-scrolled");
    } else {
      navbar.classList.remove("is-scrolled");
    }
  }

  updateNavbar();
  window.addEventListener("scroll", updateNavbar, { passive: true });

  if (navToggle && navLinks) {
    navToggle.addEventListener("click", function () {
      const isOpen = navLinks.classList.toggle("is-open");
      navToggle.setAttribute("aria-expanded", String(isOpen));
    });

    navLinks.querySelectorAll('a[href^="#"]').forEach(function (link) {
      link.addEventListener("click", function () {
        navLinks.classList.remove("is-open");
        navToggle.setAttribute("aria-expanded", "false");
      });
    });
  }

  document.querySelectorAll('a[href^="#"]').forEach(function (anchor) {
    anchor.addEventListener("click", function (event) {
      const href = anchor.getAttribute("href");
      if (!href || href === "#") {
        return;
      }

      const target = document.querySelector(href);
      if (!target) {
        return;
      }

      event.preventDefault();
      const top = target.getBoundingClientRect().top + window.scrollY - 96;
      window.scrollTo({
        top,
        behavior: prefersReducedMotion ? "auto" : "smooth",
      });
    });
  });

  const revealElements = document.querySelectorAll(".reveal");

  function showElement(element) {
    element.classList.add("is-visible");
  }

  if (prefersReducedMotion || !("IntersectionObserver" in window)) {
    revealElements.forEach(showElement);
  } else {
    const revealObserver = new IntersectionObserver(
      function (entries, observer) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) {
            return;
          }

          showElement(entry.target);
          observer.unobserve(entry.target);
        });
      },
      {
        threshold: 0.18,
      }
    );

    revealElements.forEach(function (element) {
      revealObserver.observe(element);
    });
  }

  function animateCounter(element) {
    if (element.dataset.animated === "true") {
      return;
    }

    const target = Number(element.getAttribute("data-count") || "0");
    element.dataset.animated = "true";

    if (!target) {
      element.textContent = "0";
      return;
    }

    if (prefersReducedMotion) {
      element.textContent = String(target);
      return;
    }

    const duration = 900;
    const start = Date.now();
    const timer = window.setInterval(function () {
      const progress = Math.min((Date.now() - start) / duration, 1);
      const eased = 1 - Math.pow(1 - progress, 3);
      element.textContent = String(Math.round(target * eased));

      if (progress >= 1) {
        window.clearInterval(timer);
      }
    }, 16);
  }

  function counterInView(element) {
    const rect = element.getBoundingClientRect();
    return rect.top < window.innerHeight * 0.9 && rect.bottom > 0;
  }

  if (counters.length) {
    if (prefersReducedMotion || !("IntersectionObserver" in window)) {
      counters.forEach(animateCounter);
    } else {
      const counterObserver = new IntersectionObserver(
        function (entries, observer) {
          entries.forEach(function (entry) {
            if (!entry.isIntersecting) {
              return;
            }

            animateCounter(entry.target);
            observer.unobserve(entry.target);
          });
        },
        {
          threshold: 0.6,
        }
      );

      counters.forEach(function (counter) {
        counterObserver.observe(counter);
      });
    }

    window.setTimeout(function () {
      counters.forEach(function (counter) {
        if (counterInView(counter)) {
          animateCounter(counter);
        }
      });
    }, 220);
  }

  const storageKey = "gangclawcity.waitlist.email";

  function showSavedState() {
    if (!successMessage || !waitlistForm) {
      return;
    }

    successMessage.hidden = false;
    waitlistForm.setAttribute("data-saved", "true");
  }

  try {
    const savedEmail = window.localStorage.getItem(storageKey);
    if (savedEmail && emailInput) {
      emailInput.value = savedEmail;
      showSavedState();
    }
  } catch (error) {
    console.warn("Local storage unavailable for waitlist preview.", error);
  }

  if (waitlistForm && emailInput) {
    waitlistForm.addEventListener("submit", function (event) {
      event.preventDefault();

      const email = emailInput.value.trim();
      if (!email) {
        return;
      }

      try {
        window.localStorage.setItem(storageKey, email);
      } catch (error) {
        console.warn("Unable to persist waitlist email locally.", error);
      }

      showSavedState();
    });
  }

  const canvas = document.getElementById("particle-canvas");

  if (!canvas || prefersReducedMotion) {
    return;
  }

  const context = canvas.getContext("2d");
  if (!context) {
    return;
  }

  let width = 0;
  let height = 0;
  let animationFrame = 0;
  const colors = ["#1ce0ff", "#7af3ab", "#ffb14a"];
  let particles = [];

  function resizeCanvas() {
    width = window.innerWidth;
    height = window.innerHeight;
    canvas.width = width;
    canvas.height = height;
  }

  function createParticles() {
    const density = Math.min(Math.floor((width * height) / 32000), 42);
    particles = Array.from({ length: Math.max(density, 18) }, function () {
      return {
        x: Math.random() * width,
        y: Math.random() * height,
        vx: (Math.random() - 0.5) * 0.28,
        vy: (Math.random() - 0.5) * 0.28,
        size: Math.random() * 1.8 + 0.8,
        color: colors[Math.floor(Math.random() * colors.length)],
        alpha: Math.random() * 0.35 + 0.12,
      };
    });
  }

  function drawFrame() {
    context.clearRect(0, 0, width, height);

    particles.forEach(function (particle, index) {
      particle.x += particle.vx;
      particle.y += particle.vy;

      if (particle.x < -20) {
        particle.x = width + 20;
      } else if (particle.x > width + 20) {
        particle.x = -20;
      }

      if (particle.y < -20) {
        particle.y = height + 20;
      } else if (particle.y > height + 20) {
        particle.y = -20;
      }

      context.beginPath();
      context.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2);
      context.fillStyle = particle.color;
      context.globalAlpha = particle.alpha;
      context.fill();

      for (let otherIndex = index + 1; otherIndex < particles.length; otherIndex += 1) {
        const other = particles[otherIndex];
        const dx = particle.x - other.x;
        const dy = particle.y - other.y;
        const distance = Math.hypot(dx, dy);

        if (distance > 128) {
          continue;
        }

        context.beginPath();
        context.moveTo(particle.x, particle.y);
        context.lineTo(other.x, other.y);
        context.strokeStyle = particle.color;
        context.globalAlpha = (1 - distance / 128) * 0.12;
        context.lineWidth = 0.7;
        context.stroke();
      }
    });

    context.globalAlpha = 1;
    animationFrame = requestAnimationFrame(drawFrame);
  }

  resizeCanvas();
  createParticles();
  drawFrame();

  let resizeTimeout = 0;
  window.addEventListener("resize", function () {
    window.clearTimeout(resizeTimeout);
    resizeTimeout = window.setTimeout(function () {
      resizeCanvas();
      createParticles();
      window.cancelAnimationFrame(animationFrame);
      drawFrame();
    }, 140);
  });
})();
