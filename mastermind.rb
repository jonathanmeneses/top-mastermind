require "pry-byebug"
class Board
  attr_accessor :round, :solution, :last_guess, :hints, :outcome
  def initialize
    @round = 1
    @solution = []
    @last_guess = []
    @hints = []
    @outcome = ''
  end

  def random_solution()
    prng = Random.new
    temp_solution = []
    4.times do
      temp_solution.push(prng.rand(1..6).to_s)
    end
    self.solution = temp_solution
  end

  def check_guess(guess)
    hints = []
    solution = self.solution.dup
    check_guess = guess.dup
    check_guess.each_with_index do |element, index|
      if solution[index] == element
        hints.push("X")
        check_guess[index] = nil
        solution[index] = nil
      # binding.pry
      end
    end
    # binding.pry
    check_guess.each_with_index do |element,index|
      if element and solution.include?(element)
        solution[solution.find_index(element)] = nil
        hints.push("O")
      end

    end
    return hints.reverse
  end

  def get_guess()


    guess = ''
    until (guess.length == 4 and guess.split('').all? {|e| [*1..6].include?(e.to_i)})
      puts "what is your guess?"
      guess = gets.chomp
      if guess.length != 4 or not(guess.split('').all? {|e| [*1..6].include?(e.to_i)})
        puts "Invalid Guess! Please try again!"
      end
    end
  guess.split('')
  end

  def play_as_codebreaker()
    playing_game = true
    self.random_solution
    puts "Welcome to mastermind, codebreaker"
    puts "Your task is to break the code, by guessing a 4 number sequence correctly in 12 rounds or less"
    puts "Codes can contain numbers from 1 to 6"
    puts "When you guess, we'll provide a hint back with [X] being right number, right place, and [O] being right number in the wrong place"
    puts "shall we begin? \n \n \n"
    while playing_game
      puts "Round #{self.round}"
      self.last_guess = self.get_guess()
      if self.last_guess == self.solution
        self.outcome = 'win'
        playing_game = false
        break
      end
      self.hints = self.check_guess(self.last_guess)
      puts "not quite -- here are your hints: "
      puts "\nGuess: #{self.last_guess}"
      puts "Hints: #{self.hints}"
      puts "\n"
      self.round += 1
      if round > 12
        self.outcome = 'lose'
        playing_game = false
        break
      end


    end
    puts "You #{self.outcome}. The code was #{self.solution} and the game went to #{self.round} rounds!"
  end
end

test = Board.new
test.play_as_codebreaker
