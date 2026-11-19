# Orca 51.1: Wayland preferences window deadlock

Environment:
- Arch Linux
- Orca 51.1
- GTK3 3.24.52
- niri 26.04
- Python 3.14

Problem:
Opening Orca preferences on native Wayland hangs the main thread.
Speech stops, and the preferences window does not appear.

GDB shows the main thread blocked inside:
gtk_window_present_with_time -> GDK -> wl_display_dispatch_queue.

Workaround:
Defer present_with_time() through GLib.idle_add().

Verification:
- Repeatedly opening preferences: successful
- Reading preferences with Orca: successful
- Changing and saving preferences: successful
- No new issues observed

Apply manually after checking compatibility with the installed Orca version.
Never apply automatically during package upgrades.

Upstream bug report: not yet submitted.
