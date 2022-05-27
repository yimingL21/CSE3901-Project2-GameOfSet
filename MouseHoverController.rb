
class MouseHoverController

    # highlight the card when the mouse is over the card
    def update
    end

    # detect which object is the cursor over
    def self.mouse_over_object?(mouse_x, mouse_y, object)
        return mouse_x.between?(object.x, object.x + object.width) && mouse_y.between?(object.y, object.y + object.height)
    end

    def self.mouse_over_card(mouse_x, mouse_y, board)
        board.each_with_index do |card, index|
            return index if mouse_over_object?(mouse_x, mouse_y, card)
        end
    end
end