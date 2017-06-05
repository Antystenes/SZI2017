#!/usr/bin/env ruby
# coding: utf-8
require 'sdl'

RES_X = 1344
RES_Y = 768
SPRT = 48
MAP_W = RES_X/SPRT
MAP_H = RES_Y/SPRT
MOVE = 1

SDL.init SDL::INIT_VIDEO
screen = SDL::setVideoMode RES_X, RES_Y, 16, SDL::SWSURFACE
SDL::WM.set_caption("Śmieciara","")

truck = SDL::Surface.loadBMP "sprites/truck.bmp"
truck.set_color_key( SDL::SRCCOLORKEY || SDL::RLEACCEL, 0)
$truck = truck.display_format

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
  end
  
  def move
    if SDL::Key.press?(SDL::Key::RIGHT)
      @x += MOVE
      if @x >= MAP_W
        @x = MAP_W - MOVE
      end
    end
    if SDL::Key.press?(SDL::Key::DOWN)
      @y += MOVE
      if @y >= MAP_H
        @y = MAP_H - MOVE
      end
    end
    if SDL::Key.press?(SDL::Key::LEFT)
      @x -= MOVE
      if @x <= 0
        @x += MOVE
      end
    end
    if SDL::Key.press?(SDL::Key::UP)
      @y -= MOVE
      if @y < 0
        @y += MOVE
      end
    end
  end 
  def draw(screen)
    #puts "Redrawing sprite"
    SDL::Surface.blit($truck, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
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
  def draw(screen)
    #puts "Redrawing thrash can"
    SDL::Surface.blit($canImg, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

class Building
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
  end
  def draw(screen)
    SDL::Surface.blit($buildingImg, 0, 0, SPRT, SPRT, screen, @x*SPRT, @y*SPRT)
  end
end

#screen render function
def render(buildings, can, sprite, screen)
  screen.fill_rect(0,0,RES_X,RES_Y,BLACK)

  buildings.each do |i|
    i.draw(screen)
  end
  can.each do |i|
    i.draw(screen)
  end
  sprite.draw(screen)
  screen.updateRect 0,0,0,0
end

#main loop

running = true 

#make all objects

buildings = []
can = []

Random.new.rand(5..10).times{ buildings << Building.new }
Random.new.rand(5..10).times{ can << ThrashCan.new }
sprite = Sprite.new


while running
  while event = SDL::Event2.poll
    case event
    when SDL::Event2::Quit
      running false
    end
   
    #
    SDL::Key.scan
    sprite.move
    render(buildings, can, sprite, screen)
    #
  end
end
