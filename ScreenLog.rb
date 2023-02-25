# Set the maximum logging time in seconds
$MAX_LOG_TIME = 7200 # 2 hours

# Set the file path for the log directory
$LOG_DIR_PATH = 'C:\Users\Public\logs'

# Create the log directory if it does not exist
New-Item -ItemType Directory -Path $LOG_DIR_PATH -Force | Out-Null

# Set the start time
$start_time = Get-Date

# Define the .NET framework class for taking screenshots
Add-Type -AssemblyName System.Drawing

# Loop until the maximum logging time is reached or the terminal is closed
while ((Get-Date) - $start_time).TotalSeconds -lt $MAX_LOG_TIME {
  # Capture the screen using the .NET framework class
  $bmp = New-Object System.Drawing.Bitmap([System.Drawing.Screen]::PrimaryScreen.Bounds.Width, [System.Drawing.Screen]::PrimaryScreen.Bounds.Height)
  $graphics = [System.Drawing.Graphics]::FromImage($bmp)
  $graphics.CopyFromScreen([System.Drawing.Point]::Empty, [System.Drawing.Point]::Empty, $bmp.Size)
  $file_path = "$LOG_DIR_PATH\screenshot_$((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')).png"
  $bmp.Save($file_path, [System.Drawing.Imaging.ImageFormat]::Png)

  # Record the audio using the Sound Recorder utility
  $file_path = "$LOG_DIR_PATH\audio_$((Get-Date).ToString('yyyy-MM-dd_HH-mm-ss')).wav"
  Start-Process "soundrecorder" -ArgumentList "/FILE $file_path /DURATION 00:00:30"

  # Sleep for a specified interval before capturing the next frame
  Start-Sleep -Seconds 30
}
