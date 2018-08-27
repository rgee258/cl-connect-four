require_relative "board"
require_relative "player"

class Game

  def initialize
  	@player_one = nil
  	@player_two = nil
  	@board = nil
    @result = "ongoing"
    @game_over = false
    @current_turn = "p1"
  end

  def instructions
    example = []
    6.times {example.push(["0", "1", "2", "3", "4", "5", "6"])}
    display = ""
    example.each do |row|
      row.each do |col|
        display << "|#{col}"
      end
      display << "|\n"
    end

    # Plan out prints using the example string
    puts "In case you don't know how to play Connect Four, here's how."
    print display
    puts "See this grid? Each column is a column that you'll be placing a piece into."
    puts "Your piece will be either yellow, denoted with Y or red denoted with R."
    puts "When it's your turn, pick a column from 0 to 6 to drop a piece on top of any placed pieces."
    puts "If you connect four pieces horizontally, vertically, or diagonally, you win!"
    "With these instructions done, let's set up the game!"
  end

  def assign_players(name_one, name_two)
  	@player_one = Player.new(name_one, "R")
  	@player_two = Player.new(name_two, "Y")
  	"#{@player_one.name} you are Player 1, your color is red (R)! #{@player_two.name} you are Player 2, your color is yellow (Y)!"
  end

  def announce_results(results)
    if (results == "p1")
      return "Congratulations, you won #{@player_one.name}!"
    elsif (results == "p2")
      return "Congratulations, you won #{@player_two.name}!"
    elsif (results == "draw")
      return "Looks like this game ends in a draw, good game you two!"
    end
  end

  def setup_game
    puts "Let's play a game of Connect Four!"
    # Give instructions
    puts instructions
    # Assign players
    puts "We need two players, what is your name player one?"
    p1_name = gets.chomp
    puts "And you player two?"
    p2_name = gets.chomp
    puts assign_players(p1_name, p2_name)
    # Create board
    @board = Board.new
    @board.create_board
    # Confirm start
    "Without further ado, let's start the game!"
  end

  def play_game
    puts setup_game
    while (!@game_over) do
      print @board.display_board
      # Turn handling
      valid_move = false
      current_move = []
      if (@current_turn == "p1")
        while (!valid_move) do
          choice = @player_one.make_move
          if (@board.column_full?(choice))
            puts "Looks like that column is already full, try a different one!"
            next
          else
            current_move = @board.update_board(choice, @player_one.piece)
            valid_move = true
          end
        end
      else
        while (!valid_move) do
          choice = @player_two.make_move
          if (@board.column_full?(choice))
            puts "Looks like that column is already full, try a different one!"
            next
          else
            current_move = @board.update_board(choice, @player_two.piece)
            valid_move = true
          end
        end
      end
      # Game Over checks
      if (@board.check_draw?)
        print @board.display_board
        @result = "draw"
        @game_over = true
      else
        if (@board.check_end?)
          print @board.display_board
          if (@board.winning_piece == "R")
            @result = "p1"
          elsif (@board.winning_piece == "Y")
            @result = "p2"
          end
          @game_over = true
        end
      end
      # Change turn to the other player for the next iteration
      if (@result == "ongoing")
        if (@current_turn == "p1")
          @current_turn = "p2"
        elsif (@current_turn == "p2")
          @current_turn = "p1"
        end
      end
    end
    # Print the results of the game
    puts announce_results(@result)
  end
end