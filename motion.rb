#!/usr/bin/env ruby
# coding: utf-8
require 'sdl'

RES_X = 1344
RES_Y = 768
SPRT = 48
MAP_W = RES_X/SPRT
MAP_H = RES_Y/SPRT
MOVE = 1
FRAME_RATE = 5
$tiles = Array.new(16).map{ Array.new(28, 0) }

SDL.init SDL::INIT_VIDEO
screen = SDL::setVideoMode RES_X, RES_Y, 16, SDL::SWSURFACE
SDL::WM.set_caption("Śmieciara","")

truckImg = SDL::Surface.loadBMP "sprites/truck.bmp"
#truckImg.set_color_key( SDL::SRCCOLORKEY || SDL::RLEACCEL, 0)
$truck = truckImg.display_format

carImg = SDL::Surface.loadBMP "sprites/car.bmp"
#carImg.set_color_key( SDL::SRCCOLORKEY || SDL::RLEACCEL, 0)
$car = carImg.display_format

canImg = SDL::Surface.loadBMP "sprites/can.bmp"
canImg.set_color_key( SDL::SRCCOLORKEY || SDL::RLEACCEL, 0)
$canImg = canImg.display_format

buildingImg = SDL::Surface.loadBMP "sprites/building.bmp"
buildingImg.set_color_key( SDL::SRCCOLORKEY || SDL::RLEACCEL, 0)
$buildingImg = buildingImg.display_format


BLACK = screen.format.map_rgb(100, 0, 0)

class Sprite
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
    $tiles[@y][@x] = 1
  end
  def move(dx,dy)
    $tiles[@y][@x] = 0
    @x += dx*MOVE
    if dx > 0 && (@x >= MAP_W || $tiles[@y][@x] == 1)
      @x -= MOVE
    end
    @y += dy*MOVE
    if dy > 0 && (@y >= MAP_H || $tiles[@y][@x] == 1)
      @y -= MOVE
    end
    if dx < 0 && (@x < 0 || $tiles[@y][@x] == 1)
      @x += MOVE
    end
    if dy < 0 && (@y < 0 || $tiles[@y][@x] == 1)
      @y += MOVE
    end
    $tiles[@y][@x] = 1
  end
  def draw(screen)
    #puts "Redrawing sprite"
    SDL::Surface.blit($truck, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

class Car
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
    $tiles[@y][@x] = 1
  end
  def move
    $tiles[@y][@x] = 0
    dir = rand(4)
    #puts dir
    case dir
    when 0
      @y -= MOVE
      if @y < 0 || $tiles[@y][@x] == 1
        @y += MOVE
      end
      $tiles[@y][@x] = 1
    when 1
      @x += MOVE
      if @x >= MAP_W || $tiles[@y][@x] == 1
        @x -= MOVE
      end
      $tiles[@y][@x] = 1
    when 2
      @y += MOVE
      if @y >= MAP_H || $tiles[@y][@x] == 1
        @y -= MOVE
      end
      $tiles[@y][@x] = 1
    when 3
      @x -= MOVE
      if @x < 0 || $tiles[@y][@x] == 1
        @x += MOVE
      end
      $tiles[@y][@x] = 1
    end
  end
  def draw(screen)
    SDL::Surface.blit($car, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

class Thrash
  @@made_of = ["glass", "cardboard", "steel", "zinc", "tin", "plastic"]
  @@color = ["plain", "colorful"]
  @@size = ["small", "average", "big"]
  def initialize()
    @made_of = @@made_of[Random.new.rand(@@made_of.size)]
    @color = @@color[Random.new.rand(@@color.size)]
    @size = @@size[Random.new.rand(@@size.size)]
  end
end

class ThrashCan
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
    @l = []
    Random.new.rand(5..10).times{ @l << Thrash.new }
  end
  def x
    @x
  end
  def y
    @y
  end
  def draw(screen)
    #puts "Redrawing thrash can"
    SDL::Surface.blit($canImg, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

class Building
  #attr_accessor :x :y :can
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
    # @can = ThrashCan.new
  end
  def x
    @x
  end
  def y
    @y
  end
  # def can
  #   @can
  # end
  def draw(screen)
    SDL::Surface.blit($buildingImg, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

#screen render function
def render(cars, buildings, sprite, screen)
  screen.fill_rect(0,0,RES_X,RES_Y,BLACK)

  cars.each do |i|
    i.move
    i.draw(screen)
  end

  buildings.map { |b| b.draw(screen) }

  $thrash_cans.map{ |c| c.draw(screen) }

  sprite.draw(screen)
  screen.updateRect 0,0,0,0
end

#main loop

running = true

#make all objects

buildings = []
$thrash_cans = []
cars = []

Random.new.rand(3..7).times{
  c = ThrashCan.new
  $thrash_cans << c; $tiles[c.y][c.x] = 1 unless $tiles[c.y][c.x] == 1
}
Random.new.rand(20..25).times{
  b = Building.new
  buildings << b; $tiles[b.y][b.x] = 1 unless $tiles[b.y][b.x] == 1
}
Random.new.rand(5..10).times{ cars << Car.new }
sprite = Sprite.new

while running
  @start_time = SDL::getTicks
  dx, dy = 0, 0

  while event = SDL::Event2.poll
    case event
    when SDL::Event2::Quit
      running = false
    when SDL::Event2::KeyDown
      case event.sym
        when SDL::Key::Q
          running = false
        when SDL::Key::UP
          dy = -1
        when SDL::Key::DOWN
          dy = 1
        when SDL::Key::LEFT
          dx = -1
        when SDL::Key::RIGHT
          dx = 1
      end
    end
  end
  sprite.move dx,dy
  # p $tiles.reduce([dx,dy],:+)
  render(cars, buildings, sprite, screen)
  @end_time = SDL::getTicks
  sleep ((1.0/FRAME_RATE) - ((@end_time - @start_time)/100))

end
