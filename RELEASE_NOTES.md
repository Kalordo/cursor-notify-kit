# Release v1.0.0

Première version publique du **Cursor Notify Kit**, publié par **3Devs**.

**Dépôt :** https://github.com/Kalordo/cursor-notify-kit

## Contenu

- Installation et désinstallation automatisées (`install.ps1`, `uninstall.ps1`) avec sauvegarde des fichiers existants.
- Hooks Cursor utilisateur : son à la fin d’une réponse de l’agent (`afterAgentResponse` + `stop`, avec anti-doublon).
- Push mobile optionnel via **ntfy** (`mobile-notify.json`).
- Son personnalisé optionnel : `cursor-notify.wav` dans le dossier hooks.

## Licence

MIT — voir `LICENSE`.

## Notes de publication GitHub

Titre de release suggéré : `v1.0.0 — Cursor Notify Kit`

Corps (copier-coller) :

```markdown
## Cursor Notify Kit v1.0.0

Kit léger pour Windows : son local + push mobile (ntfy) à la fin d’une réponse Cursor, sans lancer quoi que ce soit à la main.

**Éditeur :** 3Devs

### Installation

Voir le [README](README.md) : `.\install.ps1`

### Licence

MIT — copyright 3Devs (voir `LICENSE`).
```
