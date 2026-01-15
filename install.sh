#!/bin/bash

# BigC Global Installer (install.sh)
# Installs bigrun and env_lib globally.

set -e

REPO="esterzollar/bigc-lang"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}BigC: Global Mandate Installation starting...${NC}"

# 1. Create Directories
echo "Creating system directories..."
sudo mkdir -p /usr/local/share/bigc/env_lib
sudo mkdir -p /usr/local/lib/bigc

# 2. Download and Extract Release
echo "Downloading BigC V.1.0 Mandate..."
TEMP_DIR=$(mktemp -d)
TARBALL="bigc-v1.0-mandate.tar.gz"
DOWNLOAD_URL="https://github.com/esterzollar/bigc-lang/releases/download/v1.0-release/$TARBALL"

sudo curl -sSL "$DOWNLOAD_URL" -o "$TEMP_DIR/$TARBALL"

echo "Extracting..."
sudo tar -xzf "$TEMP_DIR/$TARBALL" -C "$TEMP_DIR"

# 3. Install Files
echo "Installing files..."
sudo cp "$TEMP_DIR/bigrun" /usr/local/lib/bigc/bigrun_engine
sudo chmod +x /usr/local/lib/bigc/bigrun_engine

# Install Libraries
# (The tarball contains env_lib folder directly)
if [ -d "$TEMP_DIR/env_lib" ]; then
    sudo cp -r "$TEMP_DIR/env_lib"/* /usr/local/share/bigc/env_lib/
fi

# Cleanup
rm -rf "$TEMP_DIR"


# 4. Create Global Wrapper
echo "Installing global wrapper..."

cat << 'EOF' > bigrun_wrapper
#!/bin/bash
# BigC Global Wrapper

# Ensure local env_lib exists
if [ ! -d "env_lib" ]; then
    mkdir -p env_lib
fi

# Symlink global libs to local env_lib if they dont exist
# This satisfies the engine's requirement for a local env_lib/ folder
for lib_path in /usr/local/share/bigc/env_lib/*.bigenv; do
    lib_name=$(basename "$lib_path")
    if [ ! -f "env_lib/$lib_name" ]; then
        ln -sf "$lib_path" "env_lib/$lib_name"
    fi
done

# Execute the actual engine
/usr/local/lib/bigc/bigrun_engine "$@"
EOF

chmod +x bigrun_wrapper
sudo mv bigrun_wrapper /usr/local/bin/bigrun

sudo chmod +x /usr/local/bin/bigrun

echo -e "${GREEN}BigC Installation Complete!${NC}"
echo -e "You can now use ${BLUE}bigrun${NC} from anywhere."
echo -e "Try it: ${BLUE}bigrun --version${NC}"
