#!/usr/bin/env ruby
require 'sdl'

RES_X = 1280
RES_Y = 768
SPRT = 48
MAP_W = RES_X/SPRT
MAP_H = RES_Y/SPRT
MOVE = 48

SDL.init SDL::INIT_VIDEO
screen = SDL::setVideoMode RES_X, RES_Y, 16, SDL::SWSURFACE
image = SDL::Surface.loadBMP "icon.bmp"

@x = 0
@y = 0

def move
  if SDL::Key.press?(SDL::Key::RIGHT)
    @x += MOVE 
  end
  if SDL::Key.press?(SDL::Key::DOWN)
    @y += MOVE
  end
  if SDL::Key.press?(SDL::Key::LEFT)
    @x -= MOVE
  end
  if SDL::Key.press?(SDL::Key::UP)
    @y -= MOVE
  end
end

#main loop

running = true

while running
  while event = SDL::Event2.poll
    case event
    when SDL::Event2::Quit
      running false
    end
    SDL::Key.scan
    screen.fillRect 0, 0, MAP_W, MAP_H, 0
    move
    screen.put image, @x, @y
    screen.updateRect 0,0,0,0
  end
end
