#!/bin/bash
echo 'CLPKG es un gestor de instalacion de programas de bajo nivel desarrollado en Chile'
git clone https://github.com/AlfieNavigator/CLPKG.git
cd 'CLPKG'
chafa th.webp
echo 'Seleccione un programa'
ls
echo "Por favor, ingrese el nombre del archivo que desea instalar:"
read archivo

# Verificar si el archivo existe
if [ -f "$archivo" ]; then
  # Ejecutar sudo gdebi con el archivo proporcionado
  sudo gdebi "$archivo"
else
  echo "El archivo '$archivo' no existe. Por favor, asegúrese de que el nombre del archivo es correcto."
fi
