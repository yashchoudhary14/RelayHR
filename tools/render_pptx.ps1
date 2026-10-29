# Renders a .pptx to PDF and one PNG per slide using the installed PowerPoint (COM).
# Usage: powershell -ExecutionPolicy Bypass -File tools\render_pptx.ps1 -Pptx <path.pptx> [-OutDir <dir>] [-Width 1920]
param(
    [Parameter(Mandatory = $true)][string]$Pptx,
    [string]$OutDir = '',
    [int]$Width = 1920
)
$ErrorActionPreference = 'Stop'
$pptxPath = (Resolve-Path $Pptx).Path
$base = [System.IO.Path]::GetFileNameWithoutExtension($pptxPath)
if ($OutDir -eq '') { $OutDir = Join-Path (Split-Path -Parent $pptxPath) ('render_' + $base) }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$OutDir = (Resolve-Path $OutDir).Path
$pdfPath = Join-Path $OutDir ($base + '.pdf')

$app = $null
$pres = $null
try {
    $app = New-Object -ComObject PowerPoint.Application
    # Open(FileName, ReadOnly=msoTrue, Untitled=msoFalse, WithWindow=msoFalse)
    $pres = $app.Presentations.Open($pptxPath, -1, 0, 0)
    $height = [int][Math]::Round($Width * $pres.PageSetup.SlideHeight / $pres.PageSetup.SlideWidth)
    $pres.SaveAs($pdfPath, 32)  # ppSaveAsPDF
    $i = 0
    foreach ($slide in $pres.Slides) {
        $i++
        $png = Join-Path $OutDir ('slide-{0}.png' -f $i)
        $slide.Export($png, 'PNG', $Width, $height)
    }
    Write-Output ('PDF: ' + $pdfPath)
    Write-Output ('Slides: ' + $i)
    Write-Output ('PNGs: ' + $OutDir)
} finally {
    if ($null -ne $pres) { $pres.Close(); [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($pres) }
    if ($null -ne $app) { $app.Quit(); [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject($app) }
}
