#!/system/bin/sh
# Register IHalAdapterVendorExtension, then restart audioserver so it binds the extension.
MODDIR=${0%/*}
LOG=/data/local/tmp/callaudio_fix.log
: > "$LOG" 2>/dev/null

RESETPROP=$(command -v resetprop 2>/dev/null || echo /data/adb/ap/bin/resetprop)
REG="$MODDIR/system/system_ext/bin/audiohalext_registrar"
LIB=/system_ext/lib64/libaudiohalvendorextn.so

# Wait for full boot before touching audioserver.
i=0
until [ "$(getprop sys.boot_completed)" = 1 ] || [ $i -ge 60 ]; do
    sleep 2; i=$((i + 1))
done

"$RESETPROP" -n ro.audio.ihaladaptervendorextension_enabled true 2>/dev/null
echo "prop=$(getprop ro.audio.ihaladaptervendorextension_enabled)" >> "$LOG"

chmod 0755 "$REG" 2>/dev/null
pkill -f audiohalext_registrar 2>/dev/null
LD_LIBRARY_PATH=/system_ext/lib64:/system/lib64:/vendor/lib64 "$REG" "$LIB" >> "$LOG" 2>&1 &
sleep 2

if service list 2>/dev/null | grep -q IHalAdapterVendorExtension; then
    echo "service registered OK" >> "$LOG"
    setprop ctl.restart audioserver
    echo "audioserver restarted" >> "$LOG"
else
    echo "ERROR: extension service not registered" >> "$LOG"
fi
