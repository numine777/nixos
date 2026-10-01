# Pi coding-agent config

Qwen-led configuration for the two-machine local-model rig:

- **uwuntu** — 5090 desktop running Qwen 3.8 27B, 262,144-token context; default primary engineer.
- **spark** — DGX Spark running Qwen 3.8 Flash Next 125B A5B, 262,144-token context; read-only oracle and auditor.

The live `/v1/models` listings were checked on 2026-10-01. Spark no longer listed
the previously configured DeepSeek V4 Flash; its model ID and advertised 262,144
context limit are now reflected here and in the advisor roles.

## Nix installation

`modules/programs/pi.nix` is enabled in both `hosts/nixM1/user.nix` and
`hosts/nixWork/user.nix`. It installs `pi-coding-agent` plus Node/npm, provisions
the model definitions and prompts, and merges shared settings at activation.
To add another Home Manager host, import the module and set
`modules.programs.pi.enable = true` (pass this flake's `inputs` in
`extraSpecialArgs`, as the existing hosts do).

Build and activate using this repository's existing output names:

```sh
cd ~/nixos
# Use nixWork on Linux. path: includes new files before their first git add.
nix build 'path:.#homemanagerConfigurations.nixM1.activationPackage'
HOME_MANAGER_BACKUP_EXT=before-pi ./result/activate
```

The backup suffix handles existing manually created Pi symlinks on first
activation. Do not reuse the suffix if a backup with that name already exists.
Subsequent updates use the usual `pls home-mac` or `pls home-work` commands.
Add the new `config/pi` files and module to Git before syncing this repo to
another computer or using the usual Git-based flake commands.

Confirm `command -v pi` resolves through `~/.nix-profile/bin` and `pi --version`
matches the Nix package. An older npm installation currently exists under
`~/.node_modules/bin` on the Mac; remove it only after the Nix installation works,
or ensure the Nix profile comes first in PATH.

## Updates

As checked on **2026-10-01**, the new `nixpkgs-pi` pin supplies **0.99.2**,
matching the npm registry's latest release. The main package pin and the Mac's
previous npm installation supply **0.84.2**. The separate input lets Pi advance
without changing every desktop/editor dependency.

Nix installs a pinned version; it does **not** update itself automatically.
Check/update this input periodically (for example weekly), review the version,
then rebuild and activate each host:

```sh
cd ~/nixos
nix flake update nixpkgs-pi
nix eval --raw '.#homemanagerConfigurations.nixM1.config.modules.programs.pi.package.version'
pls home-mac     # or: pls home-work
```

Nixpkgs includes an update script and a CLI version install check, but upstream
packaging can still lag. Its wrapper disables Pi's own version check by default.
Use the flake update above for the CLI, and `pi update --extensions` for the npm
extensions; do not use Pi's self-updater to modify a Nix store installation.
Extension declarations are intentionally unpinned, matching the existing setup;
their resolved versions are machine-local and are not locked by `flake.lock`.

Sources: [Nixpkgs package](https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/pi/pi-coding-agent/package.nix),
[upstream release](https://www.npmjs.com/package/@earendil-works/pi-coding-agent),
[Pi package management](https://github.com/earendil-works/pi/blob/v0.99.2/packages/coding-agent/docs/packages.md).

## Files and private state

Pi reads global config from `~/.pi/agent/`. These source-managed files are
symlinked there:

| Repo file | Symlink | Purpose |
|---|---|---|
| `models.json` | `~/.pi/agent/models.json` | Both OpenAI-compatible local endpoints |
| `SYSTEM.md` | `~/.pi/agent/SYSTEM.md` | Qwen-led primary workflow |
| `agents/` | `~/.pi/agent/agents` | Spark `oracle`/`auditor` plus the Qwen `executor` |

`settings.json` in this directory supplies the default provider/model, theme,
and extension list. Activation reapplies those scalar settings and adds missing
shared packages, preserving other settings, extra packages, and resource filters.
The live `~/.pi/agent/settings.json` remains a writable private file because Pi
mutates it. Use `modules.programs.pi.settings` to replace the shared settings on
a particular host. Model changes through Pi persist until the next activation.

Credentials, sessions, trust decisions, histories, installed npm packages, LSP
caches, and the Herdr-managed integration in `~/.pi/agent/extensions/` stay local.
The module deliberately manages individual resources, not the whole agent directory.
Install Herdr's integration separately on hosts where you use Herdr.

### Server credential on a new machine

The uwuntu API key is read at runtime from `~/.pi/agent/keys/uwuntu`. The existing
Mac credential has been moved there. Transfer that file privately to the same
location on another host, or enter the server's key without putting it in shell
history (Bash/Zsh):

```sh
mkdir -p ~/.pi/agent/keys
chmod 700 ~/.pi/agent/keys
read -r -s PI_SERVER_KEY
printf '\n'
(umask 077; printf '%s\n' "$PI_SERVER_KEY" > ~/.pi/agent/keys/uwuntu)
unset PI_SERVER_KEY
chmod 600 ~/.pi/agent/keys/uwuntu
```

Never put real keys in `models.json` or Nix options: they enter Git and the Nix
store. Spark currently accepts the dummy key already in its definition.
Both machines need a network route to the model servers. Override addresses per
host if their LAN/VPN routes differ:

```nix
modules.programs.pi.modelOverrides.providers.spark.baseUrl =
  "http://spark-lan:8000/v1";
```

## Workflow

Qwen owns repository inspection, edits, tests, and repair. It calls `oracle`
only for a narrow blocker or difficult decision. It calls `auditor` after a
concrete patch when the change is broad, subtle, incompletely tested, or still
uncertain. Both Spark roles are read-only and capped at eight minutes.
Advice can run while Qwen continues independent work.

The `executor` definition remains for a deliberately selected legacy
Spark-led session, but the global system prompt tells the normal Qwen parent
to implement directly.

## Extensions

Shared settings declare `pi-web-kit`, `pi-lsp-adapter`, and `pi-subagents`.
Pi installs missing packages on an online startup; `pi update --extensions`
reconciles/updates them explicitly. The first startup therefore needs npm network
access. Web search provider credentials and language servers needed by these
extensions remain host-specific.

## Verification

Checked on 2026-10-01:

- Built the Nix Pi 0.99.2 package on aarch64-darwin and checked `pi --version`.
- Evaluated the full nixM1 Home Manager activation derivation and the isolated
  Pi module's x86_64-linux activation derivation.
- Discovered both models and started RPC mode with the current extensions in
  an isolated agent directory: pi-web-kit 0.3.0, pi-lsp-adapter 0.1.3, and
  pi-subagents 0.74.0. No model-generation request was made.
- Checked settings initialization, preservation of local fields/package filters,
  idempotence, adding packages, and preservation of malformed existing JSON.

Known limitations:

- The full nixWork activation evaluation is currently blocked by the existing
  `pkgs.lounge-gtk-theme` reference in `modules/desktop/gtk.nix`; the pinned
  Nixpkgs has removed that theme. Resolve that desktop dependency before a full
  `pls home-work` activation. The Pi module itself evaluates on Linux; its Linux
  binary has not been built or run from this Mac.
- Pi 0.99.2 warns that pi-lsp-adapter 0.1.3 bundles host-provided `pi-tui` and
  `typebox` as dependencies. It loaded and registered its `lsp` command during
  the smoke test, but language-server operations were not tested.
- Neither host's Home Manager configuration was activated during this migration.

Check model discovery without making a model request:

```sh
PI_OFFLINE=1 pi --list-models qwen
PI_OFFLINE=1 pi --list-models Flash-Next
```

After relaunching a server, verify that served model IDs still match
`models.json`:

```sh
curl http://192.168.6.7:8000/v1/models
curl -H "Authorization: Bearer <key>" http://192.168.5.188:8001/v1/models
```

`contextWindow` tells Pi when to compact. Each serving process must also be
started with at least the corresponding context limit. Model output remains
capped at 32,768 tokens.

The advisor roles include `bash`; their read-only instructions are behavioral,
not a filesystem permission boundary. Use an appropriately isolated environment
when you need enforced separation.
