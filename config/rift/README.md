# Rift trial

`config.toml` targets **Rift v0.5.10** and mirrors the AeroSpace bindings in
`hosts/nixM1/configuration.nix` wherever Rift provides a native equivalent.
The nixM1 Home Manager configuration symlinks this directory to `~/.config/rift`
on its next activation. Installing or starting Rift is a separate step.

## Package choice

Checked 2026-09-21:

| Source | Version |
| --- | --- |
| Latest upstream release | 0.5.10 (2026-09-19 UTC) |
| This flake's locked Nixpkgs (`e5bdc4a41d4c072fe1e3787eaa0320a384741d44`), `pkgs.rift-wm` | 0.4.3 |
| Nixpkgs master, `pkgs.rift-wm` | 0.5.5 |
| Upstream Homebrew tap, `acsandmann/tap/rift` | 0.5.10 |

Use Homebrew for this trial. Nixpkgs pins a release and source/dependency hashes;
it does not resolve the latest upstream release at installation time. Your flake
also pins Nixpkgs, even though its input URL names `master`. Updating the lock
alone would currently reach only 0.5.5. Staying on Nix with 0.5.10 would require
an updated package/overlay (including its hashes), or waiting for Nixpkgs to catch
up and then updating the lock. The Homebrew formula currently installs the
upstream universal release archive, including `rift` and `rift-cli`.

Sources:

- [Latest release](https://github.com/acsandmann/rift/releases/tag/v0.5.10)
- [Locked Nix package](https://github.com/NixOS/nixpkgs/blob/e5bdc4a41d4c072fe1e3787eaa0320a384741d44/pkgs/by-name/ri/rift-wm/package.nix)
- [Current Nix package](https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ri/rift-wm/package.nix)
- [Homebrew formula](https://github.com/acsandmann/homebrew-tap/blob/main/Formula/rift.rb)

## Try it

1. Apply the nixM1 Home Manager configuration to create the symlink. For a manual
   trial before activating Home Manager, if `~/.config/rift` does not already exist:

   ```sh
   mkdir -p ~/.config
   ln -s ~/nixos/config/rift ~/.config/rift
   ```

2. Install the latest stable release:

   ```sh
   brew install acsandmann/tap/rift
   ```

3. Before starting Rift, disable the AeroSpace service with
   `services.aerospace.enable = false` and apply the nix-darwin configuration.
   Confirm AeroSpace is no longer running; its launchd service can restart it if
   you merely quit the app while the service remains enabled. Enable **Displays
   have separate Spaces** in macOS System Settings → Desktop & Dock → Mission
   Control, following any macOS logout prompt.

4. Start a foreground trial using the config:

   ```sh
   rift --config ~/.config/rift/config.toml
   ```

   Grant Rift Accessibility access in System Settings → Privacy & Security →
   Accessibility if prompted, then restart it. This config manages spaces
   immediately (`default_disable = false`). Ctrl+C stops the foreground trial.

5. If keeping Rift, stop the foreground instance, then use its native service:

   ```sh
   rift service install
   rift service start
   ```

   Use one service manager; do not also start `brew services`. To return to
   AeroSpace, stop Rift with `rift service stop`, then re-enable AeroSpace and
   apply nix-darwin. The config symlink can stay in place.

## Binding differences

Ghostty, directional focus/movement, fullscreen, floating, workspace selection,
moving windows to workspaces, and reload retain their original shortcuts.
Workspaces are named 1–10, with Alt+0 selecting 10. Internally they use Rift's
zero-based indexes. Moving a window to a workspace does not follow it.

**Alt+Tab** cycles focus through connected, Rift-managed displays from left to
right, wrapping to the first. It keeps the destination monitor's current workspace
and moves the pointer there using Rift's display-focus command. Cycling starts
from the monitor containing the pointer, including when its workspace is empty
(Rift can report stale active-monitor context in that case). The helper
`focus-next-monitor.sh` reads the pointer through macOS CoreGraphics, queries
the current display state on each press, and uses `jq` from the Nix profile.
With fewer than two managed displays it does nothing.
Alt+Shift+Tab still moves the current workspace's windows to another display.

| AeroSpace behavior | Rift mapping / limitation |
| --- | --- |
| Alt+J/K/L/semicolon wraps focus within the workspace | Same directions, but no equivalent workspace-boundary wrap option; native focus can cross displays at an edge. |
| Alt+H / Alt+V creates a horizontal/vertical split | Left unbound: v0.5.10 has no explicit split command. Alt+/ rotates the current container. |
| Alt+/ selects tiles and cycles orientation | Toggles the current container's orientation; does not force tiles. |
| Alt+, selects accordion and cycles orientation | Toggles stacking; use Alt+/ to change orientation. This can also unstack. |
| Alt+- / Alt+= smart resize by 50 pixels | Smart shrink/grow using Rift's proportional step. |
| Alt+R, then H/J/K/L; Enter/Escape exits | No native keybinding modes. Hold Ctrl+Alt with H/J/K/L for narrower/taller/shorter/wider. Plain Enter/Escape remain available to apps. |
| Alt+Shift+Tab moves the workspace to the next monitor | Moves right with wrap-around; this approximates next for horizontally arranged displays. Rift transfers windows into the destination's same-index workspace, which may already contain windows. Workspaces are display-local, unlike AeroSpace's global names. |
| Warp pointer only when the focused monitor changes | No matching event setting. Pointer warping is disabled; focus-follows-mouse remains disabled. |

The traditional layout is the closest match to AeroSpace's tiling containers.
Its tree normalization and stacking behavior are Rift's own; AeroSpace's two
disabled normalization options have no direct configuration equivalents.

The translation was checked against the [tagged default config](https://github.com/acsandmann/rift/blob/v0.5.10/rift.default.toml)
and [release command definitions](https://github.com/acsandmann/rift/blob/v0.5.10/crates/rift-protocol/src/commands.rs).
See the [installation guide](https://acsandmann.github.io/rift-docs/installation/)
for upstream setup details. Runtime behavior still needs a live Rift trial.
