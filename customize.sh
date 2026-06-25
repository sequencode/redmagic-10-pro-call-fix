#!/system/bin/sh
# Install script for rm10_callaudio_fix (APatch / KernelSU).
# Runs in MODPATH during installation.

ui_print "*********************************************"
ui_print "  RedMagic 10 Pro GSI In-Call Audio Fix"
ui_print "*********************************************"

ui_print "- Setting permissions on audiohalext_registrar ..."
set_perm_recursive "$MODPATH/system" root root 0755 0644
set_perm "$MODPATH/system/system_ext/bin/audiohalext_registrar" root root 0755

ui_print "- Done. Please reboot — the extension service registers on next boot."
ui_print "*********************************************"
