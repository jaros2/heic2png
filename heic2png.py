#!/usr/bin/env python3
import sys
import os
from PIL import Image
from pillow_heif import register_heif_opener

# Register the HEIF opener with PIL so it can read HEIC/HEIF files
register_heif_opener()

def heic_to_png(heic_path):
    if not os.path.exists(heic_path):
        print(f"Error: File not found: {heic_path}")
        return False
    
    filename, ext = os.path.splitext(heic_path)
    if ext.lower() not in ['.heic', '.heif']:
        print(f"Error: File '{heic_path}' is not a HEIC/HEIF file.")
        return False
        
    png_path = f"{filename}.png"
    
    try:
        print(f"Converting '{heic_path}'...")
        image = Image.open(heic_path)
        image.save(png_path, format="PNG")
        print(f"✅ Successfully created: {png_path}")
        return True
    except Exception as e:
        print(f"❌ Error during conversion of {heic_path}: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: heic2png <path_to_heic_file> [additional_files...]")
        sys.exit(1)
        
    success_all = True
    for file_path in sys.argv[1:]:
        if not heic_to_png(file_path):
            success_all = False
            
    if not success_all:
        sys.exit(1)
