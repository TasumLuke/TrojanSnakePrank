# require the necessary libraries
require 'open-uri'
require 'nokogiri'

# define an array of YouTube video URLs
videos = [
  'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  'https://www.youtube.com/watch?v=xYKUeZQbQ5g'
]

# initialize a counter to keep track of the number of videos played
counter = 0

# create an infinite loop
loop do
  # choose a random video from the array
  video_url = videos.sample

  # open the video in the default web browser
  system "open #{video_url}"

  # increment the counter
  counter += 1

  # check if the counter has reached 40
  if counter >= 40
    # exit the loop if the counter has reached 40
    break
  end

  # pause the program for a few seconds to allow the user to close the video
  sleep 5

  # check if the video is still open
  is_open = system "ps aux | grep '[y]outube'"

  # if the video is not open, add two more videos to the array and start the loop again
  unless is_open
    videos += [
      'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
      'https://www.youtube.com/watch?v=xYKUeZQbQ5g'
    ]
  end
end
