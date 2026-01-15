# BigC Windows Setup (setup.ps1)
# Scaffolds a BigC project in the current directory.

Write-Host "BigC: Local Setup starting..." -ForegroundColor Cyan

# 1. Create env_lib
if (!(Test-Path "env_lib")) {
    New-Item -ItemType Directory -Force -Path "env_lib" | Out-Null
    Write-Host "Created local env_lib..."
}

# 2. Download Release
$repo = "esterzollar/bigc-lang"
$tarball = "bigc-v1.0-mandate-windows.tar" 
$url = "https://github.com/$repo/releases/download/v1.0-release/$tarball"

Write-Host "Downloading BigC V.1.0 Mandate (Windows)..."
Invoke-WebRequest -Uri $url -OutFile $tarball

# 3. Extract (Windows 10+ supports tar natively)
Write-Host "Extracting..."
tar -xf $tarball

# Cleanup
Remove-Item $tarball

# 4. Create Template app.big
if (!(Test-Path "app.big")) {
    Write-Host "Creating app.big template..."
    $content = @"
# BigC Quick Start Template
attach statement

MsgRaw = "Hello BigC! Your Windows environment is ready."
run LogSuccess()

print "Try running: ./bigrun app.big"
"@
    Set-Content -Path "app.big" -Value $content
}

Write-Host "BigC Local Setup Complete!" -ForegroundColor Green
Write-Host "Use ./bigrun.exe to execute your scripts."
Write-Host "Example: ./bigrun.exe app.big"
