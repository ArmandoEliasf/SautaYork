$ErrorActionPreference = "Stop"
$projectRoot = Split-Path -Parent $PSScriptRoot

$requiredFiles = @(
    "README.md",
    "src/index.php",
    "assets/assets.php"
)

$requiredExampleFiles = @(
    "docs/examples/vacante-ejemplo.json",
    "docs/examples/perfil-ejemplo.json",
    "docs/examples/empresa-ejemplo.json"
)

Write-Host "Ejecutando simulación de verificación previa al push..." -ForegroundColor Cyan

foreach ($file in $requiredFiles) {
    $path = Join-Path $projectRoot $file
    if (-not (Test-Path $path)) {
        Write-Error "Falta el archivo requerido: $file"
        exit 1
    }
}

foreach ($file in $requiredExampleFiles) {
    $path = Join-Path $projectRoot $file
    if (-not (Test-Path $path)) {
        Write-Error "Falta el archivo de ejemplo requerido: $file"
        exit 1
    }
}

$php = Get-Command php -ErrorAction SilentlyContinue
if ($php) {
    foreach ($file in @("src/index.php", "assets/assets.php")) {
        $path = Join-Path $projectRoot $file
        & $php.Source -l $path
        if ($LASTEXITCODE -ne 0) {
            Write-Error "La validación de PHP falló para $file"
            exit 1
        }
    }
} else {
    Write-Warning "PHP no está disponible; se omite la validación de sintaxis."
}

Write-Host "Simulación completada correctamente. El push puede continuar." -ForegroundColor Green
