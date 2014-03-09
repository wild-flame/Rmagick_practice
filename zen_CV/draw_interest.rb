require 'RMagick'

include Magick

# INITIALIZE ALL

$MARGIN = [130,130,130,130] #LEFT, TOP, RIGHT, BOTTOM
$BORN_YEAR = 1992

$Titles = ["Development of my Life", "Professional Specialty", "Introduction"] 
#TODO:$Titles = read_title("data.csv")
$Descriptions = ["Lorism"]
#TODO:$Descriptions = read_description("data.csv")

class Event
  attr_accessor :name, :start_year, :end_year, :extent, :place
  def initialize(name, start_year, end_year, extent, place)
    @name = name
    @start_year = start_year
    @end_year = end_year
    @extent = extent
    @place = place
  end
end

def convert_year_to_x_point(year)
  step = 1494 / (2014 - $BORN_YEAR + 1) 
  return xp =  180 + step * (year - 1992)
end

events = [Event.new("Enjoying Life, Travelling, Studying", 1992, 1998, 4, 3)]

# Create the canvas to draw on

canvas = ImageList.new
canvas.new_image(1754, 2480) {
  self.background_color = 'black'
}

# Draw Titles 

title = Draw.new
title.fill('white')
title.stroke('transparent')
title.pointsize(40)
title.font("BS.ttf") 
title.font_weight("bold")
title.font_style(ItalicStyle)
title.text(130,130,$Titles[0])
title.draw(canvas)

# Draw axes

axes = Draw.new
axes.fill_opacity(0)
axes.stroke('white')
axes.stroke_width(1)
axes.stroke_linecap('round')
axes.stroke_linejoin('round')
axes.polyline(130,700, 130 + 1494,700)
axes.draw(canvas)

# Draw Lables
lables = Draw.new
lables.font_weight(NormalWeight)
lables.fill('white')
lables.stroke('transparent')
lables.font_style(ItalicStyle)
lables.pointsize(20)
year = $BORN_YEAR

while year <= 2014 do
  xp = convert_year_to_x_point(year)
  lables.polyline(xp ,700, xp, 700 - 10 )
  if year%2 == 0
    lables.annotate(canvas, 0, 0, xp ,700 + 15 , year.to_s) {
      self.font = "Bauhaus.ttc"
      self.rotation = 45
      self.fill = 'white'
      self.stroke = 'transparent'
      self.pointsize = 16 
    }
  end
  year = year + 1
end
lables.draw(canvas)

# Draw Event 

draw_events = Draw.new
for event in events do
  puts "Drawing event: " + event.name
  # Parameters
  
  xp = convert_year_to_x_point(event.start_year) 
  xp_end = convert_year_to_x_point(event.end_year) 
  # Draw background
  draw_events.stroke("lightblue")
  draw_events.stroke_width(22)
  draw_events.stroke_opacity(0.5)
  draw_events.fill("transparent")
  draw_events.fill_opacity(0)
  draw_events.line(xp+1,470,xp_end,470)

  # Draw start line
  draw_events.stroke_width(1) 
  draw_events.stroke_dasharray(3,2)
  draw_events.line(xp,700,xp,400)
  # Draw end line
  draw_events.line(xp_end,700,xp_end,400)

  # Draw ellipse

  draw_events.stroke("transparent")
  draw_events.stroke_opacity(0.5)
  draw_events.stroke_dasharray()
  draw_events.fill("lightblue")
  draw_events.fill_opacity(0.5)
  r_long = xp_end - xp
  draw_events.ellipse((xp + xp_end)/2, 400, r_long/2, event.extent*40, 180, 0 )

  # Adding text
  draw_events.annotate(canvas, 0, 0, 190 , 475 , event.name) {
    draw_events.stroke = 'none'
    draw_events.font = "Times.dfont"
    draw_events.fill = 'lightblue'
    draw_events.pointsize = 20 
  }
end
draw_events.draw(canvas)

# All in All
canvas.write("CV.jpg")
exec 'open ./CV.jpg'


