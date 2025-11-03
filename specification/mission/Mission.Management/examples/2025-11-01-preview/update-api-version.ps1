$files = Get-ChildItem -Filter "*.json"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace '"api-version": "2025-09-01-preview"', '"api-version": "2025-11-01-preview"'
    Set-Content -Path $file.FullName -Value $content
}
