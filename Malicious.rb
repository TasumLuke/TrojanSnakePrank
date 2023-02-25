require 'open3' # Include the Open3 library for running system commands


# Function to run a system command and return the output
def run_command(command)
  stdout, stderr, status = Open3.capture3(command)
  return stdout, stderr, status
end

# Capture audio and video from the webcam
run_command("ffmpeg -f v4l2 -i /dev/video0 -t 30 -vcodec libx264 -acodec pcm_s16le output.mp4")

# Play music from YouTube in the background
run_command("mpv https://www.youtube.com/watch?v=dQw4w9WgXcQ &")

# Display images in a pop-up window every 2 minutes
while true
  run_command("eog image.jpg &")
  sleep(120)
end
