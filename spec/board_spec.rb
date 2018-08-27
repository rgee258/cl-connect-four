require "board"

describe Board do

  before(:each) do
    @board = Board.new
  end

  describe "#create_board" do
  	it "returns an array with unfilled slots" do
      expect(@board.create_board).to eql([[" ", " ", " ", " ", " ", " ", " "], [" ", " ", " ", " ", " ", " ", " "], 
        [" ", " ", " ", " ", " ", " ", " "], [" ", " ", " ", " ", " ", " ", " "], [" ", " ", " ", " ", " ", " ", " "], 
        [" ", " ", " ", " ", " ", " ", " "]])
  	end
  end

  describe "#display_board" do
  	it "returns a large string with the board state after creating the initial board" do
      @board.create_board
      expect(@board.display_board).to eql("| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n")
  	end
  end

  describe "#column_full?" do
    context "given a not full column" do
      it "returns false when the column is not full and available for update" do
        @board.create_board
        expect(@board.column_full?(0)).to eql(false)
      end
    end

    context "given a full column" do
      it "returns true when the column is full" do
        @board.create_board
        6.times do
          @board.update_board(0, "Y")
        end
        expect(@board.column_full?(0)).to eql(true)
      end
    end
  end

  # Start with the col value, increment the row val starting from 0, checking for empty each time
  # If there is a value/piece, add the piece to the current one -1
  # Prevent adding a piece if #column_full? returns true
  describe "#update_board" do
    context "when the board is empty and we add a piece to column 0" do
    	it "returns the board position the piece was added at" do
        @board.create_board
        expect(@board.update_board(0, "Y")).to eql([5,0])
      end
    end
  end

  describe "#check_end?" do
  	context "when a player has won with 4 in a row going down" do
  	  it "returns true" do
        @board.create_board
        4.times do
          @board.update_board(0, "Y")
        end
        expect(@board.check_end?).to eql(true)
  	  end
  	end

    context "when a player has won with 4 in a row going left" do
      it "returns true" do
        @board.create_board
        4.times do |i|
          @board.update_board(i, "Y")
        end
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when a player has won with 4 in a row going right" do
      it "returns true" do
        @board.create_board
        4.times do |i|
          start = 3
          @board.update_board(start + i, "Y")
        end
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when a player has won with 4 in a row going diagonal up left" do
      it "returns true" do
        @board.create_board
        3.times do
          @board.update_board(0, "R")
        end
        @board.update_board(0, "Y")
        2.times do
          @board.update_board(1, "R")
        end
        @board.update_board(1, "Y")
        @board.update_board(2, "R")
        @board.update_board(2, "Y")
        @board.update_board(3, "Y")
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when a player has won with 4 in a row going diagonal up right" do
      it "returns true" do
        @board.create_board
        @board.update_board(0, "Y")
        @board.update_board(1, "R")
        @board.update_board(1, "Y")
        2.times do
          @board.update_board(2, "R")
        end
        @board.update_board(2, "Y")
        3.times do
          @board.update_board(3, "R")
        end
        @board.update_board(3, "Y")
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when a player has won with 4 in a row going diagonal down left" do
      it "returns true" do
        @board.create_board
        @board.update_board(0, "Y")
        @board.update_board(1, "R")
        @board.update_board(1, "Y")
        2.times do
          @board.update_board(2, "R")
        end
        @board.update_board(2, "Y")
        3.times do
          @board.update_board(3, "R")
        end
        @board.update_board(3, "Y")
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when a player has won with 4 in a row going diagonal down right" do
      it "returns true" do
        @board.create_board
        3.times do
          @board.update_board(0, "R")
        end
        @board.update_board(0, "Y")
        2.times do
          @board.update_board(1, "R")
        end
        @board.update_board(1, "Y")
        @board.update_board(2, "R")
        @board.update_board(2, "Y")
        @board.update_board(3, "Y")
        expect(@board.check_end?).to eql(true)
      end
    end

    context "when no player has won" do
      it "returns false" do
        @board.create_board
        @board.update_board(0, "Y")
        expect(@board.check_end?).to eql(false)
      end
    end
  end

  describe "#check_draw?" do
    context "when the entire board is filled with a draw" do
      it "returns true" do
        @board.create_board
        7.times do
          @board.update_board(0, "Y")
          @board.update_board(1, "Y")
          @board.update_board(2, "Y")
          @board.update_board(3, "Y")
          @board.update_board(4, "Y")
          @board.update_board(5, "Y")
          @board.update_board(6, "Y")
        end

        expect(@board.check_draw?).to eql(true)
      end
    end

    context "when the board is empty" do
      it "returns false" do
        @board.create_board
        expect(@board.check_draw?).to eql(false)
      end
    end
  end
end