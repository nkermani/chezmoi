# ~/.bashrc.d/00-pah.sh
# PATH
export NK_DIR="$HOME/.nkermani"
export NK_APPS="$NK_DIR/apps"
export NK_BIN="$NK_DIR/bin"
export PATH="$NK_BIN:$HOME/.local/bin:$HOME/.opencode/bin:$HOME/.cargo/bin:$PATH"

export PATH="/home/nkermani/.bun/bin:$PATH"

export SHELL="$(command -v fish 2>/dev/null || command -v bash 2>/dev/null || echo /bin/bash)"

if [ "$(uname -s)" = "Darwin" ]; then
	export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin"
else
	# TEMP for 42 (Ghidra)
	export PATH="$HOME/.OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7 OpenJDK21U-jdk_x64_linux_hotspot_21.0.10_7/jdk-21.0.10+7/bin:$PATH"
fi

export PATH
