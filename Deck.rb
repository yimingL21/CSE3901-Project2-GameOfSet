# class that generate a deck object holding 81 cards
require_relative 'Card.rb'

class Deck
    
    attr_accessor :deck

    def initialize
        @deck = Array.new
        
        numbers = ['1','2','3']     # One, Two, or Three shapes
        shapes = ['t','s','o']      # Triangle, Square, Oval
        colors = ['r','g','b']      # Red, Green, Blue
        shading = ['s','e','v']     # Solid, Empty, Vertical

        numbers.each do |number|
            shapes.each do |shape|
                colors.each do |color|
                    shading.each do |shade|
                        card = Card.new(number, shape, color, shade, 0, 0)
                        @deck << card
                    end
                end
            end
        end
    end

    def length
        return @deck.length()
    end

    def is_empty?
        return @deck.length() == 0
    end

    # remove a card from the deck
    def remove_card
        return @deck.shift
    end

    def deck_to_string
        @deck_string = Array.new
        for card in @deck
            @deck_string << card.card_to_string
        end
        return @deck_string
    end

end
