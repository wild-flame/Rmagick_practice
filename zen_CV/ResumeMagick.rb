require 'RMagick'

include Magick

MARGIN = [130,130,130,130]

Title = ["Development of my Interest", "Professional Specialty", "Introduction"] 
Description = ["Lorism"]

# Create the canvas to draw on

canvas = ImageList.new
canvas.new_image(1754, 2480) {
  self.background_color = 'black'
}

# Draw Titles 

title = Draw.new
title.fill('white')
title.stroke('transparent')
title.pointsize(30)
title.font("BS.ttf") 
title.font_weight("bold")
title.font_style(ItalicStyle)
title.text(130,130,Title[0])
title.text(130,700,Title[1])
title.text(130,1230,Title[2])
title.draw(canvas)

# Draw axes

axes = Draw.new
axes.fill_opacity(0)
axes.stroke('white')
axes.stroke_width(1)
axes.stroke_linecap('round')
axes.stroke_linejoin('round')
axes.polyline(130,600, 1494,600)
axes.draw(canvas)

# Draw Lables

canvas.write("CV.jpg")
exec 'open ./CV.jpg'


title.text(130,430,Title[1])
