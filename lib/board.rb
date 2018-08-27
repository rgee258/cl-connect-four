class Board

  attr_reader :winning_piece

  def initialize
  	@board = []
    @winning_piece = ""
  end

  def create_board
  	6.times {@board.push([" ", " ", " ", " ", " ", " ", " "])}
    @board
  end

  def display_board
  	display = ""
  	@board.each do |row|
  	  row.each do |col|
  	  	display << "|#{col}"
  	  end
  	  display << "|\n"
  	end
  	display
  end

  def column_full?(col)
    # Remember our rows start at 0 for the top
  	if (@board[0][col] == " ")
  	  false
  	else 
  	  true
  	end
  end

  def update_board(col, piece)
    row = 5
    while (row > -1) do
      if (@board[row][col] == " ")
        @board[row][col] = piece
        return [row, col]
      end
      row -= 1
    end
  end

  def check_draw?
    7.times do |i|
      return false unless column_full?(i)
    end
    true
  end

  
  def check_end?
    6.times do |row|
      7.times do |col|
        piece = @board[row][col]
        if (piece != " ") 
          # Check down, left, right, down diagonal left, down diagonal right, up diagonal left, up diagonal right
          # Check matching down
          if (row < 3)
            if (@board[row + 1][col] == piece && @board[row + 2][col] == piece && @board[row + 3][col] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking matching left
          if (col > 2)
            if (@board[row][col - 1] == piece && @board[row][col - 2] == piece && @board[row][col - 3] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking matching right
          if (col < 4)
            if (@board[row][col + 1] == piece && @board[row][col + 2] == piece && @board[row][col + 3] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking diagonal up left
          if (row > 3 && col > 2)
            if (@board[row - 1][col - 1] == piece && @board[row - 2][col - 2] == piece && @board[row - 3][col - 3] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking diagonal up right
          if (row > 3 && col < 4)
            if (@board[row - 1][col + 1] == piece && @board[row - 2][col + 2] == piece && @board[row - 3][col + 3] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking diagonal down left
          if (row < 3 && col > 2)
            if (@board[row + 1][col - 1] == piece && @board[row + 2][col - 2] == piece && @board[row + 3][col - 3] == piece)
              @winning_piece = piece
              return true
            end
          end
          # Checking diagonal down right
          if (row < 3 && col < 4)
            if (@board[row + 1][col + 1] == piece && @board[row + 2][col + 2] == piece && @board[row + 3][col + 3] == piece)
              @winning_piece = piece
              return true
            end
          end
        end
      end
    end
    false
  end
end