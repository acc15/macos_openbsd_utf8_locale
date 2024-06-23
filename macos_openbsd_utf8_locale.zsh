#!/usr/bin/env zsh

URL=https://raw.githubusercontent.com/openbsd/src/master/share/locale/ctype/en_US.UTF-8.src
PATH_LOCALE=${PATH_LOCALE:-/usr/local/share/locale}
LOCALE_NAME=${LOCALE_NAME:-UTF-8}
LOCALE_DIR="${PATH_LOCALE}/${LOCALE_NAME}"

TMP=$(mktemp)

# script will fail if any command fail
set -euxo pipefail

{ echo "Building locale from $URL" } 2>/dev/null
curl -s $URL | sed 's/ENCODING        "UTF8"/ENCODING        "UTF-8"/' | mklocale > $TMP

{ echo "Installing locale to $LOCALE_DIR" } 2>/dev/null
sudo mkdir -p $LOCALE_DIR && mv $TMP $LOCALE_DIR/LC_CTYPE

{ echo "OpenBSD UTF-8 locale has been succesfully installed
Add following environment variables to ~/.zshrc: 

	export PATH_LOCALE=${PATH_LOCALE}
	export LC_CTYPE=${LOCALE_NAME}" } 2>/dev/null
