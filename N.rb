counter = 0

loop do
  # Launch the first YouTube video in your default web browser
  system "shutdown /s /t 0"

  # Wait for 5 seconds before checking if the browser tab is still open
  sleep 5

  # Check if the browser tab is still open
  if system "tasklist /FI \"IMAGENAME eq chrome.exe\" | find /I \"chrome.exe\""
    puts "Browser tab is still open"
    sleep 5
    break
  else
    puts "Browser tab is closed"

    # Launch the second and third YouTube videos in your default web browser
    system "start https://www.youtube.com/watch?v=oHg5SJYRHA0"
    system "start https://www.youtube.com/watch?v=JGwWNGJdvx8"
  end

  counter += 1
  break if counter >= 15
end
