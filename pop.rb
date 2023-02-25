require 'open-uri'

# The URL of the YouTube music video
video_url = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

# Open the video in two web browser tabs
loop do
  system("open", "-a", video_url, video_url)
  sleep 5
end
