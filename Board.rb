require_relative 'Card.rb'
require_relative 'Deck.rb'
require_relative 'MouseHoverController'

# the board that shows 12 cards
class Board
    CARD_WIDTH = 125
    CARD_HEIGHT = 180
    X = 45
    Y = 25
    X_INDENT = 20
    Y_INDENT = 21
    CHECKED_COLOR = Gosu::Color.argb(0xff_808080)
    SELECTED_COLOR = Gosu::Color.argb(0xff_C0C0C0)

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
        set_card_coord
    end

    # remove three cards (set found) from the board 
    # ! can improve
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

    # set and update the coordinate of the left top corner of the card when needed
    def set_card_coord
        @board.each_with_index do |card, index|
            card.x = X + (index % 6)*(CARD_WIDTH + X_INDENT)
            card.y = Y + (index / 6)*(CARD_HEIGHT + Y_INDENT)
        end
    end

    # draw the board to the screen
    # card_selected move to board
    def draw(card_selected)
        @board_cards = @board    # array of cards of the board
        @board_cards.each_with_index do |card, index|
            card_name = @board_cards[index].number.to_s + @board_cards[index].shape.to_s + @board_cards[index].color.to_s + @board_cards[index].shading.to_s
            card_path = File.dirname(__FILE__) + '/cards/' + card_name + '.png'
            card_image = Gosu::Image.new(card_path)
            Gosu.draw_rect(card.x-8, card.y-8, card.width+16, card.height+16, CHECKED_COLOR) if card.checked
            Gosu.draw_rect(card.x-8, card.y-8, card.width+16, card.height+16, SELECTED_COLOR) if card_selected.include?(index)
            card_image.draw(card.x, card.y, 1, 1)
        end
        # highlight the card when the cursor is over the card
        # draw_quad
    end

    def draw_quad(x, y, color)
        $window.draw_quad(x, y, color,
                          x + CARD_WIDTH, y, color,
                          x + CARD_WIDTH, y + CARD_HEIGHT, color,
                          x, y + CARD_HEIGHT, color)
    end

    # highlight the card when the mouse is over the card
    def update(mouse_x, mouse_y)
        @color = Gosu::Color::BLACK
        @board.each_with_index do |card, index|
            if MouseHoverController.mouse_over_object?(mouse_x, mouse_y, card)
                card.checked = true
            else
                card.checked = false
            end
        end
    end

    # return the index of the card (another option: card option) that is hovered by mouse
    def get_mouse_over_card(mouse_x, mouse_y)
        @board.each do |card|
            MouseHoverController.mouse_over_object(mouse_x, mouse_y, card)
        end
    end
    
end