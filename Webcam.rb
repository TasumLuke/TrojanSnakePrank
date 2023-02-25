require 'open3'

camera_name = '@device_pnp_\\\\?\\usb#vid_04f2&pid_b767&mi_00#6&2699bff6&1&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\\global'

def take_picture(camera_name)
  begin
    stdout, stderr, status = Open3.capture3("ffmpeg -f dshow -i video='#{camera_name}' -vframes 1 picture.jpg")
    if status.success?
      puts "Picture saved to picture.jpg"
      return true
    else
      puts "Failed to take picture: #{stderr}"
      return false
    end
  rescue => e
    puts "An error occurred: #{e}"
    return false
  end
end

# Call the function to take a picture
result = take_picture(camera_name)
if result
  puts "Picture taken successfully!"
else
  puts "Failed to take picture."
end
