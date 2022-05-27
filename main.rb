require 'gosu'

require_relative 'Game'
require_relative 'Button'

class GameScreen < Gosu::Window
    attr_accessor :state
    attr_reader :game

    WINDOW_WIDTH, WINDOW_HEIGHT = 1280, 720

    def initialize
        # init the window
        super WINDOW_WIDTH, WINDOW_HEIGHT, fullscreen: false
        self.caption = "Game of Set"
        @font = Gosu::Font.new(30)
        @font_button = Gosu::Font.new(44)

        # Set up game
		@game = Game.new
        @board = @game.board    # generate the board of beginning 12 cards
        @card_selected = @game.card_selected
        
        @button_hint = Button.new('Hint', 1080, 300, @font_button.text_width("Hint"), @font_button.height)
        @button_restart = Button.new('Restart', 1080, 365, @font_button.text_width("Restart"), @font_button.height)
        @button_pause = Button.new('Pause', 1080, 430, @font_button.text_width("Pause"), @font_button.height)
      
        # start
    end

    # called 60 times per second by default, 
    # and should contain the main game logic, 
    # such as moving objects around, or testing for collisions.
    def update
        @board.update(mouse_x, mouse_y)
        update_buttons
    end

    # called 60 times per second, but may be skipped for performance reasons. 
    # It should contain code to redraw the whole scene, but no game logic.
    def draw
        # draw the game screen
        @board.draw(@card_selected)
        draw_buttons
        draw_messages
    end

     # update the screen when a card is selected && a button is clicked
     def button_down(id)
        if id == Gosu::MsLeft && MouseHoverController.mouse_over_card(mouse_x, mouse_y, @board.board)
            index = MouseHoverController.mouse_over_card(mouse_x, mouse_y, @board.board)
            @game.update_board!(index)
        end
    end 

    def needs_cursor?
        true
    end

    # return the card index that is currently hovered by mouse
    # def mouse_over_card
    #     @board.board.index { |index| MouseHoverController.mouse_over_object?(mouse_x, mouse_y, @board.board[index]) }
    # end

    # Redrawing only when necessary
    # def needs_redraw?
        
    # end

    # start a new game
    def start
    end

    def update_buttons
        @button_hint.update(mouse_x, mouse_y, @button_hint)
        @button_restart.update(mouse_x, mouse_y, @button_restart)
        @button_pause.update(mouse_x, mouse_y, @button_pause)
    end

    def draw_buttons
        @button_hint.draw
        @button_restart.draw
        @button_pause.draw
    end

    def draw_messages
        @font.draw_text("Sets on the board: #{@game.sets_on_board}", 950, 75, 0, 1.0, 1.0, Gosu::Color::BLUE)
        @font.draw_text("Cards remaining: #{@game.deck.deck.length + @board.board.length}", 950, 125, 0, 1.0, 1.0, Gosu::Color::WHITE)
        if @game.set_result == false
            @font.draw_text("This is not a set!", 950, 175, 0, 1.0, 1.0, Gosu::Color::WHITE)
            @font.draw_text("", 950, 175, 0, 1.0, 1.0, Gosu::Color::WHITE) 
        end
    end

end

$window = GameScreen.new
$window.show

