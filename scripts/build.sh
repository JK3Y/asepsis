#!/bin/sh

if [ ${#PROJECT_DIR} -le 10 ]; then echo "error: set \$PROJECT_DIR env variable" ; exit 1; fi
  
BIN="$PROJECT_DIR/bin"
mkdir -p "$BIN"
BIN=`cd "$BIN";pwd` # normalize path

TARGET="$BIN/Asepsis"
DAEMON="$TARGET/asepsisd"
WRAPPER="$TARGET/DesktopServicesPrivWrapper"
RES="$PROJECT_DIR/res"

echo "build products dir is $BUILT_PRODUCTS_DIR"
echo "assembling final products into $BIN"

mkdir -p "$TARGET"

cp "$RES"/* "$TARGET"
cp -Rf "$BUILT_PRODUCTS_DIR/asepsisd" "$DAEMON"
cp -Rf "$BUILT_PRODUCTS_DIR/DesktopServicesPrivWrapper.framework/Versions/A/DesktopServicesPrivWrapper" "$WRAPPER"

install_name_tool -change "/System/Library/PrivateFrameworks/DesktopServicesPriv.framework/Versions/A/DesktopServicesPriv" "/System/Library/PrivateFrameworks/DesktopServicesPriv.framework/Versions/A_/DesktopServicesPriv" "$WRAPPER"

cp -Rf "$PROJECT_DIR/ctl" "$TARGET"