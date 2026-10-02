param(
  [Parameter(Position = 0)]
  [string]$Message = "Update project"
)

Set-Location -LiteralPath $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "Git is not installed or is not available on PATH. Install Git, then reopen PowerShell."
}

git rev-parse --is-inside-work-tree *> $null
if ($LASTEXITCODE -ne 0) {
  throw "This folder is not a Git repository. Run git init and connect a GitHub origin first."
}

$branch = (git branch --show-current).Trim()
if ($LASTEXITCODE -ne 0 -or -not $branch) {
  throw "Could not determine the current branch. Check out a branch before publishing."
}

$remoteOutput = git remote get-url origin
if ($LASTEXITCODE -ne 0 -or -not $remoteOutput) {
  throw "No Git remote named origin is configured. Add your GitHub repository as origin first."
}
$remote = $remoteOutput.Trim()

$githubRepo = [regex]::Match($remote, "github\.com[:/](?<owner>[^/]+)/(?<repo>[^/#?]+?)(?:\.git)?$")
if (-not $githubRepo.Success) {
  throw "The origin remote is not a GitHub URL: $remote"
}

git add --all
if ($LASTEXITCODE -ne 0) {
  throw "Could not stage changes."
}

git diff --cached --quiet
$stagedChanges = $LASTEXITCODE -eq 1
if ($LASTEXITCODE -gt 1) {
  throw "Could not check staged changes."
}

if ($stagedChanges) {
  git commit -m $Message
  if ($LASTEXITCODE -ne 0) {
    throw "Commit failed. Resolve the reported issue, then run this script again."
  }
} else {
  Write-Host "No new changes to commit."
}

git push --set-upstream origin $branch
if ($LASTEXITCODE -ne 0) {
  throw "Push failed. Check your GitHub sign-in and repository permissions."
}

$owner = $githubRepo.Groups["owner"].Value
$repository = $githubRepo.Groups["repo"].Value -replace "\.git$", ""
$cdnUrl = "https://cdn.jsdelivr.net/gh/$owner/$repository@$branch/script.js"
$purgeUrl = $cdnUrl -replace "^https://cdn\.jsdelivr\.net", "https://purge.jsdelivr.net"
try {
  Invoke-RestMethod -Uri $purgeUrl -Method Get | Out-Null
  Write-Host "Requested jsDelivr cache refresh."
} catch {
  Write-Warning "GitHub push succeeded, but jsDelivr cache refresh failed. Retry: $purgeUrl"
}

Write-Host "Published branch '$branch'."
Write-Host "jsDelivr URL: $cdnUrl"
Write-Host "Script tag: <script src=`"$cdnUrl`"></script>"