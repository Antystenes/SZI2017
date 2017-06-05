#!/usr/bin/env ruby

require 'sdl'

SDL.init SDL::INIT_VIDEO

SPRITE_WIDTH = 48
SPRITE_LENGTH = 48
RESOLUTION_X = 1280
RESOLUTION_Y = 768
MAP_W = RESOLUTION_X/SPRITE_WIDTH
MAP_H = RESOLUTION_Y/SPRITE_LENGTH

screen = SDL::set_video_mode RESOLUTION_X, RESOLUTION_Y, 24, SDL::SWSURFACE

BGCOLOR = screen.format.mapRGB 0,0,0
LINECOLOR = screen.format.mapRGB 255,255,255

/if subsystem_init & SDL::INIT_VIDEO
  puts "video is initialized"
else
  puts "video is not initialized"
end/

class Sprite
  def initialize
    @x=rand(MAP_W)
    @y=rand(MAP_H)
  end

  def move(dx, dy)
    @x += dx
    @y += dy
    if @x >= MAP_W then
      dx *= -1
      @x = 1279
    end
    if x < 0 then
      dx *= -1
      @x = 0
    end
    if @y >= MAP_Y then
      dy *= -1
      @y = 767
    end
  end
  
  def draw(screen)
    SDL.blitSurface($image, 0,0,SPRITE_WIDTH,SPRITE_LENGTH,screen,@x*SPRITE_WIDTH,@y*SPRITE_LENGTH)
  end
end

sprites = []
for i in 1..5
  sprites << Sprite.new
end
/sprites << MovableSp.new/

running = true

while running
  while event = SDL::Event2.poll
    case event
    when SDL::Event2::Quit
      running = false
    when SDL::Event::MouseMotion
      x = event.x
      y = event.y
    end
  end
  screen.fill_rect 0, 0, 640, 480, BGCOLOR
  screen.draw_line x, 0, x, 479, LINECOLOR
  screen.draw_line 0, y, 639, y, LINECOLOR
  screen.flip
end
