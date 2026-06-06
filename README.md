# 🌸 Iliana — Página Romántica

Página estática para pedirle a Iliana que sea tu novia. Sin backend, sin servidores.
Solo sube los archivos a GitHub Pages y comparte el enlace.

---

## 📁 Estructura de archivos

```
iliana/
├── index.html      ← Página principal
├── style.css       ← Estilos
├── script.js       ← Lógica y animaciones
├── musica.mp3      ← ⚠️ TÚ LA PONES (ver abajo)
├── README.md       ← Este archivo
└── setup.sh        ← Script de instalación automática
```

---

## 🎵 Añadir tu música

1. Consigue el archivo `.mp3` de la canción que quieres poner.
2. Renómbralo exactamente como **`musica.mp3`**.
3. Cópialo a la carpeta `iliana/`.

> Si la canción tiene otro nombre, también puedes editar `index.html` y cambiar
> `<source src="musica.mp3"` por el nombre correcto.

---

## 🚀 Subir a GitHub Pages desde Termux — Paso a paso

### Paso 0 — Instalar dependencias (solo la primera vez)

```bash
pkg update && pkg upgrade -y
pkg install git curl -y
```

### Paso 1 — Configurar tu identidad en Git

```bash
git config --global user.name  "TuNombreAqui"
git config --global user.email "tu@email.com"
```

### Paso 2 — Crear el repositorio en GitHub

Ve a **https://github.com/new** desde el navegador:
- **Repository name**: `para-iliana` (o el nombre que quieras)
- Visibilidad: **Public** (obligatorio para GitHub Pages gratis)
- **NO** inicialices con README
- Haz clic en **Create repository**

Copia la URL HTTPS del repo, por ejemplo:
`https://github.com/TuUsuario/para-iliana.git`

### Paso 3 — Inicializar el repositorio local en Termux

```bash
cd ~/iliana           # Entra a la carpeta del proyecto
git init
git add .
git commit -m "💌 Primera versión para Iliana"
```

### Paso 4 — Conectar con GitHub y subir

```bash
git remote add origin https://github.com/TuUsuario/para-iliana.git
git branch -M main
git push -u origin main
```

> Cuando Git pida contraseña, usa tu **token de acceso personal** de GitHub,
> NO tu contraseña de cuenta.
> Generas el token en: GitHub → Settings → Developer settings →
> Personal access tokens → Tokens (classic) → Generate new token
> (marca el permiso `repo`).

### Paso 5 — Activar GitHub Pages

**Opción A — Desde la web (más fácil):**
1. Ve a tu repositorio en GitHub.
2. Haz clic en **Settings** (arriba a la derecha).
3. Menú lateral → **Pages**.
4. En "Source" selecciona **Deploy from a branch**.
5. Branch: **main**, carpeta: **/ (root)**.
6. Clic en **Save**.

**Opción B — Usando la GitHub CLI desde Termux:**
```bash
# Instalar gh (GitHub CLI)
pkg install gh -y
gh auth login          # Sigue el proceso de autenticación

# Habilitar Pages via API
gh api repos/TuUsuario/para-iliana/pages \
  --method POST \
  --field source='{"branch":"main","path":"/"}'
```

### Paso 6 — Obtener el enlace

Después de 1-2 minutos, tu página estará en:

```
https://TuUsuario.github.io/para-iliana/
```

Comparte ese enlace con Iliana 💕

---

## 🔄 Actualizar la página (si haces cambios)

```bash
cd ~/iliana
git add .
git commit -m "✨ Actualización"
git push
```

Los cambios se reflejan en ~1 minuto.

---

## ✏️ Personalizar el contenido

| Qué cambiar | Dónde |
|------------|-------|
| Las 5 razones | `index.html` — sección `<div class="cards-grid">` |
| Fecha inicio contador | `script.js` — línea con `new Date('2026-05-07')` |
| Nombre "Iliana" | `index.html` — sección `hero-title` (letras individuales) |
| Música | Reemplaza `musica.mp3` |
| Colores | `style.css` — variables CSS arriba del todo |

---

## 🛠️ Solución de problemas

**La música no suena:**
Los navegadores móviles bloquean el autoplay. Toca el botón 🎵 de la esquina
inferior derecha para activarla.

**La página no carga en GitHub Pages:**
Espera 2-3 minutos y recarga. Si sigue fallando, verifica que el repo sea público
y que hayas seleccionado la rama `main`.

**El botón "No" no se mueve en móvil:**
En pantallas muy pequeñas el botón se deja en posición fija para no frustar
demasiado. Es intencional.

---

Hecho con 💚 y 💗 — Solo para Iliana.
