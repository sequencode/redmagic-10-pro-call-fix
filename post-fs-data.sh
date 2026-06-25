#!/system/bin/sh
# Enable the AOSP gate property before audioserver starts so the framework
# will use IHalAdapterVendorExtension once it is registered.
MODDIR=${0%/*}

RESETPROP=$(command -v resetprop 2>/dev/null \
    || { [ -x /data/adb/ap/bin/resetprop ] && echo /data/adb/ap/bin/resetprop; } \
    || echo "")

if [ -n "$RESETPROP" ]; then
    "$RESETPROP" ro.audio.ihaladaptervendorextension_enabled true 2>/dev/null
else
    setprop ro.audio.ihaladaptervendorextension_enabled true 2>/dev/null
fi

chmod 0755 "$MODDIR/system/system_ext/bin/audiohalext_registrar" 2>/dev/null
