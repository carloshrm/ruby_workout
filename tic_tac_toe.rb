# frozen_string_literal: true

# Defines and hold information about the playing grid along with methods to manipulate it.
class Board
  def initialize
    @grid = Array.new(9) { ' ' }
  end

  def read_board
    display_string = "|   Game    |\n"
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
    preset_matches = [[0, 4, 8], [2, 4, 6], [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8]]
    preset_matches.each do |inner_set|
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
    ask_name = ask_name.empty? ? "John Doe" : ask_name
    puts "Hi #{ask_name}!\n"
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
    puts '-- Welcome to console Tic-Tac-Toe! --'
    puts 'Player one --'
    p_one = Player.set_player
    puts 'Player two --'
    p_two = Player.set_player
    get_rounds = setup_rounds

    Game.new(p_one, p_two, get_rounds)
  end

  def self.setup_rounds
    puts '== Type in how many matches to play: '
    round_in = gets.chomp.to_i
    if round_in > 5
      round_in = 5
      puts '-- Going for 5 matches maximum.'
    end
    if round_in.zero?
      round_in = 1
      puts '-- Defaulting to a minimum of 1 match.'
    end
    round_in
  end

  def start_game
    @round_tracker = { count: 0, @players[0].name => 0, @players[1].name => 0 }
    while @round_tracker[:count] < @total_rounds
      @current_board = Board.new
      puts "\n-- Starting"
      puts " Match #{@round_tracker[:count] + 1} of #{@total_rounds}."
      check_result(run_turn)
      puts "\n -- press enter to continue --"
      gets
    end
    game_over
  end

  def run_turn(game_state: false)
    until game_state
      @players.each do |player|
        break if game_state

        puts "-- Player ~ #{player.name} ~ goes next..."
        @current_board.read_board
        @current_board.make_play(player)
        game_state = @current_board.check_condition(player)
        puts "\e[H\e[2J"
      end
    end
    game_state
  end

  def check_result(res)
    if res.is_a?(String)
      puts 'This match ended in a draw.'
    else
      puts "\n!! ~ #{res.name} ~ won this match !!\n"
      @round_tracker[res.name] += 1
    end
    @current_board.read_board
    @round_tracker[:count] += 1
  end

  def game_over
    puts "\n -- All matches are over, overall score: "
    overall = 0
    @round_tracker.each do |k, v|
      next if k == :count

      grammar_pls = v > 1 ? 'wins' : 'win'
      puts "=> #{k} had #{v} #{grammar_pls}."
      overall = v > overall ? v : overall
    end
    @round_tracker[:count] = -1
    puts overall.zero? ? 'The game ended in a draw.' : "\n !! #{@round_tracker.key(overall)} is the champion!!"
    puts "\n Game Finished. =) "
  end
end

new = Game.setup_game
new.start_game
