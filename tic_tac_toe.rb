require 'pry'

class Board
  def initialize
    @grid = Array.new(9) { ' ' }
  end

  def read_board
    display_string = "|   Game   |\n"
    @grid.each.with_index(1) do |val, ind|
      display_string += val == ' ' ? "| #{ind} " : "| #{val} "
      display_string += "|\n" if (ind % 3).zero?
    end
    puts display_string
  end

  def make_play(current_player)
    puts ' -- Type in the number for a position to make a play!'
    pos_input = gets.chomp.to_i
    if @grid[pos_input - 1] == ' '
      @grid[pos_input - 1] = current_player.icon
      puts "-- | #{current_player.name} | puts an #{current_player.icon} at #{pos_input}."
    else
      puts('This position has already been played, select another one: ')
    end      
  end

  def check_condition(player)
    winner = false
    if @grid.any?(' ')      
      if check_win(player.icon) == true
        winner = player
      end        
    else
      winner = 'draw'
    end
    return winner
  end

  def check_win(val)
    set = [[0, 4, 8], [2, 4, 6], [0, 1, 2], [0, 3, 6]]

    set.each_with_index do |inner_set, inner_index|
      times = 3
      off_val = 0
      result = true

      case inner_index
      when 0, 1
        times = 1
      when 2
        off_val = 3
      when 3
        off_val = 1
      end

      offset = 0
      times.times do
        inner_set.each do |i|
          result = @grid[i + offset] == val ? result : false
        end
        break if result
  
        offset + off_val
      end

      next unless result  
      return result
    end
  end
end

class Player
  @@has_player_one = false
  attr_reader :name, :icon

  def initialize(name, icon)
    @name = name
    @icon = icon
  end

  def self.set_player
    puts 'Type in your name: '
    ask_name = gets.chomp
    icon = @@has_player_one ? 'X' : '@'; @@has_player_one = true
    Player.new(ask_name, icon)
  end
end

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
    puts 'Type in how many rounds to play: '
    get_rounds = gets.chomp.to_i
    get_rounds = 5 if get_rounds > 5
    get_rounds = 1 if get_rounds.zero?
    Game.new(p_one, p_two, get_rounds)
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
  end

  def run_turn
    game_state = false
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
