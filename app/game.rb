require "gosu"
require "pry"

# require all game of life files
Dir["./app/gol/*.rb"].each {|file| require file }

class Game < Gosu::Window
  include Gol

  # overriding att_reader breaks gosu.
  # Sticking with instance variables.

  def initialize(width: 100, height: 100, size: 5)
    @width = width.clamp(0, 1000) # width of cell grid
    @height = height.clamp(0, 1000) # height of cell grid
    @size = size.clamp(3, 100) # size of each cell on viewport

    # calculate game viewport size
    @viewport_width = width * size
    @viewport_height = height * size

    # setup game environment
    @environment = Environment.new(
      width: width,
      height: height
    )

    # populate environment with random
    # population of live cells
    @environment.seed_random

    # setup tick
    @tick = Tick.new(@environment)

    # setup gosu window config
    super @viewport_width, @viewport_height
    self.caption = "Game of Life"
  end

  def update
    # update gets called between every frame updates.
    # Tick applies game logic to environment
    # for next generation of cells.
    @tick.update
  end

  def draw
    # clear previous generation frame with white square
    draw_background

    # draw only living cells for faster view update
    @tick.living_cells.each do |cell|
      draw_square(cell)
    end
  end

  private

  def draw_square(cell)
    draw_rect(
      cell.x * @size,
      cell.y * @size,
      @size,
      @size,
      Gosu::Color::BLACK,
    )
  end

  def draw_background
    draw_rect(
      0,
      0,
      @viewport_width,
      @viewport_height,
      Gosu::Color::WHITE,
    )
  end
end

Game.new(width: 200, height: 200, size: 3).show
