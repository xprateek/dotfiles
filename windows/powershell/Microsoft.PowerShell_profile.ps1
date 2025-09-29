# =========================
# Ultimate PowerShell Profile
# =========================
# Requirements:
# - PowerShell 7+ recommended (7.4+ for CommandNotFound suggestions). [web:167][web:163]
# - oh-my-posh installed and available in PATH. [web:152][web:151]
# - Optional: Microsoft.WinGet.CommandNotFound module installed. [web:163]

# ----- Execution Policy hint (commented) -----
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force  # if init lines fail to load. [web:152][web:151]

# ----- Ensure personal bin on PATH (idempotent) -----
$BinPath = 'C:\Users\xprateek\bin'
if (Test-Path $BinPath) {
  $paths = ($env:Path -split ';') | Where-Object { $_ }
  if ($paths -notcontains $BinPath) {
    $env:Path = ($paths + $BinPath) -join ';'   # session PATH only. [web:157]
  }
}

# ----- Friendly launcher for prateek.exe if present -----
$PrateekExe = Join-Path $BinPath 'prateek.exe'
if (Test-Path $PrateekExe) {
  function prateek { & $PrateekExe @Args }   # usage: prateek <args>. [web:161]
}

# ----- oh-my-posh prompt (custom theme with fallback) -----
$OmpConfig = 'C:\Users\xprateek\bin\1_shell.omp.json'
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
  if (Test-Path $OmpConfig) {
    oh-my-posh init pwsh --config $OmpConfig | Invoke-Expression  # custom config. [web:152][web:151]
  } else {
    oh-my-posh init pwsh | Invoke-Expression                       # default theme fallback. [web:152][web:158]
  }
} else {
  # Minimal prompt fallback if oh-my-posh missing.
  function prompt {
    $cwd = (Get-Location).Path
    "PS $cwd> "
  }
}

# ----- PowerToys CommandNotFound (WinGet suggestions) -----
# GUID marker for traceability: f45873b3-b655-43a6-b217-97c00aa0db58. [web:163]
try {
  Import-Module -Name Microsoft.WinGet.CommandNotFound -ErrorAction Stop  # PowerShell 7.4+ feature. [web:167][web:163]
  # f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module. [web:163]
} catch {
  Write-Verbose "Microsoft.WinGet.CommandNotFound not available; install or upgrade PS to 7.4+."  # non-fatal. [web:167]
}
# f45873b3-b655-43a6-b217-97c00aa0db58. [web:163]

# ----- Quality-of-life aliases (avoid changing built-in constant aliases) -----
# Note: gci is a built-in alias to Get-ChildItem and may be Constant/ReadOnly; do not redefine. [web:173][web:149]
Set-Alias ll Get-ChildItem  # ls-like short alias. [web:149]
Set-Alias la Get-ChildItem  # consistent with other shells. [web:149]
Set-Alias cat Get-Content   # Unix-like cat. [web:149]
Set-Alias grep Select-String  # basic text search. [web:149]
Set-Alias touch New-Item    # quick file creation. [web:149]
Set-Alias which Get-Command # which utility. [web:149]

# Recommended to prefer functions for behavior changes over rebinding built-ins. [web:164]

# ----- Handy navigation and utility functions -----
function cd..  { Set-Location .. }  # parent dir. [web:137]
function cd... { Set-Location ..\.. }  # two levels up. [web:137]
function open  { param([Parameter(Mandatory=$true)][string]$Path) Invoke-Item -Path $Path }  # open with shell. [web:137]
function edit  { param([Parameter(Mandatory=$true)][string]$Path) code $Path }  # VS Code quick edit. [web:137]
function whicha { param([Parameter(Mandatory=$true)][string]$Name) Get-Command -All $Name | Select-Object Name, Source, CommandType }  # show all resolutions. [web:173]
function envpath { ($env:Path -split ';') | Where-Object { $_ } | Sort-Object -Unique }  # inspect PATH. [web:157]

# ----- Git helpers (if git exists) -----
if (Get-Command git -ErrorAction SilentlyContinue) {
  function gs { git status }                         # status. [web:137]
  function ga { git add -A }                         # add all. [web:137]
  function gc { param([string]$m) git commit -m $m } # commit. [web:137]
  function gp { git push }                           # push. [web:137]
  function gl { git log --oneline --graph --decorate --all }  # graph log. [web:137]
}

# ----- Nushell interop helpers (if Nu installed) -----
if (Get-Command nu -ErrorAction SilentlyContinue) {
  function To-Nu { param([Parameter(ValueFromPipeline=$true)]$InputObject) process { $InputObject | ConvertTo-Json -Depth 8 } }  # PS->JSON. [web:138]
  function nujson { param([Parameter(ValueFromPipeline=$true)]$InputObject) process { $InputObject | ConvertTo-Json -Depth 8 | nu -c 'from json' } }  # pipe into Nu. [web:138]
  function nu! { nu @Args }  # launch Nu quickly. [web:138]
}

# ----- PSReadLine enhancements (if available) -----
if (Get-Module -ListAvailable PSReadLine) {
  Import-Module PSReadLine -ErrorAction SilentlyContinue  # better editing. [web:137]
  Set-PSReadLineOption -PredictionSource History           # history predictions. [web:137]
  Set-PSReadLineOption -EditMode Windows                   # Windows-style keys. [web:137]
  Set-PSReadLineKeyHandler -Key Tab -Function Complete     # tab completion. [web:137]
}

# ----- Profile utilities -----
function reload-profile { . $PROFILE }             # dot-source to reload. [web:152]
function where-profile  { $PROFILE | Format-List * }  # view all profile paths. [web:131]

# End of profile.
