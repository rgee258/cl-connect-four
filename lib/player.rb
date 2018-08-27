class Player
  
  attr_reader :name, :piece

  def initialize(name, color)
  	@name = name
  	@piece = color
  end

  def make_move
  	puts "It is your turn #{@name}! Where do you want to put your piece (#{@piece})?"
  	puts "Pick your column from 0 to 6."
  	col = gets.chomp
  	invalid_check = /[0-6]/.match(col).nil?
  	while (invalid_check)
  	  puts "Invalid column input, make sure to pick a column from 0 to 6. Let's try again."
  	  col = gets.chomp
  	  invalid_check = /[0-6]/.match(col).nil?
  	end
  	col.to_i
  end
end