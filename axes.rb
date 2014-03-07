#!/usr/bin/env ruby

require 'RMagick'

include Magick

canvas = ImageList.new
canvas.new_image(250, 250, Magick::HatchFill.new('white', 'gray90'))

#border
border = Draw.new
border.stroke('thistle') # What does this mean?
border.fill_opacity(0)
border.rectangle(3, 3, canvas.columns-3, canvas.rows-3)
border.draw(canvas)

# Draw gold axes with arrow-heads.
#
axes = Magick::Draw.new
axes.fill_opacity(0)
axes.stroke('gold3')
axes.stroke_width(4)
axes.stroke_linecap('round')
axes.stroke_linejoin('round')
axes.polyline(18,canvas.rows-10, 10, canvas.rows-3, 3,canvas.rows-10,
              10,canvas.rows-10, 10, 10, canvas.columns-10, 10,
              canvas.columns-10, 3, canvas.columns-3, 10, canvas.columns-10, 18)
axes.draw(canvas)

# Draw a red circle which shows the direction of rotation
# Transparent
circle = Draw.new
circle.stroke('tomato')
circle.fill_opacity(0)
circle.stroke_opacity(0.75)
circle.stroke_width(6)
circle.stroke_linecap('round')
circle.stroke_linejoin('round')
circle.ellipse(canvas.rows/2,canvas.columns/2, 80, 80, 0, 315 )
circle.polyline(180,70, 173,78, 190,78, 191,62)
circle.draw(canvas)

# Lable the axes and the circle.
lables = Draw.new
lables.font_weight(NormalWeight)
lables.fill('black')
lables.stroke('transparent')
lables.font_style(ItalicStyle)
lables.pointsize(14)
lables.gravity(NorthWestGravity)
lables.text(20,30, "'0,0'")
lables.gravity(NorthEastGravity)
lables.text(20,30, "'+x'")
lables.gravity(NorthWestGravity)
lables.text(20,230, "'+y'")
lables.gravity(CenterGravity)
lables.text(0,0, "Rotation")
lables.draw(canvas)

canvas.write("axes.gif")
exec 'open axes.gif'
exit
