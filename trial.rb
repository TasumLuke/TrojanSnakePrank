# Initialize the game
puts "Welcome to Battle Ship!"
puts "Please choose your game mode: (1) Single player against AI, or (2) Two player"
mode = gets.chomp.to_i

# Set up the game board
puts "Please enter the size of the game board (minimum 5, maximum 20):"
board_size = gets.chomp.to_i
board_size = [board_size, 5].max
board_size = [board_size, 20].min
board = Array.new(board_size) { Array.new(board_size) }

# Place the ships on the board
if mode == 1
  # Place player's ships
  puts "Please place your ships on the board (1-3 tiles):"
  puts "Enter the coordinates in the format 'x,y'"
  puts "For example, '0,0' places the ship at the top left corner"

  # Place AI's ships at random
  puts "AI is placing its ships at random..."
  ships = [1, 2, 3]
  placed_ships = []
  ships.each do |ship|
    # Try to place the ship at random until it fits on the board
    while true
      x = rand(board_size)
      y = rand(board_size)
      orientation = rand(2) == 0 ? :horizontal : :vertical

      # Check if the ship can be placed at the selected coordinates
      can_place = true
      ship.times do |i|
        if orientation == :horizontal
          can_place = false if x + i >= board_size || board[y][x + i]
        elsif orientation == :vertical
          can_place = false if y + i >= board_size || board[y + i][x]
        end
      end

      # Place the ship on the board if it fits
      if can_place
        ship.times do |i|
          if orientation == :horizontal
            board[y][x + i] = :ai
          elsif orientation == :vertical
            board[y + i][x] = :ai
          end
        end
        placed_ships << [x, y, orientation]
        break
      end
    end
  end
elsif mode == 2
  # Place player 1's ships
  puts "Player 1, please place your ships on the board (1-3 tiles):"
  puts "Enter the coordinates in the format 'x,y'"
  puts "For example, '0,0' places the ship at the top left corner"
  ships = [1, 2, 3]
  placed_ships = []
  ships.each do |ship|
    while true
        puts "Please enter the coordinates for your #{ship}-tile ship:"
        coordinates = gets.chomp
        x, y = coordinates.split(",").map(&:to_i)
        orientation = gets.chomp == "h" ? :horizontal : :vertical

        # Check if the ship can be placed at the selected coordinates
        can_place = true
        ship.times do |i|
          if orientation == :horizontal
            can_place = false if x + i >= board_size || board[y][x + i]
          elsif orientation == :vertical
            can_place = false if y + i >= board_size || board[y + i][x]
          end
        end

        # Check if the ship overlaps with any other ships
        placed_ships.each do |placed_x, placed_y, placed_orientation|
          if orientation == :horizontal
            can_place = false if placed_orientation == :horizontal && y == placed_y && (x + ship >= placed_x && x <= placed_x + ship)
            can_place = false if placed_orientation == :vertical && (x + ship >= placed_x && x <= placed_x) && (y == placed_y || y == placed_y + 1 || y == placed_y - 1)
          elsif orientation == :vertical
            can_place = false if placed_orientation == :horizontal && (y + ship >= placed_y && y <= placed_y) && (x == placed_x || x == placed_x + 1 || x == placed_x - 1)
            can_place = false if placed_orientation == :vertical && x == placed_x && (y + ship >= placed_y && y <= placed_y + ship)
          end
        end

        # Place the ship on the board if it fits
        if can_place
          ship.times do |i|
            if orientation == :horizontal
              board[y][x + i] = :player1
            elsif orientation == :vertical
              board[y + i][x] = :player1
            end
          end
          placed_ships << [x, y, orientation]
          break
        else
          puts "Invalid coordinates, please try again!"
        end
      end
    end
  
          
    # Place player 2's ships
    puts "Player 2, please place your ships on the board (1-3 tiles):"
    puts "Enter the coordinates in the format 'x,y'"
    puts "For example, '0,0' places the ship at the top left corner"
    ships = [1, 2, 3]
    placed_ships = []
    ships.each do |ship|
      while true
        puts "Please enter the coordinates for your #{ship}-tile ship:"
        coordinates = gets.chomp
        x, y = coordinates.split(",").map(&:to_i)
        orientation = gets.chomp == "h" ? :horizontal : :vertical

        # Check if the ship can be placed at the selected coordinates
        can_place = true
        ship.times do |i|
          if orientation == :horizontal
            can_place = false if x + i >= board_size || board[y][x + i]
          elsif orientation == :vertical
            can_place = false if y + i >= board_size || board[y + i][x]
          end
        end

        # Check if the ship overlaps with any other ships
        placed_ships.each do |placed_x, placed_y, placed_orientation|
          if orientation == :horizontal
            can_place = false if placed_orientation == :horizontal && y == placed_y && (x + ship >= placed_x && x <= placed_x + ship)
            can_place = false if placed_orientation == :vertical && (x + ship >= placed_x && x <= placed_x) && (y == placed_y || y == placed_y + 1 || y == placed_y - 1)
          elsif orientation == :vertical
            can_place = false if placed_orientation == :horizontal && (y + ship >= placed_y && y <= placed_y) && (x == placed_x || x == placed_x + 1 || x == placed_x - 1)
            can_place = false if placed_orientation == :vertical && x == placed_x && (y + ship >= placed_y && y <= placed_y + ship)
          end
        end

        # Place the ship on the board if it fits
        if can_place
          ship.times do |i|
            if orientation == :horizontal
              board[y][x + i] = :player2
            elsif orientation == :vertical
              board[y + i][x] = :player2
            end
          end
          placed_ships << [x, y, orientation]
          break
        else
          puts "Invalid coordinates, please try again!"
        end
      end
    end
  else
    puts "Invalid game mode, please try again!"
    exit
  end

# Start the game
while true
  # Display the game board
  puts "  " + (0...board_size).to_a.join(" ")
  board.each_with_index do |row, y|
    print y
    row.each do |cell|
      if cell == :hit
        print "X "
      elsif cell == :miss
        print ". "
      elsif cell == :player1 || cell == :player2
        print "S "
      else
        print "  "
      end
    end
    puts ""
  end

  if mode == 1
    # Player's turn
    puts "Your turn! Enter coordinates to attack:"
    coordinates = gets.chomp
    x, y = coordinates.split(",").map(&:to_i)

    # Check if the coordinates are valid and not attacked before
    if x < 0 || x >= board_size || y < 0 || y >= board_size || board[y][x] == :hit || board[y][x] == :miss
      puts "Invalid coordinates, please try again!"
      next
    end

    # Attack the coordinates
    if board[y][x] == :ai
      puts "Hit!"
      board[y][x] = :hit
    else
      puts "Missed!"
      board[y][x] = :miss
    end

    # AI's turn
    puts "AI is attacking..."
    if ai_previous_hit
      # If AI has hit a ship previously, try to attack tiles near the hit tile
      valid_attacks = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        .map { |dx, dy| [ai_previous_hit[0] + dx, ai_previous_hit[1] + dy] }
        .select { |x, y| x >= 0 && x < board_size && y >= 0 && y < board_size && board[y][x] != :hit && board[y][x] != :miss }
      if valid_attacks.empty?
        # If there are no valid attacks near the hit tile, attack a random tile
        ai_previous_hit = nil
        coordinates = [rand(board_size), rand(board_size)]
      else
        # Attack a tile near the hit tile
        coordinates = valid_attacks.sample
      end
    else
      # Attack a random tile
      coordinates = [rand(board_size), rand(board_size)]
    end
    x, y = coordinates
    if board[y][x] == :ai
      puts "AI hit your ship!"
      board[y][x] = :hit
      ai_previous_hit = coordinates
    else
      puts "AI missed!"
      board[y][x] = :miss
    end
      
    # Check if the game is over
    player_won = true
    board.each do |row|
      row.each do |cell|
        player_won = false if cell == :ai
      end
    end
    
    if player_won
      puts "Congratulations, you won the game!"
      break
    end

  elsif mode == 2
    # Player 1's turn
    puts "Player 1's turn! Enter coordinates to attack:"
    coordinates = gets.chomp
    x, y = coordinates.split(",").map(&:to_i)

    # Check if the coordinates are valid and not attacked before
    if x < 0 || x >= board_size || y < 0 || y >= board_size || board[y][x] == :hit || board[y][x] == :miss
      puts "Invalid coordinates, please try again!"
      next
    end

    # Attack the coordinates
    if board[y][x] == :player2
      puts "Hit!"
      board[y][x] = :hit
    else
      puts "Missed!"
      board[y][x] = :miss
    end

    # Player 2's turn
    puts "Player 2's turn! Enter coordinates to attack:"
    coordinates = gets.chomp
    x, y = coordinates.split(",").map(&:to_i)

    # Check if the coordinates are valid and not attacked before
    if x < 0 || x >= board_size || y < 0 || y >= board_size || board[y][x] == :hit || board[y][x] == :miss
      puts "Invalid coordinates, please try again!"
      next
    end

    # Attack the coordinates
    if board[y][x] == :player1
      puts "Hit!"
      board[y][x] = :hit
    else
      puts "Missed!"
      board[y][x] = :miss
    end

  else
    puts "Invalid game mode, please try again!"
    exit
  end

  # Check if the game is over
  if mode == 1
    # Check if player has lost
    player_lost = placed_ships.all? do |x, y, orientation|
      if orientation == :horizontal
        (x...x + ship).any? { |i| board[y][i] == :hit }
      elsif orientation == :vertical
        (y...y + ship).any? { |j| board[j][x] == :hit }
      end
    end

    # Check if AI has lost
    ai_lost = placed_ships.all? do |x, y, orientation|
      if orientation == :horizontal
        (x...x + ship).any? { |i| board[y][i] == :miss }
      elsif orientation == :vertical
        (y...y + ship).any? { |j| board[j][x] == :miss }
      end
    end

    if player_lost
      puts "You lost the game!"
      exit
    elsif ai_lost
      puts "You won the game!"
      exit
    end
    
  elsif mode == 2
        player1_lost = placed_ships.all? do |x, y, orientation|
            if orientation == :horizontal
                (x...x + ship).any? { |i| board[y][i] == :miss }
            elsif orientation == :vertical
                (y...y + ship).any? { |j| board[j][x] == :miss }
            end
        player1_lost = placed_ships.all? do |x, y, orientation|
      if orientation == :horizontal
        (x...x + ship).any? { |i| board[y][i] == :miss }
      elsif orientation == :vertical
        (y...y + ship).any? { |j| board[j][x] == :miss }
      end
    end
    end
    
    # Check if player 2 has lost
    player2_lost = placed_ships.all? do |x, y, orientation|
      if orientation == :horizontal
        (x...x + ship).any? { |i| board[y][i] == :miss }
      elsif orientation == :vertical
        (y...y + ship).any? { |j| board[j][x] == :miss }
      end
    end

    if player1_lost
      puts "Player 2 won the game!"
      exit
    elsif player2_lost
      puts "Player 1 won the game!"
      exit
    end
    else
    puts "Invalid game mode, please try again!"
    exit
  end
end
