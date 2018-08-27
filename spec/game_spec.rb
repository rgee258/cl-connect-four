require "game"

describe Game do

  before(:each) do
    @game = Game.new
  end

  describe "#assign_players" do
  	context "when the players are assigned" do
  	  it "returns a string confirming assignment" do
        expect(@game.assign_players("Bob", "Harry")).to eql("Bob you are Player 1, your color is red (R)! Harry you are Player 2, your color is yellow (Y)!")
  	  end
  	end
  end

  describe "#instructions" do
    context "when the game starts and instructions are provided" do
      it "returns a string denoting the game has begun" do
        expect(@game.instructions).to eql("With these instructions done, let's set up the game!")
      end
    end
  end

  describe "#announce_results" do
  	context "when player 1 has won" do
  	  it "returns a string with player 1 results" do
        @game.assign_players("Bob", "Harry")
        expect(@game.announce_results("p1")).to eql("Congratulations, you won Bob!")
  	  end
  	end

    context "when player 2 has won" do
      it "returns a string with player 2 results" do
        @game.assign_players("Bob", "Harry")
        expect(@game.announce_results("p2")).to eql("Congratulations, you won Harry!")
      end
    end

    context "when the game has become a draw" do
      it "returns a string with draw results" do
        @game.assign_players("Bob", "Harry")
        expect(@game.announce_results("draw")).to eql("Looks like this game ends in a draw, good game you two!")
      end
    end
  end

  describe "#setup_game" do
    context "when the program is just starting" do
      it "returns a string to start the game" do
        expect(@game.setup_game).to eql("Without further ado, let's start the game!")
      end
    end
  end
end