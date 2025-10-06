<div align="center">

<!-- Gradient Title -->
<h1>
  <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&size=75&duration=1500&pause=1000&color=6366F1&background=00000000&center=true&vCenter=true&multiline=true&width=1000&height=200&lines=EWW+Dashboard;Customized+Edition" alt="EWW Dashboard" />
</h1>

<!-- Badges with gradients -->
<p align="center">
  <img src="https://img.shields.io/badge/Resolution-1366x768-blueviolet?style=for-the-badge&logo=windowsterminal&logoColor=white" />
  <img src="https://img.shields.io/badge/EWW-Elkowar's_Wacky_Widgets-ff69b4?style=for-the-badge&logo=linux&logoColor=white" />
  <img src="https://img.shields.io/badge/License-GPL--3.0-blue?style=for-the-badge&logo=gnu&logoColor=white" />
  <img src="https://img.shields.io/badge/Status-Production-success?style=for-the-badge" />
</p>

<!-- Gradient Banner -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=200&section=header&text=Customized%20Dashboard%20Widget&fontSize=50&fontColor=fff&animation=fadeIn&fontAlignY=38" />

</div>

---

<div align="center">

## 🎨 **About This Fork**

</div>

This is a heavily customized version of the **Dashboard widget** from [adi1090x/widgets](https://github.com/adi1090x/widgets), meticulously adapted and enhanced for a **1366x768 display** with numerous personal modifications, new features, and optimizations.

> **✨ Original Work Credits:** Massive thanks to **[@adi1090x](https://github.com/adi1090x)** for creating the original beautiful EWW widgets collection that made this customization possible!

---

<div align="center">

## 🚀 **Key Features**

</div>

<table>
<tr>
<td width="50%">

### 🖥️ **Resolution Adapted**
- Fully ported from **1920x1080** to **1366x768**
- All widget positions recalculated
- Responsive background scaling
- Universal monitor support (`:monitor 0`)

</td>
<td width="50%">

### 🎭 **Custom Widgets**
- **Perplexity AI** quick-launch tile
- **Google** quick-launch tile  
- **Volume control** bar with live monitoring
- **System updates** checker (Pacman + Flatpak)

</td>
</tr>
<tr>
<td width="50%">

### 🎨 **Visual Enhancements**
- Custom background image support
- Refined spacing and padding
- Optimized font sizes for smaller screens
- Centered app grid layout

</td>
<td width="50%">

### ⚡ **Functional Upgrades**
- Hyprlock integration for sleep
- Dashboard close notification
- Home folder shortcut added
- Weather updates every 5 minutes

</td>
</tr>
</table>

---

<div align="center">

## 📋 **Detailed Customization Log**

</div>

### 🔧 **Configuration Changes (`eww.yuck`)**

<details>
<summary><b>👤 Profile Variables</b></summary>

#### Changes Made:
- **Profile Image Path**: Changed to system face icon location  
  ```lisp
  (defvar IMAGE "/usr/share/sddm/faces/YOUR_USERNAME.face.icon")
  ```
- **Display Name**: Set to dynamic using `whoami` command
  ```lisp
  (defvar NAME "YOUR NAME")
  ```
- **Username**: Uses `whoami` for universal compatibility
  ```lisp
  (defvar UNAME "YOUR_USERNAME")
  ```

**Why?** Makes the widget portable across different user accounts without hardcoding personal information.

</details>

<details>
<summary><b>⚙️ System Variables</b></summary>

#### Changes Made:
1. **Hostname**: Now a static variable instead of polling
   ```lisp
   (defvar HOST "YOUR_HOSTNAME")
   ```

2. **Volume Monitor**: **NEW** - Real-time audio volume tracking
   ```lisp
   (defpoll VOLUME :interval "1s" `amixer get Master | grep -o '[0-9]*%' | head -1 | tr -d '%'`)
   ```

3. **System Updates**: **NEW** - Checks both Pacman and Flatpak updates
   ```lisp
   (defpoll UPDATES :interval "1m" `TOTAL=$(($(checkupdates | wc -l) + $(flatpak remote-ls --updates | tail -n +2 | wc -l))); 
   if [ $TOTAL -gt 0 ]; then echo "Updates Available"; else echo "No Updates Available"; fi`)
   ```

4. **Removed**: Battery and brightness monitors (desktop-focused build)

**Why?** Tailored for desktop use with relevant system metrics; removed laptop-specific sensors.

</details>

<details>
<summary><b>🌤️ Weather Variables</b></summary>

#### Changes Made:
- **Update Frequency**: Increased from **15 minutes** → **5 minutes**
  ```lisp
  (defpoll ICON :interval "5m" `scripts/weather_info --icon`)
  (defpoll STAT :interval "5m" `scripts/weather_info --stat`)
  (defpoll TEMP :interval "5m" `scripts/weather_info --temp`)
  ```

**Why?** More responsive weather information for rapidly changing conditions.

</details>

<details>
<summary><b>🎛️ System Widget</b></summary>

#### Changes Made:
- **Replaced** brightness bar → **Volume bar**
  ```lisp
  (box :class "vol_bar" :orientation "h" :spacing 20
    (label :class "iconvolume" :text "")
    (scale :min 0 :max 100 :value VOLUME :active "false"))
  ```

- **Replaced** battery bar → **Update Checker Button**
  ```lisp
  (button :class "update_bar" :onclick "scripts/open_links --update"
    (box :orientation "h" :spacing 20
      (label :class "iconupdate" :text "")
      (label :class "labelupdate" :text UPDATES)))
  ```

- **Spacing**: Reduced from 35px → 20px for compact layout

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

- **Layout**: Added `:halign "center"` with `:space-evenly "true"` for perfect centering
- **Spacing**: Set to 8px between icons

**Why?** Personalized app selection reflecting cybersecurity/development workflow; improved visual alignment.

</details>

<details>
<summary><b>🌐 Quick Links Section</b></summary>

#### Changes Made:
1. **NEW - Perplexity AI Tile**: High-quality SVG icon implementation
   ```lisp
   (defwidget perplexity []
     (box :class "perplexity"
       (button :onclick "scripts/open_links --pr"
         (image :path "/home/YOUR_USER/.config/eww/dashboard/images/perplexity.svg"
                :image-width 80 :image-height 80))))
   ```

2. **NEW - Google Tile**: SVG icon with centered layout
   ```lisp
   (defwidget google []
     (box :class "google"
       (button :onclick "scripts/open_links --google"
         (image :path "/home/YOUR_USER/.config/eww/dashboard/images/google.svg"
                :image-width 80 :image-height 80))))
   ```

3. **Replaced**: Twitter → Perplexity

4. **Mail Widget**: Simplified to icon-only (removed badge counter)

**Layout**:
| GitHub | Reddit | Perplexity | YouTube |
|--------|--------|------------|---------|
| **Mail** | **Google** | | |

**Why?** Added frequently-used AI tool (Perplexity) and Google; streamlined mail widget without notification complexity.

</details>

<details>
<summary><b>📁 Folders Widget</b></summary>

#### Changes Made:
1. **NEW - Home Folder**: Added as first entry
   ```lisp
   (box :orientation "h"
     (button :class "iconfolder0" :onclick "scripts/open_folders --home" "")
     (button :class "label_folder0" :onclick "scripts/open_folders --home" "Home"))
   ```

2. **Updated Path**: `~/.local` → `~/.local/share` (more accurate target)

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
1. **Logout Button**:
   - **Original**: `openbox --exit`
   - **Custom**: `notify-send "Dashboard Widget Closed." && pkill eww`

   **Why?** Gracefully closes the dashboard with user notification; no desktop environment dependency.

2. **Sleep Button**:
   - **Original**: `systemctl suspend`
   - **Custom**: `hyprlock & systemctl suspend`

   **Why?** Locks screen with Hyprlock before suspending for security.

</details>

<details>
<summary><b>🪟 Window Definitions</b></summary>

#### Changes Made:
1. **Monitor Selection**: `:screen 1` → `:monitor 0` (universal compatibility)

2. **Background Window**: 
   - **Original**: `1920px × 1080px`
   - **Custom**: `100% × 100%` (responsive)

3. **All Widget Positions**: Recalculated from 1920×1080 to 1366×768
   - Example: Profile widget `150, 150, 350×440` → `107, 107, 249×313`
   - Scaling factor: ~0.711 (1366/1920)

**Why?** Perfect fit for 1366×768 displays while maintaining aspect ratios and layout integrity.

</details>

---

### 🎨 **Styling Changes (`eww.scss`)**

<details>
<summary><b>🖼️ Background</b></summary>

#### Changes Made:
```scss
.bg {
  background-image: url("images/bg.png");        // NEW: Custom wallpaper
  background-color: #474D59;                     // Changed from transparent
  background-size: cover;                        // NEW: Responsive scaling
  background-position: center;                   // NEW: Center alignment
  background-repeat: no-repeat;                  // NEW: No tiling
}
```

**Why?** Custom background image with fallback color; scales to any resolution.

</details>

<details>
<summary><b>🎭 Generic Window</b></summary>

#### Changes Made:
```scss
.genwin {
  padding: 10px 12px;  // NEW: Internal spacing
}
```

**Why?** Prevents content from touching edges; improves visual breathing room.

</details>

<details>
<summary><b>👤 Profile Face</b></summary>

#### Changes Made:
```scss
.face {
  min-height: 180px;    // 160px → 180px
  min-width: 180px;     // 160px → 180px
  margin: 16px 0 0 0;   // 20px → 16px (top margin)
}
```

**Why?** Slightly larger profile picture with adjusted spacing for 768p layout.

</details>

<details>
<summary><b>⚙️ System Icons & Bars</b></summary>

#### Changes Made:
```scss
.iconcpu, .iconmem, .iconbright, .iconbat {
  font-size: 28px;  // 24px → 28px (larger icons)
}

.cpu_bar, .mem_bar, .bright_bar, .bat_bar, scale trough {
  min-width: 200px;  // 180px → 200px (longer bars)
}
```

**Why?** Better visibility on smaller screens; improved readability.

</details>

<details>
<summary><b>🕐 Clock</b></summary>

#### Changes Made:
```scss
.time_hour, .time_min { font-size: 56px; }      // Balanced size
.time_hour { margin: 8px 0 0 12px; }            // Refined positioning
.time_mer { font-size: 28px; margin: 8px 0 0 0; }
.time_day { font-size: 20px; margin: 0 0 10px -10px; }
```

**Why?** Optimized time display proportions for 249×110px widget window.

</details>

<details>
<summary><b>🎵 Music Player</b></summary>

#### Changes Made:
```scss
.album_art {
  min-height: 180px;  // 160px → 180px
  min-width: 180px;
  margin: 10px;       // 12px → 10px
}

.music_bar scale trough {
  min-height: 12px;
  min-width: 200px;
}
```

**Why?** Balanced album art size with compact progress bar for 434×199px window.

</details>

<details>
<summary><b>🌤️ Weather</b></summary>

#### Changes Made:
```scss
.iconweather { 
  font-size: 72px;           // 60px → 72px (more prominent)
  margin: 8px 0 0 12px; 
}
.label_temp { font-size: 48px; }
.label_stat { font-size: 24px; }    // 25px → 24px
.label_quote { font-size: 14px; }   // 18px → 14px
```

**Why?** Emphasized weather icon; scaled text for 391×231px widget space.

</details>

<details>
<summary><b>📱 Applications Grid</b></summary>

#### Changes Made:
```scss
.appbox { margin: 8px 0 0 12px; }

.app_fox, .app_telegram, /* ... */ .app_vbox {
  background-size: 44px 44px;
  min-height: 44px;
  min-width: 44px;
  margin: 6px;  // 4px → 6px (better spacing)
}
```

**Why?** Tighter margins fit 3×3 grid perfectly in 206×199px window.

</details>

<details>
<summary><b>🌐 Quick Links Tiles</b></summary>

#### Changes Made:
```scss
.github, .reddit, .twitter, .youtube, .mail {
  min-width: 90px;   // Unified sizing
  min-height: 90px;
  padding: 8px;
}

.iconweb, .iconmail {
  font-size: 40px;  // 42px → 40px (fits 90×90 boxes)
}
```

**Why?** Consistent tile dimensions; icons perfectly centered in ~100×103px windows.

</details>

<details>
<summary><b>🔌 Power Buttons</b></summary>

#### Changes Made:
```scss
.btn_logout, .btn_sleep, .btn_reboot, .btn_poweroff {
  font-size: 32px;  // Maintained size
}
```

**Why?** Icons scale well in 110×110px buttons; no change needed.

</details>

<details>
<summary><b>📁 Folders</b></summary>

#### Changes Made:
```scss
.iconfolder0 { color: #88C0D0; }  // NEW: Home folder style

.iconfolder1, /* ... */ .iconfolder6 {
  font-size: 22px;      // 20px → 22px
  margin: 0 0 0 32px;   // 35px → 32px
}

.label_folder1, /* ... */ .label_folder6 {
  font-size: 16px;      // 14px → 16px
  margin: 0 0 0 14px;   // 15px → 14px
}
```

**Why?** Added styling for new Home folder; improved readability with slightly larger text.

</details>

---

<div align="center">

## 📦 **Installation**

</div>

### Prerequisites
```bash
# Install EWW (Elkowar's Wacky Widgets)
# Follow instructions at: https://elkowar.github.io/eww

# Required fonts
- Iosevka
- Iosevka Nerd Font
- Feather Icons
```

### Quick Setup
```bash
# 1. Clone this repository
git clone --depth=1 https://github.com/YOUR_USERNAME/eww-dashboard-custom.git

# 2. Backup existing EWW config (if any)
mv ~/.config/eww ~/.config/eww.backup

# 3. Copy dashboard files
mkdir -p ~/.config/eww/dashboard
cp -r eww-dashboard-custom/* ~/.config/eww/dashboard/

# 4. Install required fonts
cp -r fonts/* ~/.local/share/fonts/
fc-cache -fv

# 5. Make scripts executable
chmod +x ~/.config/eww/dashboard/scripts/*

# 6. Update personal information
# Edit eww.yuck and replace:
#   - IMAGE path (line 11)
#   - NAME (line 12)
#   - UNAME (line 13)
#   - Perplexity/Google SVG paths (lines with /home/ishaan/)
```

### Launch Dashboard
```bash
# Test launch
eww open-many background profile system clock uptime music github reddit perplexity youtube weather apps mail google logout sleep reboot poweroff folders

# Or use the provided launch script
~/.config/eww/dashboard/launch_dashboard
```

### Keybinding (Hyprland Example)
```conf
# ~/.config/hypr/hyprland.conf
bind = SUPER, D, exec, ~/.config/eww/dashboard/launch_dashboard
```

---

<div align="center">

## 🔧 **Configuration**

</div>

### Making it Universal (Remove Hardcoded Names)

#### In `eww.yuck`:
```lisp
# Replace line 11:
(defvar IMAGE "/usr/share/sddm/faces/$(whoami).face.icon")

# Replace line 12:
(defpoll NAME :interval "0" `getent passwd $(whoami) | cut -d: -f5 | cut -d, -f1`)

# Replace line 13:
(defpoll UNAME :interval "5m" `whoami`)

# Fix Perplexity SVG path (around line 200):
:path "~/.config/eww/dashboard/images/perplexity.svg"

# Fix Google SVG path (around line 220):
:path "~/.config/eww/dashboard/images/google.svg"
```

### Weather Setup
```bash
# Get free API key from: https://openweathermap.org/api

# Edit scripts/weather_info
nano ~/.config/eww/dashboard/scripts/weather_info

# Add your API key and location:
KEY="your_api_key_here"
CITY="YourCity"
UNITS="metric"  # or "imperial"
```

### Custom Apps
Edit the app icons in `eww.yuck` (search for `defwidget apps`):
```lisp
(button :style "background-image: url('images/icons/YOUR_APP.svg');" 
        :class "app_YOUR_APP" 
        :onclick "scripts/open_apps --YOUR_APP")
```

Add corresponding script action in `scripts/open_apps`:
```bash
--YOUR_APP)
    your-app-command &
    ;;
```

---

<div align="center">

## 🎯 **Resolution Adaptation**

</div>

### For Other Resolutions
All widget positions are in `eww.yuck` under `;; ** Windows` section.

**Scaling Formula**:
```
new_x = original_x × (your_width / 1366)
new_y = original_y × (your_height / 768)
new_width = original_width × (your_width / 1366)
new_height = original_height × (your_height / 768)
```

**Example for 1920×1080**:
```lisp
# Original (1366×768):
:geometry (geometry :x 107 :y 107 :width 249 :height 313)

# Scaled (1920×1080):
# x = 107 × (1920/1366) ≈ 150
# y = 107 × (1080/768) ≈ 150
# width = 249 × (1920/1366) ≈ 350
# height = 313 × (1080/768) ≈ 440
:geometry (geometry :x 150 :y 150 :width 350 :height 440)
```

---

<div align="center">

## 📸 **Screenshots**

</div>

> *Add your screenshots here once you've launched the dashboard!*

```
images/
├── preview_full.png       # Full dashboard view
├── preview_profile.png    # Profile widget closeup
├── preview_system.png     # System monitors
├── preview_music.png      # Music player
└── preview_apps.png       # App launcher
```

---

<div align="center">

## 🙏 **Credits**

</div>

### Original Author
- **[@adi1090x](https://github.com/adi1090x)** - Creator of the original widgets collection
- **Repository**: [adi1090x/widgets](https://github.com/adi1090x/widgets)
- **License**: GPL-3.0

### Customization
- **Modified By**: YOUR_NAME
- **Year**: 2025
- **Changes**: See [Detailed Customization Log](#-detailed-customization-log)

### EWW Framework
- **[@elkowar](https://github.com/elkowar)** - Creator of EWW (Elkowar's Wacky Widgets)
- **Repository**: [elkowar/eww](https://github.com/elkowar/eww)

---

<div align="center">

## 📜 **License**

</div>

This customized version is released under the **GPL-3.0 License**, maintaining compliance with the original project's license.

```
Copyright (C) 2025 YOUR_NAME
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

# Kill existing instance
eww kill

# Restart
eww daemon
./launch_dashboard
```
</details>

<details>
<summary><b>Weather not updating</b></summary>

- Verify API key in `scripts/weather_info`
- Check internet connection
- Test manually: `~/.config/eww/dashboard/scripts/weather_info --temp`
- Ensure city name is correct
</details>

<details>
<summary><b>Icons not rendering</b></summary>

```bash
# Reinstall fonts
cp -r fonts/* ~/.local/share/fonts/
fc-cache -fv

# Check font installation
fc-list | grep Iosevka
fc-list | grep Feather
```
</details>

<details>
<summary><b>Music widget shows "N/A"</b></summary>

- Ensure MPD is running: `systemctl --user start mpd`
- Check MPC connection: `mpc status`
- Configure MPD: `~/.config/mpd/mpd.conf`
</details>

<details>
<summary><b>Wrong screen resolution</b></summary>

See [Resolution Adaptation](#-resolution-adaptation) section to recalculate widget positions for your display.
</details>

---

<div align="center">

## 💡 **Tips & Tricks**

</div>

### Launch on Startup (Hyprland)
```conf
# ~/.config/hypr/hyprland.conf
exec-once = ~/.config/eww/dashboard/launch_dashboard
```

### Launch on Startup (i3/Openbox/etc.)
```bash
# Add to autostart file
eww daemon
sleep 2
~/.config/eww/dashboard/launch_dashboard &
```

### Toggle Dashboard (Instead of Always-On)
Edit `launch_dashboard` script to check if already open:
```bash
if eww windows | grep "*background"; then
    eww close-all
else
    eww open-many background profile system clock # ... all widgets
fi
```

### Custom Keybinds Per Widget
```bash
# Close only dashboard, keep EWW daemon running
eww close background profile system clock # ... list all

# Open single widget
eww open music

# Update specific widget
eww update TEMP="25°C"
```

---

<div align="center">

## 🗺️ **Roadmap**

</div>

- [ ] Add GPU monitoring widget
- [ ] Implement network speed monitor
- [ ] Create Spotify integration (alternative to MPD)
- [ ] Add calendar/agenda widget
- [ ] Support multiple monitor layouts
- [ ] Create automated resolution scaling script
- [ ] Package as AUR package

---

<div align="center">

## 🤝 **Contributing**

</div>

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add: Amazing new feature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<div align="center">

## ⭐ **Show Your Support**

</div>

If you found this customization helpful:
- ⭐ **Star** this repository
- 🔀 **Fork** and create your own variant
- 📢 **Share** with the r/unixporn community
- ☕ **Support** the original author [@adi1090x](https://github.com/adi1090x)

---

<div align="center">

## 📞 **Contact**

</div>

- **GitHub**: [@YOUR_USERNAME](https://github.com/YOUR_USERNAME)
- **Email**: your.email@example.com
- **Reddit**: u/YOUR_REDDIT_USERNAME
- **Discord**: YOUR_DISCORD_TAG

---

<div align="center">

<!-- Gradient Footer -->
<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=150&section=footer&text=Made%20with%20%E2%9D%A4%EF%B8%8F%20for%20the%20Linux%20Community&fontSize=20&fontColor=fff&animation=fadeIn" />

**[⬆ Back to Top](#)**

</div>
