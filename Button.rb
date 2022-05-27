require_relative 'MouseHoverController'

class Button

    attr_accessor :text, :x, :y, :width, :height
    def initialize(text, x, y, width, height)
        @font = Gosu::Font.new(44)

        @text = text
        @x = x - @font.text_width(@text.to_s) / 2   # define the x coordinate of the left top corner of the button
        @y = y
        @width = width
        @height = height
        
    end

    def draw
        @font.draw_text(@text, @x, @y + @option, 10, 1.0, 1.0, @color)
    end

    # draws the button in the screen
    # def draw_button 
    #     if @state == :button_down
    # end

    # update the button, checking the mouse movement and buttons to define the button state 
    def update(mouse_x, mouse_y, object)
        if MouseHoverController.mouse_over_object?(mouse_x, mouse_y, object)
            @color = Gosu::Color::WHITE
            @option = 2.5
        else
            @color = Gosu::Color::CYAN
            @option = 0
        end
    end

end
