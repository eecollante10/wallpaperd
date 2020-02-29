#!/bin/sh
cd `dirname $0`
cd dist
echo '#!/bin/sh' > wallpaperd
echo "$(pwd)/cambiarFondo > /dev/null 2>&1" >> wallpaperd
chmod a+x wallpaperd

echo Nombre de Ícono debe ser Icon.png
echo Se permiten tamaños de 16 × 16, 32 × 32, 48 × 48, 128 × 128, 256 × 256, 512 × 512, y 1024 × 1024 pixels

cd ..
cat titulo.txt >> dist/wallpaperd
echo "sleep 2" >> dist/wallpaperd
echo "osascript -e 'tell application \"Terminal\" to quit'" >> dist/wallpaperd

# Covert Icon.png to tmpicons.icns:
sips -s format icns Icon.png --out tmpicns.icns > /dev/null

# Create temporary resource file which points to tmpicons.icns:
echo "read 'icns' (-16455) \"tmpicns.icns\";" >> tmpicns.rsrc

# append this resource to the file you want to icon-ize.
Rez -a tmpicns.rsrc -o dist/wallpaperd

# Use the resource to set the icon.
SetFile -a C dist/wallpaperd

# Clean up
rm tmpicns.icns && rm tmpicns.rsrc

cp dist/wallpaperd ~/Desktop/

echo Finalizado
