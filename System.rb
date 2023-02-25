require 'win32ole'

# Create an AudioEndpointVolume object
volume = WIN32OLE.new('AudioEndpointVolume')

# Check the Mute property of the volume object
if volume.Mute
  # Shut down the computer
  system "shutdown /s /t 0"
else
  puts "The computer is not muted."
end
