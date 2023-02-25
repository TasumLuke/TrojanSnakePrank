'#!/c/Ruby31-x64/bin/ruby'

require 'open3'
require 'launchy'
require 'ffi'

module Windows
  extend FFI::Library

  ffi_lib 'winmm'

  attach_function :waveOutGetVolume, [:ulong, :pointer], :mmresult
end

class MmResult < FFI::Struct
  layout :value, :long
end


counter = 0

while true
  # Launch the first YouTube video in your default web browser
  Launchy.open("https://www.youtube.com/watch?v=dQw4w9WgXcQ")

  # Wait for 5 seconds before checking if the browser tab is still open
  # Check if the PC is muted every 1 second
  while true
    # Get the current volume level
    attach_function :waveOutGetVolume, [:ulong, :pointer], MmResult
    volume_ptr = FFI::MemoryPointer.new :ulong
    result = Windows.waveOutGetVolume(0, volume_ptr)

    if result == 0
      volume = volume_ptr.read_ulong
      puts "Volume: #{volume}"
      # Shut down the computer
      system("shutdown /s /t 0")
      break
    else
      puts "Error getting volume: #{result}"
    end

    # Sleep for 1 second before checking again
    sleep 1
  end

  sleep 5

  # Check if the browser tab is still open
  process_list_output, _, _ = Open3.capture3("tasklist /fi \"IMAGENAME eq chrome.exe\" | find /I \"chrome.exe\"")
  if !process_list_output.empty?
    puts "Browser tab is still open"
    sleep 5
  else
    puts "Browser tab is closed"
    # Launch the second and third YouTube videos in your default web browser
    system("start https://www.youtube.com/watch?v=oHg5SJYRHA0")
    system("start https://www.youtube.com/watch?v=JGwWNGJdvx8")
  end
  counter += 1
  if counter >= 15
    break
  end
end
