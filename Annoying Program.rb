require 'open3' # Include the Open3 library for running system commands

require 'open-uri'

require 'tk'

require 'open3'

# Set the command to run Notepad
command = "notepad"

# Run an infinite loop
loop do
  # Open a new Notepad window
  Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
    # Wait for the Notepad window to open
    sleep(1)

    # Use the Windows Automation API to add the text to the Notepad document
    require 'win32ole'
    include WIN32OLE::VARIANT
    shell = WIN32OLE.new('Shell.Application')
    notepads = shell.Windows()
    notepads.each do |notepad|
      if notepad.name == "Untitled - Notepad"
        notepad.document.selection.typeText("I got you good")
      end
    end
  end
end



