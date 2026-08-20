#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="${HOME}/.local/bin"

echo "=== Installing Windows-Segregation ==="

# Check Python
if ! command -v python3 >/dev/null 2>&1; then
    echo "Error: python3 is required." >&2
    exit 1
fi

# Install requirements
if [ -f "${SCRIPT_DIR}/requirements.txt" ]; then
    python3 -m pip install -r "${SCRIPT_DIR}/requirements.txt" 2>/dev/null || pip install -r "${SCRIPT_DIR}/requirements.txt" || echo "Note: Check Flask installation."
fi

mkdir -p "${BIN_DIR}"

cat <<'LAUNCHER' > "${BIN_DIR}/windows-segregation"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/Windows-Segregation"
if [ ! -f "${DIR_PATH}/cli.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/Windows-Segregation"
fi
if [ -f "${DIR_PATH}/cli.py" ]; then
    python3 "${DIR_PATH}/cli.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/cli.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/windows-segregation"

cat <<'LAUNCHER' > "${BIN_DIR}/windows-segregation-gui"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/Windows-Segregation"
if [ ! -f "${DIR_PATH}/gui.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/Windows-Segregation"
fi
if [ -f "${DIR_PATH}/gui.py" ]; then
    python3 "${DIR_PATH}/gui.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/gui.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/windows-segregation-gui"

cat <<'LAUNCHER' > "${BIN_DIR}/windows-segregation-web"
#!/usr/bin/env bash
REAL_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
DIR_PATH="$(dirname "$REAL_DIR")/Windows-Segregation"
if [ ! -f "${DIR_PATH}/web.py" ]; then
    DIR_PATH="${HOME}/Projects/Thunar-Action/Windows-Segregation"
fi
if [ -f "${DIR_PATH}/web.py" ]; then
    python3 "${DIR_PATH}/web.py" "$@"
else
    python3 "$(dirname "${BASH_SOURCE[0]}")/web.py" "$@"
fi
LAUNCHER
chmod +x "${BIN_DIR}/windows-segregation-web"

echo "Windows-Segregation installed successfully to ${BIN_DIR}!"
echo "Commands: windows-segregation, windows-segregation-gui, windows-segregation-web"
