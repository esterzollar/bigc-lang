#!/bin/bash

# BigC Local Setup (setup.sh)
# Scaffolds a BigC project in the current directory.

set -e

REPO="esterzollar/bigc-lang"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/$REPO/$BRANCH"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}BigC: Local Setup starting...${NC}"

# 1. Create env_lib
echo "Creating local env_lib..."
mkdir -p env_lib

# 2. Download Binary
echo "Downloading bigrun engine..."
curl -sSL "$BASE_URL/bigrun" -o bigrun
chmod +x bigrun

# 3. Download Standard Libraries (env_lib)
echo "Downloading standard libraries..."
LIBS=("file" "fixer" "gethor" "len" "math" "picker" "shim" "statement" "test")
for lib in "${LIBS[@]}"; do
    curl -sSL "$BASE_URL/env_lib/$lib.bigenv" -o "env_lib/$lib.bigenv"
done

# 4. Create Template app.big
if [ ! -f "app.big" ]; then
    echo "Creating app.big template..."
    cat << EOF > app.big
# BigC Quick Start Template
attach statement

MsgRaw = "Hello BigC! Your environment is ready."
run LogSuccess()

print "Try running: ./bigrun app.big"
EOF
fi

echo -e "${GREEN}BigC Local Setup Complete!${NC}"
echo -e "Use ${BLUE}./bigrun${NC} to execute your scripts."
echo -e "Example: ${BLUE}./bigrun app.big${NC}"
