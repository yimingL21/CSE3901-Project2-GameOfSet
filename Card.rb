
class Card

    # four attributes of the cards: number, shape, color, shading
    attr_accessor :number, :shape, :color, :shading

    def initialize(number, shape, color, shading)
        @number = number
        @shape = shape
        @color = color
        @shading = shading
    end

    # convert a card into string representation
    def card_to_string
        puts "#{@number}, #{@shape}, #{@color}, #{@shading}"
    end

end