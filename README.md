# heic2png

A simple, lightweight Python command-line utility for converting HEIC/HEIF image files to PNG format. The converted images are conveniently saved directly alongside the original files.

## Prerequisites

- Python 3
- Bash-compatible shell

## Installation

An installation script is provided to easily set up `heic2png` in an isolated environment and make it globally available on your system. 

```bash
# Clone the repository
git clone https://github.com/jaros2/heic2png.git
cd heic2png

# Run the installation script
bash install.sh
```

**What the install script does:**
1. Secures an isolated Python virtual environment inside `~/.local/share/heic2png-venv`.
2. Installs the necessary image processing libraries (`pillow` and `pillow-heif`) without interfering with your system Python packages.
3. Automatically maps a convenient runner command (`heic2png`) globally into your `~/.local/bin` directory.

> **Note:** Make sure `~/.local/bin` is in your environment's `PATH`. If the command isn't recognized after installation, add `export PATH="$HOME/.local/bin:$PATH"` to your `~/.bashrc` or `~/.zshrc`.

## Usage

You can convert a single file:
```bash
heic2png my_photo.heic
```

Or you can effortlessly batch-convert multiple files at once using wildcards:
```bash
heic2png photo1.HEIC photo2.heic
heic2png *.heic
```

If successful, the new `.png` file appears right next to the corresponding original file!

## Dependencies

- [Pillow](https://python-pillow.org/)
- [pillow-heif](https://pypi.org/project/pillow-heif/)
