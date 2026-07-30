# 🌀 Brourian

<div align="center">

# Brourian Framework

### *A declarative Debian bootstrap for developers.*

Transforma una instalación mínima de Debian en un entorno de trabajo moderno, ligero, reproducible y preparado para desarrollo.

<p>

<img src="https://img.shields.io/badge/Debian-13%20(Trixie)-A81D33?style=for-the-badge&logo=debian&logoColor=white">

<img src="https://img.shields.io/badge/Window_Manager-i3wm-2E9EF4?style=for-the-badge&logo=i3&logoColor=white">

<img src="https://img.shields.io/badge/Shell-Zsh-89E051?style=for-the-badge&logo=gnu-bash&logoColor=white">

<img src="https://img.shields.io/badge/Compositor-Picom-8A2BE2?style=for-the-badge">

<img src="https://img.shields.io/badge/License-MIT-success?style=for-the-badge">

<img src="https://img.shields.io/badge/Status-Active-brightgreen?style=for-the-badge">

</p>

---

*"Configure once. Work forever."*

</div>

---

# ✨ ¿Qué es Brourian?

**Brourian** no es únicamente una colección de *dotfiles*.

Es un **framework de despliegue declarativo** que automatiza la configuración completa de un sistema Debian minimalista, proporcionando un entorno consistente, elegante y reproducible para desarrollo, programación y ciberseguridad.

Su objetivo es que una instalación limpia pueda convertirse en un escritorio completamente funcional ejecutando un único comando.

El proyecto está inspirado en la simplicidad de **Omarchy**, la reproducibilidad de **Nix**, y la estabilidad del ecosistema **Debian**, pero sin añadir complejidad innecesaria.

---

# 🎯 Filosofía

Brourian sigue cinco principios fundamentales:

* 🧩 **Modular** — Cada componente puede reemplazarse fácilmente.
* 🔁 **Reproducible** — El mismo resultado en cualquier instalación.
* 🚀 **Ligero** — Solo instala lo necesario.
* 🛡️ **Estable** — Basado completamente en Debian.
* 📦 **Idempotente** — Puede ejecutarse múltiples veces sin romper el sistema.

---

# 🖥️ Tecnologías

| Componente              | Software               |
| ----------------------- | ---------------------- |
| Distribución            | Debian 13 (Trixie)     |
| Display Server          | X11                    |
| Window Manager          | i3wm                   |
| Terminal                | Kitty                  |
| Launcher                | Rofi                   |
| Barra                   | Polybar                |
| Compositor              | Picom                  |
| Shell                   | Zsh                    |
| Audio                   | PipeWire + WirePlumber |
| Información del sistema | Fastfetch              |
| Gestor de red           | NetworkManager         |
| Editor recomendado      | Zed                    |

---

# 📂 Arquitectura

```text
brourian/
│
├── assets/
│   ├── fonts/
│   ├── wallpapers/
│   ├── icons/
│   └── themes/
│
├── configs/
│   ├── i3/
│   ├── kitty/
│   ├── polybar/
│   ├── picom/
│   ├── rofi/
│   ├── fastfetch/
│   └── ...
│
├── home/
│   ├── .zshrc
│   └── .xinitrc
│
├── scripts/
│   ├── install/
│   ├── system/
│   ├── utils/
│   └── services/
│
├── install.sh
├── LICENSE
└── README.md
```

---

# 🚀 Instalación

## 1. Instalar Git

```bash
sudo apt update
sudo apt install git -y
```

## 2. Clonar el repositorio

```bash
git clone https://github.com/brousselfx/brourian.git
```

## 3. Entrar al proyecto

```bash
cd brourian
```

## 4. Dar permisos

```bash
chmod +x install.sh
```

## 5. Ejecutar

```bash
./install.sh
```

Al finalizar solo inicia la sesión gráfica:

```bash
startx
```

---

# ⚡ ¿Qué instala?

✔ Xorg

✔ i3wm

✔ Kitty

✔ Polybar

✔ Picom

✔ Rofi

✔ PipeWire

✔ WirePlumber

✔ NetworkManager

✔ Fastfetch

✔ Zsh

✔ Utilidades del sistema

✔ Fuentes

✔ Wallpapers

✔ Temas

✔ Configuración personalizada

✔ Servicios necesarios

---

# 🔄 Flujo de instalación

```text
Debian Minimal
       │
       ▼
Actualizar repositorios
       │
       ▼
Instalar paquetes
       │
       ▼
Configurar servicios
       │
       ▼
Copiar dotfiles
       │
       ▼
Instalar fuentes
       │
       ▼
Configurar shell
       │
       ▼
Configurar X11
       │
       ▼
Sistema listo
```

---

# 📸 Características

* 🎨 Apariencia moderna
* ⚡ Arranque rápido
* 🧩 Configuración modular
* 🔒 Basado en Debian Stable
* 📦 Instalación automatizada
* 🧹 Configuración limpia
* 🔁 Fácil mantenimiento
* 💻 Pensado para desarrolladores
* 🛡️ Ideal para laboratorios de ciberseguridad
* 🚀 Alto rendimiento incluso en hardware modesto

---

# 🛠️ Requisitos

* Debian 13 (Trixie) Minimal
* Arquitectura AMD64
* Conexión a Internet
* Usuario con permisos sudo

---

# 🧰 Solución de problemas

## i3 no inicia

```bash
echo "exec i3" > ~/.xinitrc
```

---

## No hay audio

```bash
systemctl --user restart wireplumber
systemctl --user restart pipewire
```

---

## Las fuentes no aparecen

```bash
fc-cache -fv
```

---

## Polybar no inicia

```bash
killall polybar
polybar main &
```

---

# 🗺️ Roadmap

* [x] Instalador automático
* [x] Dotfiles
* [x] Configuración modular
* [x] PipeWire
* [x] Polybar
* [x] Picom
* [ ] Wayland Edition
* [ ] Paquetes opcionales
* [ ] Instalación interactiva
* [ ] Temas múltiples
* [ ] Actualizador del framework
* [ ] Instalador para Debian 12
* [ ] Soporte para máquinas virtuales
* [ ] Documentación completa

---

# 🤝 Contribuciones

Las contribuciones son bienvenidas.

Si encuentras un error o tienes una idea para mejorar Brourian, abre un **Issue** o envía un **Pull Request**.

---

# 📜 Licencia

Este proyecto se distribuye bajo la licencia **MIT**.

Puedes usarlo, modificarlo y compartirlo libremente respetando los términos de dicha licencia.

---

<div align="center">

## 🌀 Brourian

### *Minimal. Elegant. Reproducible.*

Construido con ❤️ sobre Debian.

</div>
