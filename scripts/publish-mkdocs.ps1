<#
.SYNOPSIS
    Sync README/INSTRUKCJA to docs/ and run MkDocs (local build or GitHub Pages).

.DESCRIPTION
    1) Copy README.md -> docs/index.md
    2) Copy INSTRUKCJA.md -> docs/instrukcja.md (if present)
    3) mkdocs build / serve / gh-deploy

.PARAMETER Serve
    Preview at http://127.0.0.1:8000

.PARAMETER Deploy
    Push to gh-pages (needs git remote + permissions).

.PARAMETER SkipSync
    Skip file copy; only build (if you edit docs/ by hand).

.PARAMETER NoVenv
    Use global python -m mkdocs instead of .venv in portfolio folder.
#>
[CmdletBinding()]
param(
    [switch] $Serve,
    [switch] $Deploy,
    [switch] $SkipSync,
    [switch] $NoVenv
)

$ErrorActionPreference = "Stop"

$PortfolioRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location $PortfolioRoot

$DocsDir = Join-Path $PortfolioRoot "docs"
if (-not (Test-Path $DocsDir)) {
    New-Item -ItemType Directory -Path $DocsDir | Out-Null
}

if (-not $SkipSync) {
    $readme = Join-Path $PortfolioRoot "README.md"
    if (-not (Test-Path $readme)) {
        Write-Error "Missing README.md in $PortfolioRoot"
    }
    Copy-Item -Path $readme -Destination (Join-Path $DocsDir "index.md") -Force
    Write-Host "Copied README.md -> docs/index.md"

    # Optional: if you want a second page, create docs/instrukcja.md manually and add it to mkdocs.yml nav.
}

$venvPython = Join-Path $PortfolioRoot ".venv\Scripts\python.exe"
$python = "python"
if (-not $NoVenv) {
    if (Test-Path $venvPython) {
        $python = $venvPython
        Write-Host "Using venv: $python"
    }
}

$req = Join-Path $PortfolioRoot "requirements-mkdocs.txt"
if ($NoVenv -or -not (Test-Path $venvPython)) {
    if (-not $NoVenv -and -not (Test-Path $venvPython)) {
        Write-Host "Creating .venv and installing MkDocs..."
        python -m venv (Join-Path $PortfolioRoot ".venv")
        $python = Join-Path $PortfolioRoot ".venv\Scripts\python.exe"
        & $python -m pip install --upgrade pip
        & $python -m pip install -r $req
    } else {
        & $python -m pip install -q -r $req 2>$null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Installing deps: pip install -r requirements-mkdocs.txt"
            & $python -m pip install -r $req
        }
    }
} else {
    & $python -m pip install -q -r $req 2>$null
    if ($LASTEXITCODE -ne 0) {
        & $python -m pip install -r $req
    }
}

if ($Deploy) {
    Write-Host "mkdocs gh-deploy -> branch gh-pages"
    & $python -m mkdocs gh-deploy --strict --clean
} elseif ($Serve) {
    Write-Host "Preview: http://127.0.0.1:8000 (Ctrl+C to stop)"
    & $python -m mkdocs serve
} else {
    Write-Host "mkdocs build -> site/"
    & $python -m mkdocs build --strict
    Write-Host "Done. Open site/index.html or run with -Serve."
}
