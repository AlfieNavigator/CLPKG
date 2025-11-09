#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/AlfieNavigator/CLPKG.git"
WORKDIR="/tmp/clpkg-repo"

# Descargar repositorio
rm -rf "$WORKDIR"
git clone "$REPO_URL" "$WORKDIR"
cd "$WORKDIR" || exit

# Buscar paquetes .loblaw
mapfile -t pkgs < <(find . -type f -name "*.loblaw")

if [ "${#pkgs[@]}" -eq 0 ]; then
  zenity --error --text="No se encontraron paquetes .loblaw en el repositorio."
  exit 1
fi

# Crear lista para Zenity
pkg_list=""
for p in "${pkgs[@]}"; do
  pkg_list+="$p\n"
done

# Mostrar lista con Zenity
selected=$(echo -e "$pkg_list" | zenity --list \
  --title="CLPKG - Instalador Loblaw" \
  --column="Paquetes disponibles" \
  --height=400 --width=600)

# Si el usuario cancela
[ -z "$selected" ] && exit 0

# Confirmación
zenity --question --text="¿Desea instalar el paquete:\n$selected?" || exit 0

# Instalar usando clpkg
if command -v clpkg >/dev/null; then
  clpkg install "$selected" | tee /tmp/clpkg-install.log
  zenity --info --text="Instalación completada.\nRevise /tmp/clpkg-install.log para detalles."
else
  zenity --error --text="No se encontró el comando 'clpkg'. Instale CLPKG primero."
fi
