# RedMagic 10 Pro GSI — In-Call Audio Fix

APatch / KernelSU / Magisk module for the **RedMagic 10 Pro (NX789J)**.

Restores microphone and earpiece audio during phone calls on phh-treble GSIs,
where both directions are silent because the QTI audio extension service is missing.
VoIP/app audio is unaffected — this is specifically for normal cellular calls.

## What it does

The GSI ships without the `IHalAdapterVendorExtension` AIDL service that the
Qualcomm audio path requires for call routing. This module supplies it at boot:
a small registrar binary loads `libaudiohalvendorextn.so`, registers the interface
with the service manager, then restarts `audioserver` so it picks up the extension.

It also ships the SELinux rule that lets `audioserver` actually reach the service.
Without it the service registers but stays invisible to `audioserver`, so the
extension is never used and calls remain silent — the registration succeeding is
not enough on its own.

## Requirements

| | |
|---|---|
| Device | RedMagic 10 Pro (NX789J) |
| Root | APatch · KernelSU · Magisk |
| Tested on | Android 16 GSI (phh-treble) |

Flash via APatch / KernelSU / Magisk and reboot.

**[Download latest release](https://github.com/sequencode/redmagic-10-pro-call-fix/releases/latest)**

## Related

Other RedMagic 10 Pro GSI fixes:

- [Bluetooth A2DP Fix](https://github.com/sequencode/redmagic-10-pro-bt-fix) — gets media routing to a wireless headset
- [UDFPS Fix](https://github.com/sequencode/redmagic-10-pro-udfps-fix) — gets the under-display fingerprint sensor working
