# BigC Global Installer (Windows)
# Installs bigrun globally and adds it to your PATH.

$ErrorActionPreference = "Stop"

Write-Host "BigC: Global Installation starting..." -ForegroundColor Cyan

# 1. Define Install Directory (~/.bigc)
$installDir = "$HOME\.bigc"
if (!(Test-Path $installDir)) {
    New-Item -ItemType Directory -Force -Path $installDir | Out-Null
}
Set-Location $installDir

# 2. Download Release
$repo = "esterzollar/bigc-lang"
$tarball = "bigc-v1.0-mandate-windows.tar" 
$url = "https://github.com/$repo/releases/download/v1.0-release/$tarball"

Write-Host "Downloading BigC V.1.0 Mandate..."
Invoke-WebRequest -Uri $url -OutFile $tarball

# 3. Extract
Write-Host "Extracting..."
tar -xf $tarball

# 4. Cleanup & Arrange
if (Test-Path "Windows_exe\bigrun.exe") {
    Move-Item -Path "Windows_exe\bigrun.exe" -Destination ".\bigrun.exe" -Force
    Remove-Item -Path "Windows_exe" -Recurse -Force
}
Remove-Item $tarball

# 5. Add to User PATH
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$installDir*") {
    Write-Host "Adding BigC to your User PATH..."
    $newPath = "$userPath;$installDir"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    $env:Path += ";$installDir" # Update current session too
    Write-Host "Success! Added to PATH." -ForegroundColor Green
} else {
    Write-Host "BigC is already in your PATH." -ForegroundColor Yellow
}

Write-Host "`nBigC Global Install Complete!" -ForegroundColor Green
Write-Host "Location: $installDir"
Write-Host "You can now open a NEW terminal and type: bigrun app.big"
