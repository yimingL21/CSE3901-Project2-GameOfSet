require_relative 'Deck.rb'
require_relative 'Board.rb'
require_relative 'Utils'

class Game
    attr_accessor :deck, :board, :game, :card_selected, :set_result, :game_over

    def initialize
        @t1 = 0
        @t2 = 0
        # add three more cards if the board doesn't have a set
        # until find_set(@board.board)
        #     @board.add_three_cards
        # end
        start!
    end

    def start!
        @deck = Deck.new    # type: Deck
        @board = Board.new      # board type: Board
        # draw 12 cards from the deck to the board
        @board.lay_cards(@deck, 12)
        add_til_set
        # array of cards selected by the user
        @card_selected = Array.new
        # result of checking if three cards make a set
        @set_result = false
        @game_over = false
    end

    # add more cards to the board until there is at least one set
    # if it succeeds, return true. Otherwise, return false(game over)
    def add_til_set
        while !has_set? || @deck.is_empty? do
            @board.add_three_cards @deck
        end
        return !has_set?
    end

    # detect the condition that the three features are all the same or all the different
    def features_compatible?(feat_1, feat_2, feat_3)
        return ((feat_1 == feat_2) && (feat_2 == feat_3)) || ((feat_1 != feat_2) && (feat_2 != feat_3) && (feat_1 != feat_3))
    end

    # check if the selected 3 cards is a valid set.
    def is_set?(card1, card2, card3)
        number_res = features_compatible?(card1.number, card2.number, card3.number)
        shape_res = features_compatible?(card1.shape, card2.shape, card3.shape)
        color_res = features_compatible?(card1.color, card2.color, card3.color)
        shading_res = features_compatible?(card1.shading, card2.shading, card3.shading)

        if number_res && shape_res && color_res && shading_res
            return true
        else
            return false
        end
    end

    # check the board to find if there is a set
    def has_set?
        # get all combinations of three
        combinations = @board.board.combination(3).to_a
        combinations.each do |comb|
            card1, card2, card3 = comb[0], comb[1], comb[2]
            if is_set?(card1, card2, card3)
                return true
            end
        end
        return false
    end

    # update the board when a card is being selected by the user
    def update_board!(index)
        if @card_selected.include?(index)
            @card_selected.delete(index)
        elsif @card_selected.length < 3
            # store the card index
            @card_selected.push(index)
            # when three cards are selected
            if @card_selected.length == 3
                check_set!(@card_selected)
            end
        end
    end

    # check if the three selected cards can make a set.
    # If they are a set, replace them with three new cards. 
    def check_set!(triple)
        three_cards = triple.map { |index| @board.board[index] }
        # when the three cards make a set
        if is_set?(three_cards[0], three_cards[1], three_cards[2])
            @set_result = true
            @card_selected.clear
            @board.remove_cards(three_cards)
            # add three more cards to the board
            @board.add_three_cards
            # set the coordinates of the board when the board is changed
            @board.set_card_coord
            # check if the game is over when the deck is empty
            if @deck.is_empty?
                @game_over = true if !has_set?
            end
        else
            @set_result = false
            @card_selected.clear
        end
    end

    # count number of sets on the board
    def sets_on_board
        num = 0
        if has_set?
            num += 1
        end
        
        return num
    end

    # find one of a valid set for a hint
    def find_hint
        booleanChecker = find_set(@board)
        if booleanChecker != false
        else
        end
    end

    # display to the user that the selected three cards is not a valid set
    def incorrect_message
        puts("Error! This is not a set, please try again.")
    end

end