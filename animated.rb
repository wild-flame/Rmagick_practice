require 'RMagick'

include Magick

anim = ImageList.new("figure/creating.jpg","figure/creating2.jpg","figure/creating3.jpg")
anim.write("figure/animated.gif")

exit
