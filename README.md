<div align="center">

<!-- Gradient Title -->
<h1>
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=75&duration=1500&pause=1000&color=6366F1&background=00000000&center=true&vCenter=true&multiline=true&width=1000&height=200&lines=EWW+Dashboard;Universal+Edition" alt="EWW Dashboard" />
</h1>

<!-- Badges with gradients -->
<p align="center">
  <img src="https://img.shields.io/badge/Resolution-Works_on_ANY_Display-blueviolet?style=for-the-badge&logo=windowsterminal&logoColor=white" />
  <img src="https://img.shields.io/badge/EWW-Elkowar's_Wacky_Widgets-ff69b4?style=for-the-badge&logo=linux&logoColor=white" />
  <img src="https://img.shields.io/badge/License-GPL--3.0-blue?style=for-the-badge&logo=gnu&logoColor=white" />
  <img src="https://img.shields.io/badge/Status-Production-success?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Positioning-100%25_Responsive-orange?style=for-the-badge&logo=buffer&logoColor=white" />
</p>

<!-- Gradient Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=200&section=header&text=Universal%20Dashboard%20Widget&fontSize=50&fontColor=fff&animation=fadeIn&fontAlignY=38" />

</div>

---

<div align="center">

## 🎨 **About This Fork**

</div>

This is a heavily customized version of the **Dashboard widget** from [adi1090x/widgets](https://github.com/adi1090x/widgets), meticulously adapted and enhanced for **ANY display resolution** using 100% percentage-based positioning and responsive viewport units. Works seamlessly on 1366×768, 1920×1080, 2560×1440, 4K, ultrawide, and any other screen size—with zero pixel values ensuring perfect scaling.

> **✨ Original Work Credits:** Massive thanks to **[@adi1090x](https://github.com/adi1090x)** for creating the original beautiful EWW widgets collection that made this customization possible!

---

<div align="center">

## 🚀 **Key Features**

</div>

<table>
<tr>
<td width="50%">

### 🖥️ **100% Universal Resolution**
- **Zero pixel values** - everything uses percentages/vw
- Widget positions: percentage-based coordinates
- Font sizes: responsive viewport width (vw) units
- Margins/padding: vw units for perfect scaling
- Tested on 1366×768, 1920×1080, 2560×1440, 4K
- Works on ultrawide and portrait displays
- **Fixes GTK monitor detection error** with `:monitor 0`

</td>
<td width="50%">

### 🎭 **Custom Widgets**
- **Perplexity AI** quick-launch tile with SVG icon
- **Google** quick-launch tile with SVG icon
- **Volume control** bar with live monitoring
- **System updates** checker (Pacman + Flatpak)
- **Home folder** shortcut in folders widget
- **Weather widget** powered by Open-Meteo (no API key!)

</td>
</tr>
<tr>
<td width="50%">

### 🎨 **Visual Enhancements**
- Custom background image support with scaling
- Fully responsive spacing using vw units
- Viewport-based font sizing
- Centered app grid layout
- Nord-inspired color palette

</td>
<td width="50%">

### ⚡ **Functional Upgrades**
- **Toggle dashboard** - built-in open/close mechanism
- **Hyprlock** integration before suspend
- Dashboard open/close notifications
- Weather updates every 5 minutes (was 15m)
- Dynamic username detection with `whoami`
- Desktop-focused (removed battery/brightness)

</td>
</tr>
</table>

---

<div align="center">

## 🔧 **Critical Bug Fix Included**

</div>

### The "Failed to get primary monitor from GTK" Error

Many users encounter this error when opening EWW widgets:

```
Failed to open window 'example'.
Caused by: Failed to get primary monitor from GTK. 
Try explicitly specifying the monitor on your window.
```

**Our Solution**: Every window definition includes `:monitor 0` to explicitly specify the display:

```lisp
;; ❌ PROBLEMATIC (causes GTK monitor detection error):
(defwindow profile
  :geometry (geometry :x "5.5%" :y "14%" :width "18%" :height "41%")
  (user))

;; ✅ FIXED (explicitly specifies monitor):
(defwindow profile
  :monitor 0  # ← This fixes the GTK monitor detection error!
  :geometry (geometry :x "5.5%" :y "14%" :width "18%" :height "41%")
  (user))
```

**What `:monitor 0` does**:
- Explicitly tells EWW to display on monitor index 0 (primary display)
- Bypasses GTK's automatic monitor detection (which often fails on Wayland)
- Works on both X11 and Wayland compositors
- Compatible with Hyprland, Sway, i3, and other window managers

**For multiple monitors**: Change `:monitor 0` to `:monitor 1`, `:monitor 2`, etc.

---

<div align="center">

## 📐 **Universal Resolution Magic**

</div>

### How 100% Responsive Design Works

This dashboard uses **TWO layers of responsive design**:

#### 1. Widget Positioning (eww.yuck)
All windows use **percentage coordinates** instead of fixed pixels:

```lisp
;; ❌ OLD METHOD (Fixed pixels - breaks on different resolutions):
(defwindow profile :geometry (geometry :x 150 :y 150 :width 350 :height 440))

;; ✅ NEW METHOD (Percentages - works on ANY resolution):
(defwindow profile 
  :monitor 0  # Fixes GTK monitor detection
  :geometry (geometry :x "7.8%" :y "13.9%" :width "18.2%" :height "40.7%"))
```

#### 2. Widget Styling (eww.scss)
All sizes use **viewport width (vw) units** - no pixels anywhere:

```scss
/* ❌ OLD METHOD (Fixed pixels): */
.time_hour { font-size: 56px; margin: 8px; }

/* ✅ NEW METHOD (Viewport units): */
.time_hour { font-size: 4vw; margin: 0.6vw; }
```

**Result**: The dashboard automatically scales to ANY screen size—1366×768, 4K, ultrawide, anything!

### Resolution Compatibility

| Resolution | Aspect Ratio | Status | Notes |
|------------|-------------|--------|-------|
| **1366×768** | 16:9 | ✅ Perfect | Original design basis |
| **1920×1080** | 16:9 | ✅ Perfect | Full HD standard |
| **2560×1440** | 16:9 | ✅ Perfect | QHD/2K displays |
| **3840×2160** | 16:9 | ✅ Perfect | 4K/UHD displays |
| **2560×1080** | 21:9 | ✅ Works | Ultrawide (proportional scaling) |
| **1920×1200** | 16:10 | ✅ Works | Slightly different proportions |
| **Portrait** | Various | ⚠️ Not Tested | Designed for landscape |

### Why This Works

**Percentage-based positioning (eww.yuck)**:
- `x="5.5%"` means "5.5% from the left edge" - scales to any width
- `y="14%"` means "14% from the top" - scales to any height
- `width="18%"` means "18% of screen width" - proportional sizing

**Viewport units (eww.scss)**:
- `font-size: 4vw` means "4% of viewport width" - text scales automatically
- `margin: 0.6vw` means "0.6% of viewport width" - spacing scales proportionally
- `border-radius: 1.2vw` means "1.2% of viewport width" - rounded corners scale

---

<div align="center">

## 📋 **Detailed Customization Log**

</div>

### 🔧 **Configuration Changes (`eww.yuck`)**

<details>
<summary><b>👤 Profile Variables</b></summary>

#### Changes Made:
- **Profile Image Path**: Dynamic using `whoami` command  
  ```lisp
  (defpoll IMAGE :interval "0" `echo "/usr/share/sddm/faces/$(whoami).face.icon"`)
  ```
- **Display Name**: Universal placeholder
  ```lisp
  (defvar NAME "YOUR NAME")
  ```
- **Username**: Dynamic with `whoami`
  ```lisp
  (defpoll UNAME :interval "5m" `whoami`)
  ```

**Why?** Makes the widget portable across different user accounts and systems without hardcoding personal information.

</details>

<details>
<summary><b>⚙️ System Variables</b></summary>

#### Changes Made:

1. **Volume Monitor**: **NEW** - Real-time audio volume tracking
   ```lisp
   (defpoll VOLUME :interval "1s" `amixer get Master | grep -o '[0-9]*%' | head -1 | tr -d '%'`)
   ```

2. **System Updates**: **NEW** - Checks both Pacman and Flatpak updates
   ```lisp
   (defpoll UPDATES :interval "1m" `TOTAL=$(($(checkupdates | wc -l) + $(flatpak remote-ls --updates | tail -n +2 | wc -l))); 
   if [ $TOTAL -gt 0 ]; then echo "Updates Available"; else echo "No Updates Available"; fi`)
   ```

3. **Removed**: Battery and brightness monitors (desktop-focused build)

**Why?** Tailored for desktop use with relevant system metrics; removed laptop-specific sensors.

</details>

<details>
<summary><b>🌤️ Weather Variables</b></summary>

#### Changes Made:
- **Weather API**: Uses **Open-Meteo API** (NO API KEY REQUIRED!)
  ```bash
  # In scripts/weather_info:
  url="https://api.open-meteo.com/v1/forecast?latitude=${LAT}&longitude=${LON}&current=temperature_2m,weather_code"
  ```

- **Update Frequency**: Increased from **15 minutes** → **5 minutes**
  ```lisp
  (defpoll ICON :interval "5m" `scripts/weather_info --icon`)
  (defpoll STAT :interval "5m" `scripts/weather_info --stat`)
  (defpoll TEMP :interval "5m" `scripts/weather_info --temp`)
  ```

- **Location-Based**: Uses latitude/longitude coordinates instead of city name
  ```bash
  LAT="00.0000"  # Change your location accordingly (instructions provided below)
  LON="00.0000"
  ```

**Why?** Open-Meteo is completely free, requires no API key, and provides reliable weather data. More responsive updates (5min vs 15min) for rapidly changing conditions.

</details>

<details>
<summary><b>🎛️ System Widget</b></summary>

#### Changes Made:
- **Replaced** brightness bar → **Volume bar**
- **Replaced** battery bar → **Update Checker Button** (clickable)
- **Spacing**: Optimized for compact layout

**Why?** Desktop-relevant metrics with clickable update checker for quick system maintenance.

</details>

<details>
<summary><b>📱 Applications Widget</b></summary>

#### Changes Made:
**Original Apps**: Firefox, Telegram, Discord, Terminal, Files, Geany, Code, Gimp, VirtualBox

**Custom Apps**:
| Row | App 1 | App 2 | App 3 |
|-----|-------|-------|-------|
| **1** | Firefox | Notepadqq | Blender |
| **2** | Terminal | Files | Metasploit |
| **3** | VS Code | Burp Suite | Boxes |

- **Layout**: Perfect centering with `:halign "center"` and `:space-evenly "true"`

**Why?** Personalized app selection reflecting cybersecurity/development workflow; improved visual alignment.

</details>

<details>
<summary><b>🌐 Quick Links Section</b></summary>

#### Changes Made:
1. **NEW - Perplexity AI Tile**: High-quality SVG icon implementation
2. **NEW - Google Tile**: SVG icon with centered layout
3. **Replaced**: Twitter → Perplexity
4. **Mail Widget**: Simplified to icon-only (removed badge counter)

**Layout**:
| GitHub | Reddit | Perplexity | YouTube | GMail | Google |
|--------|--------|------------|---------|-------|--------|

**Why?** Added frequently-used AI tool (Perplexity) and Google; streamlined mail widget.

</details>

<details>
<summary><b>📁 Folders Widget</b></summary>

#### Changes Made:
1. **NEW - Home Folder**: Added as first entry
2. **Updated Path**: `~/.local` → `~/.local/share`

**Folder List**:
- 🏠 Home
- 📄 Documents
- ⬇️ Downloads
- 🎵 Music
- 🖼️ Pictures
- ⚙️ ~/.config
- 📦 ~/.local/share

**Why?** Quick access to home directory; corrected .local path to actual user data location.

</details>

<details>
<summary><b>🔌 Power Buttons</b></summary>

#### Changes Made:
1. **Logout Button**: Closes dashboard with notification
2. **Sleep Button**: Integrates Hyprlock before suspend for security

**Why?** Graceful dashboard closing; enhanced security with screen lock.

</details>

<details>
<summary><b>🪟 Window Definitions - THE GAME CHANGER</b></summary>

#### Revolutionary Change: 100% Percentage-Based Positioning + Monitor Fix

This is the single most important customization that makes the dashboard universal!

**All Widget Positions (Percentage-Based with `:monitor 0` fix)**:

| Widget | X Position | Y Position | Width | Height |
|--------|-----------|-----------|--------|---------|
| **Background** | 0% | 0% | 100% | 100% |
| **Profile** | 5.5% | 14% | 18% | 41% |
| **System** | 5.5% | 56% | 18% | 30% |
| **Clock** | 27% | 14% | 18% | 14.5% |
| **Uptime** | 27% | 30% | 18% | 14.5% |
| **Music** | 27% | 45.5% | 32% | 26% |
| **Weather** | 46% | 14% | 28.5% | 30% |
| **Apps** | 59.5% | 45.5% | 15% | 26% |
| **GitHub** | 27% | 73% | 7.5% | 13.5% |
| **Reddit** | 35% | 73% | 7.5% | 13.5% |
| **Perplexity** | 43.5% | 73% | 7.5% | 13.5% |
| **YouTube** | 51.5% | 73% | 7.5% | 13.5% |
| **Mail** | 59.5% | 73% | 7.5% | 13.5% |
| **Google** | 67.5% | 73% | 7.5% | 13.5% |
| **Logout** | 75.5% | 14% | 8% | 14.5% |
| **Sleep** | 84% | 14% | 8% | 14.5% |
| **Reboot** | 75.5% | 30% | 8% | 14.5% |
| **Poweroff** | 84% | 30% | 8% | 14.5% |
| **Folders** | 75.5% | 45.5% | 17% | 41% |

**Example with monitor fix**:
```lisp
;; Includes :monitor 0 to prevent GTK errors - works on ANY resolution:
(defwindow profile 
  :stacking "fg" 
  :focusable "false" 
  :monitor 0  # ← Critical: Prevents "Failed to get primary monitor" error
  :geometry (geometry :x "5.5%" :y "14%" :width "18%" :height "41%")
  (user))
```

**Why?** 
- Zero pixels = zero alignment issues on ANY screen resolution!
- `:monitor 0` = no more GTK monitor detection errors!

</details>

---

### 🎨 **Styling Changes (`eww.scss`)**

<details>
<summary><b>🎯 100% Responsive Design</b></summary>

#### Revolutionary Change: Viewport Width (vw) Units

**ALL sizes converted from pixels to viewport width units**:

```scss
/* Font sizes use vw (scales with screen width) */
.fullname { font-size: 1.9vw; }  /* Was 26px */
.time_hour { font-size: 4vw; }   /* Was 56px */
.iconweather { font-size: 5.2vw; } /* Was 72px */

/* Margins use vw (proportional spacing) */
.genwin { padding: 0.7vw 0.9vw; }  /* Was 10px 12px */
.face { margin: 1.2vw 0 0 0; }     /* Was 16px */

/* Border radius uses vw (scales proportionally) */
.genwin { border-radius: 1.2vw; }  /* Was 16px */

/* Sizes use vw (fully responsive) */
.face { min-height: 13vw; min-width: 13vw; }  /* Was 180px */
.album_art { min-height: 13vw; min-width: 13vw; }  /* Was 180px */
```

**Conversion Formula**: 1vw ≈ 0.073% of viewport width (based on 1366px reference)

**Why?** Every single dimension scales automatically—no misalignment possible on any resolution!

</details>

<details>
<summary><b>🖼️ Background</b></summary>

```scss
.bg {
  background-image: url("images/bg.png");
  background-color: #474D59;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}
```

**Why?** Custom background image with fallback color; scales to any resolution automatically.

</details>

<details>
<summary><b>👤 Profile, ⚙️ System, 🕐 Clock, 🎵 Music, etc.</b></summary>

All widget styles use **vw units** for:
- Font sizes (1vw to 5.2vw range)
- Margins and padding (0.4vw to 2.3vw range)
- Border radius (0.6vw to 1.2vw range)
- Widget dimensions (3.2vw to 13vw range)

**Result**: Perfect proportional scaling on every screen size!

</details>

---

<div align="center">

## 📦 **Installation**

</div>

### Prerequisites
```bash
# Install EWW (Elkowar's Wacky Widgets)
# Follow instructions at: https://elkowar.github.io/eww
```

### Quick Setup
```bash
# Use install.sh script provided
# It will automatically install all required dependencies

chmod +x install.sh
./install.sh
```

### Launch Dashboard
```bash
# The dashboard includes a toggle script
~/.config/eww/dashboard/launch_dashboard

# First run: Opens the dashboard
# Second run: Closes the dashboard
# Notifications confirm open/close state
```

### Keybinding (Hyprland Example)
```conf
# ~/.config/hypr/hyprland.conf
bind = SUPER, D, exec, ~/.config/eww/dashboard/launch_dashboard
```

### Keybinding (i3/i3-gaps Example)
```conf
# ~/.config/i3/config
bindsym $mod+d exec ~/.config/eww/dashboard/launch_dashboard
```

**Note**: The `launch_dashboard` script automatically toggles the dashboard open/close with notifications!

---

<div align="center">

## 🔧 **Configuration**

</div>

### Personalization

#### Update Your Name
```lisp
# In eww.yuck, line 12:
(defvar NAME "Your Actual Name")
```

The username and profile image will be automatically detected using `whoami` - no changes needed!

### Weather Setup (NO API KEY NEEDED!)

The weather widget uses **Open-Meteo**, which is completely free and requires no API key!

```bash
# Edit scripts/weather_info
nano ~/.config/eww/dashboard/scripts/weather_info

# Update these lines with YOUR coordinates:
LAT="26.7496"  # Your latitude
LON="88.4434"  # Your longitude
UNIT="metric"  # or "imperial" for Fahrenheit
```

#### How to Find Your Coordinates:

1. **Google Maps Method**:
   - Go to https://www.google.com/maps
   - Right-click your location → "What's here?"
   - Copy the coordinates (e.g., "26.7496, 88.4434")

2. **Command Line Method**:
   ```bash
   curl -s "https://ipapi.co/json/" | jq -r '.latitude, .longitude'
   ```

3. **Online Tools**:
   - https://www.latlong.net/
   - https://www.gps-coordinates.net/

### Custom Apps

The dashboard closes automatically when launching apps (built into `scripts/open_apps`).

To customize the apps:
1. Edit `eww.yuck` - change app icon paths
2. Edit `scripts/open_apps` - change app launch commands

Example in `scripts/open_apps`:
```bash
elif [[ "$1" == "--yourapp" ]]; then
    close_dash && your-app-command &
fi
```

---

<div align="center">

## 📸 **Screenshots**

</div>

> *Add your screenshots here once you've launched the dashboard!*

---

<div align="center">

## 🙏 **Credits**

</div>

### Original Author
- **[@adi1090x](https://github.com/adi1090x)** - Creator of the original widgets collection
- **Repository**: [adi1090x/widgets](https://github.com/adi1090x/widgets)
- **License**: GPL-3.0

### Customization
- **Modified By**: Ishaan Gupta
- **Year**: 2025
- **Major Innovation**: 100% percentage-based positioning + viewport units (zero pixels!)
- **Weather Integration**: Open-Meteo API (no API key required)
- **Bug Fix**: GTK monitor detection error fix with `:monitor 0`

### EWW Framework
- **[@elkowar](https://github.com/elkowar)** - Creator of EWW (Elkowar's Wacky Widgets)
- **Repository**: [elkowar/eww](https://github.com/elkowar/eww)

### Weather Data
- **Open-Meteo** - Free weather API with no API key requirement
- **Website**: https://open-meteo.com/
- **License**: CC BY 4.0

---

<div align="center">

## 📜 **License**

</div>

This customized version is released under the **GPL-3.0 License**, maintaining compliance with the original project's license.

```
Copyright (C) 2025 Ishaan Gupta
Copyright (C) 2021-2024 Aditya Shakya (@adi1090x)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
```

**Key License Points**:
- ✅ Fork and modify freely
- ✅ Distribute modified versions
- ✅ Must keep same GPL-3.0 license
- ✅ Must credit original author
- ✅ Must document changes

Full license: [LICENSE](LICENSE)

---

<div align="center">

## 🐛 **Troubleshooting**

</div>

<details>
<summary><b>Dashboard doesn't appear</b></summary>

```bash
# Check EWW is running
eww ping

# Check for errors
eww logs

# Kill existing instance and retry
eww kill
~/.config/eww/dashboard/launch_dashboard
```
</details>

<details>
<summary><b>Weather not updating or shows "Weather Unavailable"</b></summary>

**Check coordinates:**
```bash
# Test your weather_info script
~/.config/eww/dashboard/scripts/weather_info --temp
~/.config/eww/dashboard/scripts/weather_info --stat
```

**Common issues:**
1. **Wrong coordinates**: Verify LAT/LON in `scripts/weather_info`
2. **Missing curl or jq**:
   ```bash
   # Arch Linux
   sudo pacman -S curl jq

   # Debian/Ubuntu
   sudo apt install curl jq
   ```
3. **No internet connection**: Weather requires internet access
4. **Cache directory permissions**:
   ```bash
   mkdir -p ~/.cache/eww/weather
   chmod 755 ~/.cache/eww/weather
   ```

</details>

<details>
<summary><b>Toggle not working properly</b></summary>

The toggle mechanism uses a cache file. If it gets stuck:

```bash
# Reset the toggle state
rm ~/.cache/eww_launch.dashboard

# Restart dashboard
~/.config/eww/dashboard/launch_dashboard
```
</details>

---

<div align="center">

## 💡 **Tips & Tricks**

</div>

### Launch on Startup

**Hyprland**:
```conf
# ~/.config/hypr/hyprland.conf
exec-once = ~/.config/eww/dashboard/launch_dashboard
```

**i3/i3-gaps**:
```conf
# ~/.config/i3/config
exec --no-startup-id ~/.config/eww/dashboard/launch_dashboard
```

**Sway**:
```conf
# ~/.config/sway/config
exec ~/.config/eww/dashboard/launch_dashboard
```

### Per-Widget Control

```bash
# Open/close individual widgets
eww open music
eww close music

# Update widget values manually
eww update TEMP="25°C"
eww update VOLUME=75

# Reload configuration after changes
eww reload

# Force weather refresh
~/.config/eww/dashboard/scripts/weather_info --getdata
```

### Multiple Monitors

The dashboard works on the primary monitor (`:monitor 0`). To display on a different monitor:

```lisp
# Change :monitor 0 to :monitor 1 (or 2, etc.) in all window definitions
(defwindow profile :monitor 1 ...)  # Display on second monitor
```

---

<div align="center">

## 🤝 **Contributing**

</div>

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Test on multiple resolutions** (minimum: 1920×1080 and 2560×1440)
4. **Maintain 100% responsive design** (no pixel values!)
5. **Include `:monitor 0`** in all window definitions
6. Commit changes (`git commit -m 'Add: Amazing new feature'`)
7. Push to branch (`git push origin feature/AmazingFeature`)
8. Open a Pull Request with screenshots

### Contribution Ideas
- New widget designs (using vw/percentage units!)
- Additional quick-launch tiles
- Alternative color schemes
- Support for other Linux distros
- Improved scripts
- Alternative weather APIs

---

<div align="center">

## ⭐ **Show Your Support**

</div>

If you found this customization helpful:
- ⭐ **Star** this repository
- 🔀 **Fork** and create your own variant
- 📢 **Share** with the linux community
- 💬 **Post** your customized version with screenshots
- ☕ **Support** the original author [@adi1090x](https://github.com/adi1090x)

---

<div align="center">

## 📞 **Contact**

</div>

- **GitHub**: @DragonPlayz-1

---

<div align="center">

<!-- Gradient Footer -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=150&section=footer&text=100%25%20Responsive%20%E2%80%A2%20Zero%20Pixels%20%E2%80%A2%20No%20GTK%20Errors%20%F0%9F%9A%80&fontSize=20&fontColor=fff&animation=fadeIn" />

**[⬆ Back to Top](#)**

</div>

