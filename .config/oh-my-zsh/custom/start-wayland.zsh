if [ "$DESKTOP_ENVIRONMENT" = "wayland" ] && [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  export _JAVA_AWT_WM_NONREPARENTING=1
  export KITTY_ENABLE_WAYLAND=1
  export GDK_BACKEND=wayland
  # export QT_QPA_PLATFORM=wayland-egl
  export QT_QPA_PLATFORMTHEME='qt5ct'
  sway
fi
