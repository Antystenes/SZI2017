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
$image = image.display_format

class Sprite
  def initialize
    @x = rand MAP_W
    @y = rand MAP_H
  end
  
  def move
    if SDL::Key.press?(SDL::Key::RIGHT)
      @x += MOVE
      #if @x >= RES_X
      #  @x = RES_X - 1
      #end
    end
    if SDL::Key.press?(SDL::Key::DOWN)
      @y += MOVE
      #if @y >= RES_Y
      #  @y = RES_Y - 1 
      #end
    end
    if SDL::Key.press?(SDL::Key::LEFT)
      @x -= MOVE
      #if @x < 0
      #  @x += 0
      #end
    end
    if SDL::Key.press?(SDL::Key::UP)
      @y -= MOVE
      #if @y < 0
      #  @y += 0
      #end
    end
  end

  def draw(screen)
    SDL::Surface.blit($image, 0, 0, SPRT, SPRT, screen, @x, @y)
  end
end

class MovableSprite
  def initialize()
    @ud=@lr=0;
  end
  
  def move()
    #@ud=@lr=0;
    @lr-=1 if SDL::Key.press?(SDL::Key::H) or SDL::Key.press?(SDL::Key::LEFT)
    @lr+=1  if SDL::Key.press?(SDL::Key::L) or SDL::Key.press?(SDL::Key::RIGHT)
    @ud+=1  if SDL::Key.press?(SDL::Key::J) or SDL::Key.press?(SDL::Key::DOWN)
    @ud-=1 if SDL::Key.press?(SDL::Key::K) or SDL::Key.press?(SDL::Key::UP)
  end
  
  def draw(screen)
    SDL::Surface.blit($image,0,0,32,32,screen,300+@lr*50,200+@ud*50)
  end
end

#main loop

running = true

#sprites = []
#
#for i in 1..5
 # sprites << Sprite.new
#end

sprite = Sprite.new

while running
  while event = SDL::Event2.poll
    case event
    when SDL::Event2::Quit
      running false
    end
    SDL::Key.scan
    #sprites.each {|i|
    #  i.move
    #  i.draw(screen)
    #}
    sprite.move
    sprite.draw(screen)
    screen.updateRect 0,0,0,0
  end
end
