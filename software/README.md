# **Integration with GNOME Keyboard Shortcuts**

This guide explains how to integrate the `fx_macro_redirect.sh` script with GNOME desktop keyboard shortcuts, configure macros, and verify their functionality. 

This will help preparing your Linux/GNOME environment to leverage the use of the Macro Pad.

---

## **Step 1: Configuring GNOME Keyboard Shortcuts**
1. Open GNOME Control Center:
   ```bash
   gnome-control-center keyboard
   ```
2. Navigate to **View and Customize Shortcuts > Custom Shortcuts**.
3. Add a new shortcut for each macro key by specifying:
   - **Name**: Descriptive name for the macro (e.g., `FX_F13`).
   - **Command**: The script call with the corresponding `--key` argument (e.g., `fx_macro_redirect.sh --key=FX_F13`).
   - **Shortcut**: The key combination or macro key to trigger the script.

### Example Shortcut Configuration
You can use the provided script, `list_gnome_custom_macros.sh`, to list the configured shortcuts. Here's an example output that shows a typical setup:

```bash
./list_gnome_custom_macros.sh

- Name: FX_F13
  Command: fx_macro_redirect.sh --key=FX_F13
  Binding: <Alt>Tools

- Name: FX_F14
  Command: fx_macro_redirect.sh --key=FX_F14
  Binding: Launch5

- Name: FX_F15
  Command: fx_macro_redirect.sh --key=FX_F15
  Binding: Launch6

- Name: FX_F16
  Command: fx_macro_redirect.sh --key=FX_F16
  Binding: Launch7

- Name: FX_F17
  Command: fx_macro_redirect.sh --key=FX_F17
  Binding: Launch8

- Name: FX_F18
  Command: fx_macro_redirect.sh --key=FX_F18
  Binding: Launch9
```

---

## **Step 2: Handling Default Key Behaviors**
- On a typical Ubuntu system:
  - **Key1 on your macro keyboard (FX_F13)** maps to `<Alt>Tools` by default.
  - This behavior opens the GNOME Control Panel's **Tools** utilities.

### Optional Customization
If you prefer to keep the default `<Alt>Tools` behavior for `FX_F13`:
- Omit the macro configuration for `FX_F13` in GNOME shortcuts.
- Pressing Key1 on your macro keyboard will invoke the default action while maintaining the ability to use other macro keys for custom shortcuts.

---

## **Step 3: Adding Scripts to Your Path**
Ensure the `fx_macro_redirect.sh` script (and any related scripts) are accessible from your PATH. A good practice is to place them in `~/.local/bin`. Use symbolic links for convenience:

```bash
cd scripts
ln -s "$(pwd)/fx_macro_redirect.sh" ~/.local/bin/fx_macro_redirect.sh
ln -s "$(pwd)/toggle_audio_devices.sh" ~/.local/bin/toggle_audio_devices.sh
```

After setting this up, verify the scripts are accessible:
```bash
which fx_macro_redirect.sh
which toggle_audio_devices.sh
```

---

## **Step 4: Logging and Testing**
The script logs keypresses to `~/.fx_macro_redirect.log` whenever it is invoked. Use this log to verify that your shortcuts are triggering the script correctly.

### Testing Logging:
1. Trigger the macro shortcut.
2. Monitor the log file:
   ```bash
   tail -f ~/.fx_macro_redirect.log
   ```

Expected log entries will include the key pressed and any associated actions (e.g., toggling audio devices).

---

## **Tips and Notes**
- **Key Behaviors**: Ensure your macro keyboard sends the correct key signals. Tools like `xev` or `evtest` can help diagnose key mappings.
- **Script Debugging**: If a macro doesn’t behave as expected, check the logs for errors or misconfigurations.

---

This documentation ensures a clear understanding of the integration process, while providing troubleshooting steps and emphasizing good practices. Let me know if you need further refinements!
