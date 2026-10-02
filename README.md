# one-person-business-finder

## Publish to GitHub

Install Git, sign in to GitHub from Git, and make sure this folder is a Git repository with an `origin` remote. The GitHub repository must be public for jsDelivr to serve its files.

From PowerShell, run:

```powershell
.\publish.ps1 "Describe your update"
```

The script stages all non-ignored changes, creates a commit when there are staged changes, pushes the current branch to `origin`, requests a jsDelivr cache refresh, and prints the CDN URL for `script.js`. Use that URL in your website to load the latest version from the pushed branch.

If this project has not been connected to GitHub yet, create a repository on GitHub and add it as `origin` before running the script:

```powershell
git init
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git branch -M main
```