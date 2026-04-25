# Cursor Notify Kit

Dépôt : **https://github.com/Kalordo/cursor-notify-kit**

Kit partageable pour recevoir automatiquement :

- notification native Cursor sur Windows
- son local a la fin de reponse
- push mobile via ntfy (optionnel)

Le kit n'a rien a lancer manuellement a chaque session.

## Installation rapide

Ouvrir PowerShell dans ce dossier et executer :

```powershell
.\install.ps1
```

Le script :

- sauvegarde l'existant dans `~/.cursor/hooks-backup-YYYYMMDD-HHMMSS`
- installe `~/.cursor/hooks.json`
- installe `~/.cursor/hooks/cursor-sound.ps1`
- active ntfy avec un topic aleatoire

## Installation avec topic ntfy fixe

```powershell
.\install.ps1 -Topic "mon-topic-prive"
```

Abonne ensuite l'app mobile **ntfy** au meme topic.

## Installation sans push mobile

```powershell
.\install.ps1 -DisableMobile
```

## Son personnalise

Si tu veux un son custom, place un fichier :

`~/.cursor/hooks/cursor-notify.wav`

Il sera prioritaire sur les sons Windows par defaut.

## Desinstallation

```powershell
.\uninstall.ps1
```

Le script supprime uniquement les fichiers installes par ce kit et cree un backup.

## Fichiers installes

- `~/.cursor/hooks.json`
- `~/.cursor/hooks/cursor-sound.ps1`
- `~/.cursor/hooks/mobile-notify.json` (si mobile active)

## Diagnostic

Logs utiles :

- `~/.cursor/hooks/cursor-sound.log`

Si rien ne se declenche apres installation, redemarrer Cursor une fois.

## Publier / cloner

- **Clone :** `git clone https://github.com/Kalordo/cursor-notify-kit.git`
- **Release GitHub :** tag `v1.0.0`, texte dans `RELEASE_NOTES.md`.

## Licence et versions

- Produit : **Cursor Notify Kit**.
- Structure / entreprise : **3Devs** (titulaire de la licence — voir `LICENSE`).
- Licence : **MIT** — voir `LICENSE`.
- Historique des versions : `CHANGELOG.md`.
- Texte prêt pour une release GitHub : `RELEASE_NOTES.md`.
