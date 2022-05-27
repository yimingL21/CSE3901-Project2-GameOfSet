
class Card
    CARD_WIDTH = 125
    CARD_HEIGHT = 180
    # four attributes of the cards: number, shape, color, shading
    attr_accessor :number, :shape, :color, :shading, :x, :y, :checked
    attr_reader :width, :height

    def initialize(number, shape, color, shading, x , y)
        @number = number
        @shape = shape
        @color = color
        @shading = shading
        @x = x
        @y = y
        @width = CARD_WIDTH
        @height = CARD_HEIGHT
        @checked = false
    end

    # convert a card into string representation
    def card_to_string
        puts "#{@number}, #{@shape}, #{@color}, #{@shading}"
    end

end