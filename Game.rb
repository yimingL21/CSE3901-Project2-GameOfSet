require_relative 'Deck.rb'
require_relative 'Board.rb'

class Game
    attr_accessor :deck, :board, :game, :userInput

    def initialize
        @deck = Deck.new    # type: Deck
        @board = Board.new      # board type: Board
        # @player = Player.new('')
        @userInput = Array.new
        @t1 = 0
        @t2 = 0
        @gameType = 1
        # draw 12 cards from the deck to the board
        @board.lay_cards(@deck, 12)

        until find_set(@board.board)
            @board.add_three_cards
        end
    end

    # def reset!
    #     @started = false
    #     @over = false
    #     @over_at = nil
    #     @paused = false
    #     @score = 0
    # end

    # def start!
    #     @start ||= true
    # end

    # def over!
    #     @over = true
    #     @over_at = Time.now
    # end

    # def pause!
    #     @paused = !paused?
    # end

    # alias paused? paused

    def features_compatible?(feat_1, feat_2, feat_3)
        return ((feat_1 == feat_2) && (feat_2 == feat_3)) || ((feat_1 != feat_2) && (feat_2 != feat_3) && (feat_1 != feat_3))
    end

    # check if the selected 3 cards is a valid set.
    def is_set?(card1, card2, card3)
        number_res = features_compatible?(card1.number, card2.number, card3.number)
        shape_res = features_compatible?(card1.shape, card2.shape, card3.shape)
        color_res = features_compatible?(card1.color, card2.color, card3.color)
        shading_res = features_compatible?(card1.shade, card2.shade, card3.shade)

        if number_res && shape_res && color_res && shading_res
            return true
        else
            return false
        end
    end

    # check the board to find if there is a set
    def find_set(board)
        # get all combinations of three
        combinations = board.combination(3).to_a
        combinations.each do |comb|
            card1, card2, card3 = comb[0], comb[1], comb[2]
            if is_set?(card1, card2, card3)
                return card1, card2, card3
            end
        end
        return nil
    end

    # update the board when the user finds a set
    def update_board
        @board.remove_cards(@userInput)
        unless @deck.is_empty?
            # remain 12 cards on the board
            if @board.length() < 12
                @board.add_three_cards
            end
            # add three more cards when cards on the board don't have a set
            while find_set(@board) == nil && @deck.length > 0
                @board.add_three_cards
            end
        end

        # game is end
        @t2 = Time.now
    end

    # find one of a valid set for a hint
    def find_hint
        booleanChecker = find_set(@board)
        if booleanChecker != nil
        else
        end
    end

    # display to the user that the selected three cards is not a valid set
    def incorrect_message
        puts("Error! This is not a set, please try again.")
    end

end