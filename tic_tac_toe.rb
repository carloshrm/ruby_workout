# frozen_string_literal: true

require 'pry'

# Defines and hold information about the playing grid along with methods to manipulate it.
class Board
  def initialize
    @grid = Array.new(9) { ' ' }
  end

  def read_board
    display_string = "|    Game    |\n"
    @grid.each.with_index(1) do |val, ind|
      display_string += val == ' ' ? "| #{ind} " : "| #{val} "
      display_string += "|\n" if (ind % 3).zero?
    end
    puts display_string
  end

  def make_play(current_player)
    puts ' -- Type in a position to make a play!'
    pos_input = gets.chomp.to_i
    if @grid[pos_input - 1] == ' '
      @grid[pos_input - 1] = current_player.icon
      puts "-- | #{current_player.name} | puts an #{current_player.icon} at #{pos_input}."
    else
      puts('This position has already been chosen, select another one: ')
      make_play(current_player)
    end
  end

  def check_condition(player)
    winner = false
    if @grid.any?(' ')
      winner = player if check_win(player.icon) == true
    else
      winner = 'draw'
    end
    winner
  end

  def check_win(val)
    set = [[0, 4, 8], [2, 4, 6], [0, 1, 2],[3,4,5],[6,7,8], [0, 3, 6], [1,4,7], [2,5,8]]

    set.each do |inner_set|
      result = true
        inner_set.each do |i|
          result = @grid[i] == val ? result : false
        end
      next unless result

      return result
    end
  end
end

# Sets up and stores information about each player.
class Player
  @@has_player_one = false
  attr_reader :name, :icon

  def initialize(name, icon)
    @name = name
    @icon = icon
  end

  def self.set_player
    puts '== Type in your name: '
    ask_name = gets.chomp
    icon = @@has_player_one ? 'X' : '@'
    @@has_player_one = true
    Player.new(ask_name, icon)
  end
end

# Hold information about the game implementing Players and Board class, along with rounds and wins. 
# Contains the main methods that control the flow of the game.
class Game
  attr_accessor :players, :total_rounds

  def initialize(player_one, player_two, rounds)
    @total_rounds = rounds
    @players = [player_one, player_two]
  end

  def self.setup_game
    puts 'welcome'
    puts 'Player one --'
    p_one = Player.set_player
    puts 'Player two --'
    p_two = Player.set_player
    get_rounds = setup_rounds

    Game.new(p_one, p_two, get_rounds)
  end

  def self.setup_rounds
    puts '== Type in how many rounds to play: '
    round_in = gets.chomp.to_i
     if round_in > 5
      round_in = 5
      puts "-- Going for 5 rounds maximum."
     end  
    if round_in.zero?
      round_in = 1
      puts "-- Defaulting to a minimum of 1 round."
    end
    round_in
  end

  def start_game
    @current_board = Board.new
    @round_tracker = []
    while @round_tracker.count < @total_rounds
      puts "\n-- Starting"
      puts " Round #{@round_tracker.count + 1} of #{@total_rounds}."
      result = run_turn
      check_result(result)
    end
    puts "\n\n Game Over! =)"
  end

  def run_turn(game_state: false)
    until game_state
      @players.each do |player|
        break if game_state

        puts "-- Player ~ #{player.name} ~ goes next..."
        @current_board.read_board
        @current_board.make_play(player)
        game_state = @current_board.check_condition(player)
      end
    end
    game_state
  end

  def check_result(res)
    if res.is_a?(String)
      puts 'This round ended in a draw.'
      @round_tracker.push(nil)
    else
      puts "!! ~ #{res.name} ~ has won this round!"
      @round_tracker.push(res.name)
    end
    @current_board.read_board
  end

  def game_over
    puts '-- All the rounds are over.'
    # TODO: report
  end
end

new = Game.setup_game
new.start_game
