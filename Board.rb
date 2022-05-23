require_relative 'Card.rb'
require_relative 'Deck.rb'

# the board that shows 12 cards
class Board
    
    attr_accessor :board

    def initialize
        @board = Array.new
    end

   # lay out 12 cards on the board
    def lay_cards(deck, n)
        # shuffle the deck
        deck.deck.shuffle!
        # draw 12 cards from the deck to the board
        n.times {draw_card(deck)}
    end

    # remove three cards (set found) from the board 
    def remove_cards(userInput)
        @board -= userInput
    end

    # draw one card from the deck to the board
    def draw_card(deck)
        @board << deck.remove_card
    end

    # add three more cards from deck to the board if there isn't a valid set on the board
    def add_three_cards(deck)
        if deck.length() > 0
            3.times {draw_card(deck)}
        end
    end

end