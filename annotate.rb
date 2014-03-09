#! /usr/bin/env ruby

require "RMagick"

include Magick

Text = "FlameWild"

granite = ImageList.new('caption:My caption text')
canvas = ImageList.new
canvas.new_image(300, 100, TextureFill.new(granite))

text = Draw.new
text.font_family = 'Symbol'
text.pointsize = 52 
text.gravity = CenterGravity

text.annotate(canvas, 0,0,2,2, Text) {
  self.fill = 'gray83'
}

text.annotate(canvas, 0,0,-1.5,-1.5,Text) {
  self.fill = 'gray40'
}
text.annotate(canvas, 0,0,0,0,Text) {
  self.fill = 'darkred'
}

canvas.write('myname.gif')
exec "open myname.gif"
exit
