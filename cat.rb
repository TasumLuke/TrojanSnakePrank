require 'open-uri'

def download_cat_image
  # Generate a random file name for the image
  file_name = "cat#{rand(1000)}.jpg"

  # Download the image and save it to the current directory
  open("https://cataas.com/cat") do |image|
    File.open(file_name, "wb") do |file|
      file.write(image.read)
    end
  end
end

loop do
  download_cat_image
end
