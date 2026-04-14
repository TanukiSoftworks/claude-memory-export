# export_context.ps1
# Exports all Claude memory files across all projects into a single context file
# for pasting into the Claude app.

$projectsDir = "$PSScriptRoot\projects"
$outputFile = "$PSScriptRoot\context_export.md"

$output = [System.Collections.Generic.List[string]]::new()
$output.Add("# Claude - Full Context Export")
$output.Add("Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm')")
$output.Add("")
$output.Add("This file contains all persistent memory from all Claude Code sessions.")
$output.Add("")

foreach ($projectDir in Get-ChildItem $projectsDir -Directory) {
    $memoryDir = Join-Path $projectDir.FullName "memory"

    if (-not (Test-Path $memoryDir)) { continue }

    $memFiles = Get-ChildItem $memoryDir -Filter "*.md"
    if ($memFiles.Count -eq 0) { continue }

    $output.Add("---")
    $output.Add("# Project: $($projectDir.Name)")
    $output.Add("")

    # MEMORY.md index first
    $memoryIndex = Join-Path $memoryDir "MEMORY.md"
    if (Test-Path $memoryIndex) {
        $output.Add("## MEMORY.md (index)")
        $output.Add("")
        $output.Add((Get-Content $memoryIndex -Raw).TrimEnd())
        $output.Add("")
    }

    # Then all other memory files
    foreach ($file in $memFiles | Where-Object { $_.Name -ne "MEMORY.md" } | Sort-Object Name) {
        $output.Add("## $($file.Name)")
        $output.Add("")
        $output.Add((Get-Content $file.FullName -Raw).TrimEnd())
        $output.Add("")
    }
}

$output | Out-File -FilePath $outputFile -Encoding UTF8

$sizeKB = [math]::Round((Get-Item $outputFile).Length / 1KB, 1)
Write-Host "Context exported to: $outputFile"
Write-Host "Size: $sizeKB KB"
Write-Host "You can now attach this file to a Claude app conversation for full context."
