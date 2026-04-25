# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-26

Première release publique du **Cursor Notify Kit** (3Devs).

### Added

- `install.ps1` and `uninstall.ps1` with automatic backup under `~/.cursor`.
- User-level Cursor hooks: sound on agent completion (`afterAgentResponse` and `stop`).
- Optional mobile push via [ntfy](https://ntfy.sh/) (`mobile-notify.json`).
- Custom sound support via `~/.cursor/hooks/cursor-notify.wav` (optional).
- Duplicate suppression (cooldown) to avoid double sound when both hooks fire.
- `README.md` with quick start and troubleshooting.

### Notes

- Windows native Cursor notifications remain driven by Cursor; this kit adds local sound and optional ntfy push.
- After install, a Cursor restart may be required for hooks to load reliably.
