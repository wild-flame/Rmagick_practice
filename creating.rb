require 'Rmagick'
include Magick

f = Image.new(100,100) { self.background_color = "blue" }
f.write("figure/creating3.jpg")
exit
