# Dépôt GitHub

**Projet :** https://github.com/Kalordo/cursor-notify-kit

## Premier push (déjà un dépôt vide sur GitHub)

Dans **PowerShell** depuis ce dossier :

```powershell
cd $HOME\Desktop\cursor-notify-kit

git init
git add -A
git commit -m "Initial release: Cursor Notify Kit v1.0.0"
git branch -M main
git remote add origin https://github.com/Kalordo/cursor-notify-kit.git
git push -u origin main
```

Si `origin` existe déjà :

```powershell
git remote set-url origin https://github.com/Kalordo/cursor-notify-kit.git
git push -u origin main
```

## Clone (pour d’autres machines)

```powershell
git clone https://github.com/Kalordo/cursor-notify-kit.git
cd cursor-notify-kit
```

## Alternative : GitHub CLI

Après le premier `git commit` :

```powershell
gh repo create Kalordo/cursor-notify-kit --public --source=. --remote=origin --push
```

(À utiliser seulement si le dépôt n’existe pas encore sur GitHub.)

## Release

Onglet **Releases** → **Create a new release** → tag `v1.0.0` → coller le corps depuis `RELEASE_NOTES.md`.
