#!/bin/bash

# Exit on any error
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"
SCRIPT_NAME="heic2png"
VENV_DIR="$HOME/.local/share/heic2png-venv"

echo "Setting up heic2png converter..."

# 1. Create a Python virtual environment to avoid conflicting with system packages
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment at $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
else
    echo "Using existing virtual environment at $VENV_DIR."
fi

# 2. Install required pip packages (Pillow and pillow-heif)
echo "Installing dependencies (Pillow, pillow-heif)..."
"$VENV_DIR/bin/pip" install pillow pillow-heif --quiet

# 3. Ensure the target commands directory exists
mkdir -p "$TARGET_DIR"

# 4. Create an executable bash wrapper in the local bin directory
echo "Creating executable wrapper at $TARGET_DIR/$SCRIPT_NAME..."
cat << EOF > "$TARGET_DIR/$SCRIPT_NAME"
#!/bin/bash
VENV_DIR="$VENV_DIR"
SCRIPT_PATH="$DIR/heic2png.py"

if [ -z "\$1" ]; then
    echo "Usage: heic2png <path_to_heic_file> [additional_files...]"
    exit 1
fi

"\$VENV_DIR/bin/python" "\$SCRIPT_PATH" "\$@"
EOF

# Make the wrapper and the Python script executable
chmod +x "$TARGET_DIR/$SCRIPT_NAME"
chmod +x "$DIR/heic2png.py"

echo ""
echo "================================================================="
echo "✅ Installation complete!"
echo "The command '$SCRIPT_NAME' has been installed to $TARGET_DIR."
echo ""
echo "If you cannot run '$SCRIPT_NAME' from your terminal immediately,"
echo "you may need to add $TARGET_DIR to your shell's PATH."
echo "You can do this by adding the following line to your ~/.bashrc or ~/.zshrc file:"
echo ""
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "Once added, reload your terminal (e.g., source ~/.bashrc) and try:"
echo "  heic2png my_photo.heic"
echo "================================================================="
