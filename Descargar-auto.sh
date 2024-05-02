#!/bin/bash

# Función para comprobar e instalar herramientas
install_tools() {
  if ! command -v yt-dlp &>/dev/null; then
    echo "yt-dlp no está instalado. Instalando..."
    sudo apt-get install yt-dlp
  fi

  if ! command -v ffmpeg &>/dev/null; then
    echo "ffmpeg no está instalado. Instalando..."
    sudo apt-get install ffmpeg
  fi
}

# Llama a la función de instalación
install_tools

# Pide la URL al usuario
echo "Introduce la URL de YouTube:"
read url

# Lista formatos disponibles
yt-dlp -F $url

echo "Elige el formato del video (número):"
read format

# Descarga el video en el formato seleccionado
yt-dlp -f $format $url -o video.%\(ext\)s

# Extrae el audio a mp3
ffmpeg -i video.* audio.mp3

# Crea un video sin audio
ffmpeg -i video.* -an video_compressed.mp4

# Muestra información
echo "Información de los archivos generados:"
echo "Audio: $(du -h audio.mp3) | Duración: $(ffmpeg -i audio.mp3 2>&1 | grep Duration)"
echo "Video: $(du -h video_compressed.mp4)"
