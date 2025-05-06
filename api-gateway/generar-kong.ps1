# Cargar variables del .env
Get-Content .env | ForEach-Object {
    if ($_ -match "^\s*([^#][^=]+?)=(.*)$") {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        [System.Environment]::SetEnvironmentVariable($key, $value, "Process")
    }
}

# Sustituir las variables en el template y generar kong.yml
(Get-Content kong.yml.template) `
  -replace '\$\{DOTNET_AUTH_SERVICE_IP\}', $env:DOTNET_AUTH_SERVICE_IP `
  -replace '\$\{DOTNET_PAYMENT_SERVICE_IP\}', $env:DOTNET_PAYMENT_SERVICE_IP `
  -replace '\$\{JAVA_SERVICE_CHAT_AI_IP\}', $env:JAVA_SERVICE_CHAT_AI_IP `
  -replace '\$\{JAVA_SERVICE_PANEL_IP\}', $env:JAVA_SERVICE_PANEL_IP `
  -replace '\$\{JAVA_SERVICE_TEST_IP\}', $env:JAVA_SERVICE_TEST_IP `
  -replace '\$\{JAVA_SERVICE_UNIVERSITIES_IP\}', $env:JAVA_SERVICE_UNIVERSITIES_IP `
| Set-Content kong.yml

Write-Host "✅ Archivo kong.yml generado correctamente"
