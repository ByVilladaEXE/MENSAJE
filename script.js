/* ================================================
   script.js — Página romántica para Iliana
   Incluye:
     · Canvas fondo (disco sutil + pétalos)
     · Contador de días desde el 7 de mayo de 2026
     · Partículas Hello Kitty alrededor del nombre
     · Scroll reveal para tarjetas
     · Botón No con fuga
     · Confeti corazones al presionar Sí
     · Control de música
================================================ */

/* -----------------------------------------------
   1. CANVAS DE FONDO: Disco sutil + Pétalos
----------------------------------------------- */
(function initBackground() {
  const canvas = document.getElementById('bgCanvas');
  const ctx    = canvas.getContext('2d');

  let W, H, petals = [];
  const PETAL_COUNT = 40;

  /* Ajuste de tamaño */
  function resize() {
    W = canvas.width  = window.innerWidth;
    H = canvas.height = window.innerHeight;
  }
  resize();
  window.addEventListener('resize', resize);

  /* Genera un pétalo */
  function createPetal() {
    return {
      x:      Math.random() * W,
      y:      -20 - Math.random() * 200,
      size:   6 + Math.random() * 10,
      speedY: 0.6 + Math.random() * 1.2,
      speedX: (Math.random() - 0.5) * 0.8,
      rot:    Math.random() * Math.PI * 2,
      rotSpeed: (Math.random() - 0.5) * 0.04,
      opacity: 0.5 + Math.random() * 0.4,
      // alterna entre rosa y verde suave
      hue:    Math.random() > 0.5 ? 340 : 120,
      sat:    Math.random() > 0.5 ? 85 : 55,
    };
  }

  /* Rellena los pétalos iniciales */
  for (let i = 0; i < PETAL_COUNT; i++) {
    const p = createPetal();
    p.y = Math.random() * H; // distribuir al inicio
    petals.push(p);
  }

  /* Dibuja un pétalo de rosa estilizado */
  function drawPetal(ctx, p) {
    ctx.save();
    ctx.translate(p.x, p.y);
    ctx.rotate(p.rot);
    ctx.globalAlpha = p.opacity;

    const color = `hsla(${p.hue}, ${p.sat}%, 75%, ${p.opacity})`;
    ctx.fillStyle = color;

    ctx.beginPath();
    // forma ovalada simple
    ctx.ellipse(0, 0, p.size * 0.5, p.size, 0, 0, Math.PI * 2);
    ctx.fill();

    ctx.restore();
  }

  /* Ángulo del efecto disco */
  let discoAngle = 0;

  /* Loop de animación */
  function loop() {
    ctx.clearRect(0, 0, W, H);

    /* --- Disco sutil: barras giratorias de luz --- */
    ctx.save();
    ctx.translate(W / 2, H / 2);
    ctx.rotate(discoAngle);
    for (let i = 0; i < 8; i++) {
      const a = (Math.PI * 2 / 8) * i;
      const grad = ctx.createLinearGradient(0, 0,
        Math.cos(a) * Math.max(W, H),
        Math.sin(a) * Math.max(W, H)
      );
      grad.addColorStop(0, 'rgba(247, 168, 196, 0.0)');
      grad.addColorStop(0.5, 'rgba(247, 168, 196, 0.04)');
      grad.addColorStop(1, 'rgba(168, 213, 162, 0.0)');
      ctx.strokeStyle = grad;
      ctx.lineWidth = 80;
      ctx.beginPath();
      ctx.moveTo(0, 0);
      ctx.lineTo(
        Math.cos(a) * Math.max(W, H) * 1.5,
        Math.sin(a) * Math.max(W, H) * 1.5
      );
      ctx.stroke();
    }
    ctx.restore();
    discoAngle += 0.002;

    /* --- Pétalos --- */
    for (const p of petals) {
      drawPetal(ctx, p);
      p.y     += p.speedY;
      p.x     += p.speedX + Math.sin(p.y * 0.015) * 0.4;
      p.rot   += p.rotSpeed;
      if (p.y > H + 30) {
        Object.assign(p, createPetal());
      }
    }

    requestAnimationFrame(loop);
  }
  loop();
})();


/* -----------------------------------------------
   2. CONTADOR DE DÍAS
----------------------------------------------- */
(function initCounter() {
  const startDate = new Date('2026-05-07T00:00:00');

  function updateDays() {
    const now   = new Date();
    const diffMs = now - startDate;
    const days  = Math.max(0, Math.floor(diffMs / (1000 * 60 * 60 * 24)));
    const el    = document.getElementById('dayCount');
    if (el) el.textContent = days;
  }

  updateDays();
  setInterval(updateDays, 60000); // actualiza cada minuto
})();


/* -----------------------------------------------
   3. PARTÍCULAS HELLO KITTY alrededor del nombre
----------------------------------------------- */
(function initKittyParticles() {
  const container = document.getElementById('kittyParticles');
  if (!container) return;

  // Emojis temáticos Hello Kitty / kawaii
  const symbols = ['🐱', '🎀', '🐱', '💗', '🎀', '🌸', '🐱', '💕', '🎀', '⭐', '🐱', '🎀'];
  const count   = symbols.length;

  // Radio de órbita adaptativo
  function getRadius(i) {
    // Alterna entre dos órbitas para más dinamismo
    return i % 2 === 0 ? 130 : 100;
  }

  symbols.forEach((sym, i) => {
    const el = document.createElement('span');
    el.className = 'kitty-p';
    el.textContent = sym;
    el.setAttribute('aria-hidden', 'true');

    const r     = getRadius(i);
    const dur   = 5 + (i % 4) * 1.5;  // velocidades variadas
    const delay = -(i * (dur / count)); // distribuir en la órbita

    el.style.setProperty('--r',     `${r}px`);
    el.style.setProperty('--dur',   `${dur}s`);
    el.style.setProperty('--delay', `${delay}s`);

    // Posición inicial centrada (se mueve con JS-CSS transform)
    el.style.top  = '50%';
    el.style.left = '50%';
    el.style.transform = `translateX(-50%) translateY(-50%)`;

    container.appendChild(el);
  });
})();


/* -----------------------------------------------
   4. SCROLL REVEAL para tarjetas
----------------------------------------------- */
(function initScrollReveal() {
  const cards = document.querySelectorAll('[data-reveal]');
  if (!cards.length) return;

  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add('revealed');
          observer.unobserve(entry.target);
        }
      });
    },
    { threshold: 0.15, rootMargin: '0px 0px -40px 0px' }
  );

  cards.forEach(card => observer.observe(card));
})();


/* -----------------------------------------------
   5. BOTÓN "NO" CON FUGA
----------------------------------------------- */
(function initBtnNo() {
  const btn     = document.getElementById('btnNo');
  const wrap    = document.getElementById('btnsWrap');
  if (!btn || !wrap) return;

  let isAbsolute = false;

  function enterAbsoluteMode() {
    if (isAbsolute) return;
    isAbsolute = true;

    const wRect  = wrap.getBoundingClientRect();
    const bRect  = btn.getBoundingClientRect();

    // Posición relativa inicial dentro del wrap
    const initLeft = bRect.left - wRect.left;
    const initTop  = bRect.top  - wRect.top;

    btn.style.position = 'absolute';
    btn.style.left = initLeft + 'px';
    btn.style.top  = initTop  + 'px';
    btn.style.margin = '0';
  }

  function escape() {
    enterAbsoluteMode();

    const wRect = wrap.getBoundingClientRect();
    const bW    = btn.offsetWidth;
    const bH    = btn.offsetHeight;
    const padX  = 20;
    const padY  = 10;

    const maxX = Math.max(0, wRect.width  - bW - padX);
    const maxY = Math.max(0, wRect.height - bH - padY);

    const newLeft = padX + Math.random() * maxX;
    const newTop  = padY + Math.random() * maxY;

    btn.style.left = newLeft + 'px';
    btn.style.top  = newTop  + 'px';
  }

  // Huye al hacer hover (desktop)
  btn.addEventListener('mouseenter', escape);
  // Huye al intentar tocar (mobile)
  btn.addEventListener('touchstart', (e) => {
    e.preventDefault();
    escape();
  }, { passive: false });

  // Si por milagro se hace clic
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    alert('No valía, inténtalo de nuevo 😏');
    escape();
  });

  // Asegura altura mínima del wrap para el movimiento
  wrap.style.minHeight = '120px';
  wrap.style.position  = 'relative';
})();


/* -----------------------------------------------
   6. BOTÓN "SÍ" — Confeti corazones + mensaje
----------------------------------------------- */
function siClicked() {
  const btnsWrap  = document.getElementById('btnsWrap');
  const successMsg = document.getElementById('successMsg');

  // Ocultar botones
  btnsWrap.style.display = 'none';
  successMsg.classList.add('show');

  // Lanzar confeti
  launchConfetti();
}

function launchConfetti() {
  const canvas = document.getElementById('confettiCanvas');
  const ctx    = canvas.getContext('2d');

  canvas.width  = canvas.offsetWidth;
  canvas.height = canvas.offsetHeight;

  const particles = [];
  const colors    = [
    '#f48fb1', '#f06292', '#e91e8c',
    '#a8d5a2', '#66bb6a', '#fff59d',
    '#ff8a65', '#fff', '#fce4ec'
  ];

  /* Crea un corazón de confeti */
  class Heart {
    constructor() {
      this.reset();
      this.y = canvas.height * Math.random() * 0.5; // empieza disperso
    }
    reset() {
      this.x     = Math.random() * canvas.width;
      this.y     = -30;
      this.size  = 10 + Math.random() * 18;
      this.color = colors[Math.floor(Math.random() * colors.length)];
      this.speedY = 2 + Math.random() * 4;
      this.speedX = (Math.random() - 0.5) * 3;
      this.rot    = Math.random() * Math.PI * 2;
      this.rotSpeed = (Math.random() - 0.5) * 0.12;
      this.opacity = 1;
      this.wobble = Math.random() * Math.PI * 2;
    }
    draw() {
      ctx.save();
      ctx.translate(this.x, this.y);
      ctx.rotate(this.rot);
      ctx.globalAlpha = this.opacity;
      ctx.fillStyle   = this.color;

      const s = this.size;
      ctx.beginPath();
      ctx.moveTo(0, -s * 0.3);
      ctx.bezierCurveTo( s * 0.5, -s * 0.9,  s * 1.1,  s * 0.1, 0,  s * 0.7);
      ctx.bezierCurveTo(-s * 1.1,  s * 0.1, -s * 0.5, -s * 0.9, 0, -s * 0.3);
      ctx.fill();
      ctx.restore();
    }
    update() {
      this.wobble += 0.06;
      this.x      += this.speedX + Math.sin(this.wobble) * 0.5;
      this.y      += this.speedY;
      this.rot    += this.rotSpeed;
      if (this.y > canvas.height + 40) {
        this.reset();
      }
    }
  }

  // Crear 80 corazones
  for (let i = 0; i < 80; i++) {
    particles.push(new Heart());
  }

  let frame = 0;
  const MAX_FRAMES = 300; // ~5 segundos a 60fps

  function animate() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    for (const p of particles) {
      p.draw();
      p.update();
      if (frame > MAX_FRAMES - 60) {
        p.opacity -= 0.016; // fade out final
      }
    }
    frame++;
    if (frame < MAX_FRAMES) {
      requestAnimationFrame(animate);
    } else {
      ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
  }
  animate();
}


/* -----------------------------------------------
   7. MÚSICA DE FONDO
   — Pon tu archivo "musica.mp3" en la misma carpeta
----------------------------------------------- */
(function initMusic() {
  const audio  = document.getElementById('bgMusic');
  const btn    = document.getElementById('musicBtn');
  const icon   = document.getElementById('musicIcon');

  if (!audio || !btn) return;

  let playing = false;

  function tryPlay() {
    const promise = audio.play();
    if (promise !== undefined) {
      promise
        .then(() => {
          playing = true;
          icon.textContent = '🎵';
          btn.classList.remove('paused');
        })
        .catch(() => {
          // Autoplay bloqueado: el usuario debe presionar el botón
          playing = false;
          icon.textContent = '▶️';
          btn.classList.add('paused');
          btn.title = 'Toca para activar música';
        });
    }
  }

  // Intento de autoplay al cargar
  window.addEventListener('load', tryPlay);

  // Alternativa: intentar en primer toque en cualquier parte de la página
  document.addEventListener('touchstart', function firstTouch() {
    if (!playing) tryPlay();
    document.removeEventListener('touchstart', firstTouch);
  }, { once: true });

  document.addEventListener('click', function firstClick() {
    if (!playing) tryPlay();
    document.removeEventListener('click', firstClick);
  }, { once: true });

  // Botón flotante pausa / reanuda
  btn.addEventListener('click', () => {
    if (playing) {
      audio.pause();
      playing = false;
      icon.textContent = '▶️';
      btn.classList.add('paused');
    } else {
      audio.play().then(() => {
        playing = true;
        icon.textContent = '🎵';
        btn.classList.remove('paused');
      });
    }
  });
})();
