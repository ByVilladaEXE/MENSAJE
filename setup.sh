#!/usr/bin/env bash
# ============================================================
#  setup.sh — Configuración automática del proyecto "para-iliana"
#  Uso: bash setup.sh
#  Requiere: curl, git (vienen con Termux)
#  Autor: setup generado para Termux Android
# ============================================================

set -e   # Detener en caso de error

# ── Colores para la terminal ──
RED='\033[0;31m'
GRN='\033[0;32m'
PNK='\033[0;35m'
YEL='\033[1;33m'
NC='\033[0m'  # Sin color

echo ""
echo -e "${PNK}╔══════════════════════════════════════════╗${NC}"
echo -e "${PNK}║  💌  Setup: Página para Iliana  💌       ║${NC}"
echo -e "${PNK}╚══════════════════════════════════════════╝${NC}"
echo ""

# ── 1. Verificar dependencias ──
echo -e "${YEL}[1/5]${NC} Verificando dependencias..."
for cmd in git curl; do
  if ! command -v "$cmd" &>/dev/null; then
    echo -e "${RED}✗ '$cmd' no encontrado. Instalando...${NC}"
    pkg install "$cmd" -y
  else
    echo -e "${GRN}✓ $cmd disponible${NC}"
  fi
done

# ── 2. Crear estructura de carpetas ──
echo ""
echo -e "${YEL}[2/5]${NC} Creando carpeta del proyecto..."

PROJECT_DIR="$HOME/iliana"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"
echo -e "${GRN}✓ Carpeta: $PROJECT_DIR${NC}"

# ── 3. Generar index.html ──
echo ""
echo -e "${YEL}[3/5]${NC} Generando archivos del proyecto..."

# ---------- index.html ----------
cat > index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Para Iliana 🌸</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;1,400&family=Lato:wght@300;400&family=Dancing+Script:wght@600;700&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="style.css" />
</head>
<body>
  <canvas id="bgCanvas"></canvas>
  <button class="music-btn" id="musicBtn" title="Música">
    <span class="music-icon" id="musicIcon">🎵</span>
  </button>
  <audio id="bgMusic" loop>
    <source src="musica.mp3" type="audio/mpeg" />
  </audio>
  <section class="hero" id="hero">
    <div class="disco-ring disco-ring-1"></div>
    <div class="disco-ring disco-ring-2"></div>
    <div class="disco-ring disco-ring-3"></div>
    <div class="hero-content">
      <p class="hero-subtitle fade-in-up delay-1">💌 Tengo algo importante que decirte…</p>
      <h1 class="hero-title fade-in-up delay-2">
        <span class="name-letter" style="--i:0">I</span><span class="name-letter" style="--i:1">l</span><span class="name-letter" style="--i:2">i</span><span class="name-letter" style="--i:3">a</span><span class="name-letter" style="--i:4">n</span><span class="name-letter" style="--i:5">a</span>
      </h1>
      <div class="kitty-particles" id="kittyParticles" aria-hidden="true"></div>
      <div class="counter-wrap fade-in-up delay-3">
        <p class="counter-label">Llevamos</p>
        <p class="counter-days" id="dayCount">…</p>
        <p class="counter-label">días juntos 🌷</p>
      </div>
      <a href="#pregunta" class="scroll-cta fade-in-up delay-4">
        <span>Sigue leyendo</span>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 9l6 6 6-6"/></svg>
      </a>
    </div>
  </section>
  <section class="reasons" id="reasons">
    <h2 class="section-title">¿Por qué me gustas?</h2>
    <p class="section-sub">Podría escribir una lista infinita, pero aquí van algunas…</p>
    <div class="cards-grid">
      <div class="reason-card" data-reveal>
        <div class="card-icon">✨</div>
        <h3>Tu sonrisa</h3>
        <p>Cuando sonríes, el mundo completo parece más bonito. No exagero.</p>
      </div>
      <div class="reason-card" data-reveal>
        <div class="card-icon">👀</div>
        <h3>Cómo me miras</h3>
        <p>Hay algo en tus ojos que me hace querer quedarme por siempre.</p>
      </div>
      <div class="reason-card" data-reveal>
        <div class="card-icon">🌸</div>
        <h3>Tu forma de ser</h3>
        <p>Eres auténtica, única, y eso me fascina más de lo que imaginas.</p>
      </div>
      <div class="reason-card" data-reveal>
        <div class="card-icon">💬</div>
        <h3>Tus conversaciones</h3>
        <p>Hablar contigo nunca aburre. Siempre quiero escucharte más.</p>
      </div>
      <div class="reason-card" data-reveal>
        <div class="card-icon">🤍</div>
        <h3>Cómo me haces sentir</h3>
        <p>Contigo me siento yo mismo. Tranquilo, feliz y en el lugar correcto.</p>
      </div>
    </div>
  </section>
  <section class="pregunta" id="pregunta">
    <div class="pregunta-inner">
      <div class="pregunta-deco">🌹</div>
      <h2 class="pregunta-title">¿Quieres ser<br/>mi novia?</h2>
      <p class="pregunta-sub">Piénsalo bien… aunque ya sé que la respuesta es sí 😏</p>
      <div class="btns-wrap" id="btnsWrap">
        <button class="btn-si" id="btnSi" onclick="siClicked()">💖 ¡Sí!</button>
        <button class="btn-no" id="btnNo">No…</button>
      </div>
      <div class="success-msg" id="successMsg">
        <div class="success-emoji">🎉</div>
        <h2>¡Eres mi novia!</h2>
        <p>Sabía que dirías que sí 💕</p>
        <p class="success-date">Desde hoy, todo es nuestro.</p>
      </div>
    </div>
    <canvas id="confettiCanvas"></canvas>
  </section>
  <footer class="site-footer">
    <p>Hecho con todo el amor del mundo, solo para ti 🌷</p>
  </footer>
  <script src="script.js"></script>
</body>
</html>
HTMLEOF
echo -e "  ${GRN}✓ index.html${NC}"

# ---------- style.css ----------
cat > style.css << 'CSSEOF'
:root{--pink:#f7a8c4;--pink-soft:#fce4ec;--pink-deep:#e91e8c;--green:#a8d5a2;--green-soft:#e8f5e9;--green-deep:#4caf50;--rose:#f48fb1;--white:#fff8fb;--text:#5c3d5c;--text-light:#9e7e9e;--card-bg:rgba(255,255,255,0.72);--shadow:0 8px 32px rgba(200,80,140,0.18);--radius:20px;--font-title:'Playfair Display',serif;--font-script:'Dancing Script',cursive;--font-body:'Lato',sans-serif}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;-webkit-text-size-adjust:100%}
body{font-family:var(--font-body);color:var(--text);background:var(--white);overflow-x:hidden;position:relative}
#bgCanvas{position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:0}
.music-btn{position:fixed;bottom:24px;right:24px;z-index:999;width:54px;height:54px;border-radius:50%;border:none;background:linear-gradient(135deg,var(--pink),var(--green));box-shadow:0 4px 20px rgba(200,80,140,0.4);cursor:pointer;font-size:22px;display:flex;align-items:center;justify-content:center;transition:transform 0.2s,box-shadow 0.2s;-webkit-tap-highlight-color:transparent}
.music-btn:hover{transform:scale(1.12)}
.music-btn.paused{opacity:0.7}
.hero{position:relative;min-height:100dvh;display:flex;align-items:center;justify-content:center;text-align:center;padding:40px 24px 80px;overflow:hidden;z-index:1}
.disco-ring{position:absolute;border-radius:50%;border:2px solid rgba(247,168,196,0.25);animation:spinRing 20s linear infinite;pointer-events:none}
.disco-ring-1{width:400px;height:400px;top:50%;left:50%;transform:translate(-50%,-50%);animation-duration:18s}
.disco-ring-2{width:620px;height:620px;top:50%;left:50%;transform:translate(-50%,-50%);animation-duration:28s;animation-direction:reverse;border-color:rgba(168,213,162,0.2)}
.disco-ring-3{width:820px;height:820px;top:50%;left:50%;transform:translate(-50%,-50%);animation-duration:40s;border-color:rgba(247,168,196,0.12)}
@keyframes spinRing{from{transform:translate(-50%,-50%) rotate(0deg)}to{transform:translate(-50%,-50%) rotate(360deg)}}
.hero-content{position:relative;z-index:2;max-width:600px;width:100%}
.hero-subtitle{font-family:var(--font-script);font-size:clamp(1.1rem,4vw,1.4rem);color:var(--rose);margin-bottom:16px}
.hero-title{font-family:var(--font-title);font-size:clamp(4rem,18vw,9rem);font-weight:700;line-height:1;position:relative;display:inline-block}
.name-letter{display:inline-block;background:linear-gradient(135deg,var(--pink-deep) 0%,var(--green-deep) 50%,var(--pink-deep) 100%);background-size:200% 200%;-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;animation:gradShift 4s ease-in-out infinite,floatLetter 3s ease-in-out infinite;animation-delay:calc(var(--i)*0.15s),calc(var(--i)*0.2s)}
@keyframes gradShift{0%,100%{background-position:0% 50%}50%{background-position:100% 50%}}
@keyframes floatLetter{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
.kitty-particles{position:absolute;width:100%;height:100%;top:0;left:0;pointer-events:none}
.kitty-p{position:absolute;font-size:20px;animation:orbitKitty var(--dur,6s) linear infinite;animation-delay:var(--delay,0s);transform-origin:50% 50%;opacity:0.85}
@keyframes orbitKitty{0%{transform:rotate(0deg) translateX(var(--r,80px)) rotate(0deg)}100%{transform:rotate(360deg) translateX(var(--r,80px)) rotate(-360deg)}}
.counter-wrap{margin:28px 0 32px;display:flex;flex-direction:column;align-items:center;gap:4px}
.counter-label{font-family:var(--font-script);font-size:clamp(1rem,3.5vw,1.25rem);color:var(--text-light)}
.counter-days{font-family:var(--font-title);font-size:clamp(2.8rem,12vw,5.5rem);font-weight:700;background:linear-gradient(90deg,var(--pink-deep),var(--green-deep));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;line-height:1}
.scroll-cta{display:inline-flex;flex-direction:column;align-items:center;gap:6px;text-decoration:none;color:var(--pink-deep);font-family:var(--font-script);font-size:1.1rem;animation:bounceDown 2s ease-in-out infinite}
.scroll-cta svg{width:28px;height:28px}
@keyframes bounceDown{0%,100%{transform:translateY(0)}50%{transform:translateY(8px)}}
.reasons{position:relative;z-index:1;padding:80px 24px;text-align:center;background:linear-gradient(180deg,transparent,var(--pink-soft) 30%,var(--green-soft) 70%,transparent)}
.section-title{font-family:var(--font-title);font-size:clamp(1.8rem,7vw,3rem);font-style:italic;color:var(--pink-deep);margin-bottom:8px}
.section-sub{font-family:var(--font-script);font-size:clamp(1rem,3.5vw,1.25rem);color:var(--text-light);margin-bottom:48px}
.cards-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(240px,1fr));gap:24px;max-width:900px;margin:0 auto}
.reason-card{background:var(--card-bg);backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1.5px solid rgba(247,168,196,0.4);border-radius:var(--radius);padding:32px 24px;box-shadow:var(--shadow);opacity:0;transform:translateY(40px);transition:opacity 0.6s ease,transform 0.6s ease,box-shadow 0.3s}
.reason-card.revealed{opacity:1;transform:translateY(0)}
.reason-card:hover{box-shadow:0 12px 40px rgba(200,80,140,0.28)}
.reason-card.revealed:hover{transform:translateY(-6px)}
.card-icon{font-size:2.2rem;margin-bottom:14px}
.reason-card h3{font-family:var(--font-title);font-size:1.2rem;color:var(--pink-deep);margin-bottom:8px}
.reason-card p{font-size:0.95rem;color:var(--text-light);line-height:1.6}
.reason-card:nth-child(1){transition-delay:0.05s}
.reason-card:nth-child(2){transition-delay:0.15s}
.reason-card:nth-child(3){transition-delay:0.25s}
.reason-card:nth-child(4){transition-delay:0.35s}
.reason-card:nth-child(5){transition-delay:0.45s}
.pregunta{position:relative;z-index:1;min-height:100dvh;display:flex;align-items:center;justify-content:center;padding:80px 24px;overflow:hidden}
.pregunta-inner{text-align:center;max-width:520px;position:relative;z-index:2}
.pregunta-deco{font-size:3.5rem;animation:pulse 2s ease-in-out infinite;display:block;margin-bottom:16px}
@keyframes pulse{0%,100%{transform:scale(1)}50%{transform:scale(1.15)}}
.pregunta-title{font-family:var(--font-title);font-size:clamp(2.4rem,10vw,4.5rem);font-style:italic;line-height:1.15;margin-bottom:18px;background:linear-gradient(135deg,var(--pink-deep),var(--green-deep));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.pregunta-sub{font-family:var(--font-script);font-size:clamp(1rem,3.5vw,1.2rem);color:var(--text-light);margin-bottom:48px}
.btns-wrap{position:relative;display:flex;align-items:center;justify-content:center;gap:24px;min-height:100px}
.btn-si{font-family:var(--font-title);font-size:clamp(1.1rem,5vw,1.5rem);font-style:italic;padding:18px 44px;border:none;border-radius:60px;background:linear-gradient(135deg,var(--pink-deep),var(--rose));color:#fff;cursor:pointer;box-shadow:0 6px 28px rgba(233,30,140,0.45);transition:transform 0.2s,box-shadow 0.2s;-webkit-tap-highlight-color:transparent;position:relative;overflow:hidden}
.btn-si::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(255,255,255,0.25),transparent);border-radius:inherit}
.btn-si:hover{transform:scale(1.06) translateY(-3px);box-shadow:0 10px 36px rgba(233,30,140,0.6)}
.btn-no{font-family:var(--font-body);font-size:clamp(0.95rem,3.5vw,1.1rem);padding:14px 30px;border:2px solid var(--green);border-radius:60px;background:transparent;color:var(--text-light);cursor:pointer;transition:opacity 0.15s,left 0.25s ease,top 0.25s ease;-webkit-tap-highlight-color:transparent;position:absolute;white-space:nowrap}
.success-msg{display:none;flex-direction:column;align-items:center;gap:12px;animation:popIn 0.6s cubic-bezier(0.175,0.885,0.32,1.275) both}
.success-msg.show{display:flex}
@keyframes popIn{from{opacity:0;transform:scale(0.5)}to{opacity:1;transform:scale(1)}}
.success-emoji{font-size:4rem;animation:spin1 0.8s ease-out}
@keyframes spin1{from{transform:rotate(-180deg) scale(0)}to{transform:rotate(0deg) scale(1)}}
.success-msg h2{font-family:var(--font-title);font-style:italic;font-size:clamp(2rem,8vw,3.5rem);background:linear-gradient(135deg,var(--pink-deep),var(--green-deep));-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
.success-msg p{font-family:var(--font-script);font-size:1.2rem;color:var(--text-light)}
#confettiCanvas{position:absolute;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:3}
.site-footer{position:relative;z-index:1;text-align:center;padding:32px 24px;font-family:var(--font-script);font-size:1.1rem;color:var(--text-light);border-top:1px solid rgba(247,168,196,0.25)}
.fade-in-up{opacity:0;transform:translateY(30px);animation:fadeInUp 0.8s ease forwards}
.delay-1{animation-delay:0.3s}.delay-2{animation-delay:0.6s}.delay-3{animation-delay:1.0s}.delay-4{animation-delay:1.4s}
@keyframes fadeInUp{to{opacity:1;transform:translateY(0)}}
@media(max-width:480px){.cards-grid{grid-template-columns:1fr}.btns-wrap{flex-direction:column;gap:16px;min-height:130px}.btn-no{position:relative!important;top:auto!important;left:auto!important}.disco-ring-2,.disco-ring-3{display:none}}
CSSEOF
echo -e "  ${GRN}✓ style.css${NC}"

# ---------- script.js ----------
cat > script.js << 'JSEOF'
(function initBackground(){const canvas=document.getElementById('bgCanvas');const ctx=canvas.getContext('2d');let W,H,petals=[];const PETAL_COUNT=40;function resize(){W=canvas.width=window.innerWidth;H=canvas.height=window.innerHeight;}resize();window.addEventListener('resize',resize);function createPetal(){return{x:Math.random()*W,y:-20-Math.random()*200,size:6+Math.random()*10,speedY:0.6+Math.random()*1.2,speedX:(Math.random()-0.5)*0.8,rot:Math.random()*Math.PI*2,rotSpeed:(Math.random()-0.5)*0.04,opacity:0.5+Math.random()*0.4,hue:Math.random()>0.5?340:120,sat:Math.random()>0.5?85:55};}for(let i=0;i<PETAL_COUNT;i++){const p=createPetal();p.y=Math.random()*H;petals.push(p);}function drawPetal(ctx,p){ctx.save();ctx.translate(p.x,p.y);ctx.rotate(p.rot);ctx.globalAlpha=p.opacity;ctx.fillStyle=`hsla(${p.hue},${p.sat}%,75%,${p.opacity})`;ctx.beginPath();ctx.ellipse(0,0,p.size*0.5,p.size,0,0,Math.PI*2);ctx.fill();ctx.restore();}let discoAngle=0;function loop(){ctx.clearRect(0,0,W,H);ctx.save();ctx.translate(W/2,H/2);ctx.rotate(discoAngle);for(let i=0;i<8;i++){const a=(Math.PI*2/8)*i;const grad=ctx.createLinearGradient(0,0,Math.cos(a)*Math.max(W,H),Math.sin(a)*Math.max(W,H));grad.addColorStop(0,'rgba(247,168,196,0.0)');grad.addColorStop(0.5,'rgba(247,168,196,0.04)');grad.addColorStop(1,'rgba(168,213,162,0.0)');ctx.strokeStyle=grad;ctx.lineWidth=80;ctx.beginPath();ctx.moveTo(0,0);ctx.lineTo(Math.cos(a)*Math.max(W,H)*1.5,Math.sin(a)*Math.max(W,H)*1.5);ctx.stroke();}ctx.restore();discoAngle+=0.002;for(const p of petals){drawPetal(ctx,p);p.y+=p.speedY;p.x+=p.speedX+Math.sin(p.y*0.015)*0.4;p.rot+=p.rotSpeed;if(p.y>H+30){Object.assign(p,createPetal());}}requestAnimationFrame(loop);}loop();})();

(function initCounter(){const startDate=new Date('2026-05-07T00:00:00');function updateDays(){const now=new Date();const diffMs=now-startDate;const days=Math.max(0,Math.floor(diffMs/(1000*60*60*24)));const el=document.getElementById('dayCount');if(el)el.textContent=days;}updateDays();setInterval(updateDays,60000);})();

(function initKittyParticles(){const container=document.getElementById('kittyParticles');if(!container)return;const symbols=['🐱','🎀','🐱','💗','🎀','🌸','🐱','💕','🎀','⭐','🐱','🎀'];const count=symbols.length;function getRadius(i){return i%2===0?130:100;}symbols.forEach((sym,i)=>{const el=document.createElement('span');el.className='kitty-p';el.textContent=sym;el.setAttribute('aria-hidden','true');const r=getRadius(i);const dur=5+(i%4)*1.5;const delay=-(i*(dur/count));el.style.setProperty('--r',`${r}px`);el.style.setProperty('--dur',`${dur}s`);el.style.setProperty('--delay',`${delay}s`);el.style.top='50%';el.style.left='50%';el.style.transform='translateX(-50%) translateY(-50%)';container.appendChild(el);});})();

(function initScrollReveal(){const cards=document.querySelectorAll('[data-reveal]');if(!cards.length)return;const observer=new IntersectionObserver((entries)=>{entries.forEach(entry=>{if(entry.isIntersecting){entry.target.classList.add('revealed');observer.unobserve(entry.target);}});},{threshold:0.15,rootMargin:'0px 0px -40px 0px'});cards.forEach(card=>observer.observe(card));})();

(function initBtnNo(){const btn=document.getElementById('btnNo');const wrap=document.getElementById('btnsWrap');if(!btn||!wrap)return;let isAbsolute=false;function enterAbsoluteMode(){if(isAbsolute)return;isAbsolute=true;const wRect=wrap.getBoundingClientRect();const bRect=btn.getBoundingClientRect();btn.style.position='absolute';btn.style.left=(bRect.left-wRect.left)+'px';btn.style.top=(bRect.top-wRect.top)+'px';btn.style.margin='0';}function escape(){enterAbsoluteMode();const wRect=wrap.getBoundingClientRect();const bW=btn.offsetWidth;const bH=btn.offsetHeight;const maxX=Math.max(0,wRect.width-bW-20);const maxY=Math.max(0,wRect.height-bH-10);btn.style.left=(20+Math.random()*maxX)+'px';btn.style.top=(10+Math.random()*maxY)+'px';}btn.addEventListener('mouseenter',escape);btn.addEventListener('touchstart',(e)=>{e.preventDefault();escape();},{passive:false});btn.addEventListener('click',(e)=>{e.preventDefault();alert('No valía, inténtalo de nuevo 😏');escape();});wrap.style.minHeight='120px';wrap.style.position='relative';})();

function siClicked(){const btnsWrap=document.getElementById('btnsWrap');const successMsg=document.getElementById('successMsg');btnsWrap.style.display='none';successMsg.classList.add('show');launchConfetti();}

function launchConfetti(){const canvas=document.getElementById('confettiCanvas');const ctx=canvas.getContext('2d');canvas.width=canvas.offsetWidth;canvas.height=canvas.offsetHeight;const particles=[];const colors=['#f48fb1','#f06292','#e91e8c','#a8d5a2','#66bb6a','#fff59d','#ff8a65','#fff','#fce4ec'];class Heart{constructor(){this.reset();this.y=canvas.height*Math.random()*0.5;}reset(){this.x=Math.random()*canvas.width;this.y=-30;this.size=10+Math.random()*18;this.color=colors[Math.floor(Math.random()*colors.length)];this.speedY=2+Math.random()*4;this.speedX=(Math.random()-0.5)*3;this.rot=Math.random()*Math.PI*2;this.rotSpeed=(Math.random()-0.5)*0.12;this.opacity=1;this.wobble=Math.random()*Math.PI*2;}draw(){ctx.save();ctx.translate(this.x,this.y);ctx.rotate(this.rot);ctx.globalAlpha=this.opacity;ctx.fillStyle=this.color;const s=this.size;ctx.beginPath();ctx.moveTo(0,-s*0.3);ctx.bezierCurveTo(s*0.5,-s*0.9,s*1.1,s*0.1,0,s*0.7);ctx.bezierCurveTo(-s*1.1,s*0.1,-s*0.5,-s*0.9,0,-s*0.3);ctx.fill();ctx.restore();}update(){this.wobble+=0.06;this.x+=this.speedX+Math.sin(this.wobble)*0.5;this.y+=this.speedY;this.rot+=this.rotSpeed;if(this.y>canvas.height+40)this.reset();}}for(let i=0;i<80;i++)particles.push(new Heart());let frame=0;const MAX_FRAMES=300;function animate(){ctx.clearRect(0,0,canvas.width,canvas.height);for(const p of particles){p.draw();p.update();if(frame>MAX_FRAMES-60)p.opacity-=0.016;}frame++;if(frame<MAX_FRAMES)requestAnimationFrame(animate);else ctx.clearRect(0,0,canvas.width,canvas.height);}animate();}

(function initMusic(){const audio=document.getElementById('bgMusic');const btn=document.getElementById('musicBtn');const icon=document.getElementById('musicIcon');if(!audio||!btn)return;let playing=false;function tryPlay(){const promise=audio.play();if(promise!==undefined){promise.then(()=>{playing=true;icon.textContent='🎵';btn.classList.remove('paused');}).catch(()=>{playing=false;icon.textContent='▶️';btn.classList.add('paused');btn.title='Toca para activar música';});}}window.addEventListener('load',tryPlay);document.addEventListener('touchstart',function firstTouch(){if(!playing)tryPlay();document.removeEventListener('touchstart',firstTouch);},{once:true});document.addEventListener('click',function firstClick(){if(!playing)tryPlay();document.removeEventListener('click',firstClick);},{once:true});btn.addEventListener('click',()=>{if(playing){audio.pause();playing=false;icon.textContent='▶️';btn.classList.add('paused');}else{audio.play().then(()=>{playing=true;icon.textContent='🎵';btn.classList.remove('paused');});}});})();
JSEOF
echo -e "  ${GRN}✓ script.js${NC}"

# ---------- musica.mp3 placeholder ----------
if [ ! -f musica.mp3 ]; then
  echo -e "  ${YEL}⚠ Recuerda colocar 'musica.mp3' en esta carpeta.${NC}"
  touch musica.PLACEHOLDER_REEMPLAZAME.mp3
fi

# ---------- README.md se copia si existe junto al script ----------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/README.md" ] && [ "$SCRIPT_DIR" != "$PROJECT_DIR" ]; then
  cp "$SCRIPT_DIR/README.md" README.md
  echo -e "  ${GRN}✓ README.md${NC}"
fi

# ── 4. Inicializar repositorio Git ──
echo ""
echo -e "${YEL}[4/5]${NC} Inicializando repositorio Git..."
if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "💌 Primera versión para Iliana"
  echo -e "${GRN}✓ Repositorio Git listo${NC}"
else
  echo -e "${GRN}✓ Git ya inicializado${NC}"
fi

# ── 5. Instrucciones finales ──
echo ""
echo -e "${PNK}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${PNK}║  ✅  ¡Todo listo! Siguiente paso:                    ║${NC}"
echo -e "${PNK}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GRN}1.${NC} Copia tu ${YEL}musica.mp3${NC} a: ${YEL}$PROJECT_DIR/${NC}"
echo -e "  ${GRN}2.${NC} Crea un repo en: ${YEL}https://github.com/new${NC}"
echo -e "     Nombre sugerido: ${YEL}para-iliana${NC}  (público, sin README)"
echo -e "  ${GRN}3.${NC} Conecta y sube:"
echo ""
echo -e "     ${YEL}cd $PROJECT_DIR${NC}"
echo -e "     ${YEL}git remote add origin https://github.com/TU_USUARIO/para-iliana.git${NC}"
echo -e "     ${YEL}git branch -M main${NC}"
echo -e "     ${YEL}git push -u origin main${NC}"
echo ""
echo -e "  ${GRN}4.${NC} Activa GitHub Pages en:"
echo -e "     ${YEL}GitHub → Settings → Pages → Branch: main → Save${NC}"
echo ""
echo -e "  ${GRN}5.${NC} Tu enlace será:"
echo -e "     ${PNK}https://TU_USUARIO.github.io/para-iliana/${NC}"
echo ""
echo -e "  💕  ${PNK}¡Mucha suerte con Iliana!${NC}"
echo ""
