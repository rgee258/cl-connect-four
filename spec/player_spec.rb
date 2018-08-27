require "player"

describe Player do

  before(:each) do
  	@player = Player.new("Player", "Y")
  end

  describe "#make_move" do
  	context "when input a column number of 5" do
  	  it "returns the column number" do
  	  	expect(@player.make_move).to eql(5)
  	  end
    end
  end
end