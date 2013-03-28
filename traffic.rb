module TL
  Go = "#00FF30"
  Wait = "#FFFC00"
  Stop = "#FF0000"
end

class TrafficLight  
  include Enumerable #gives a whole bunch of methods, what does it mean to "each state in a traffic light"
  include TL

  def each
    yield TL::Go [true, false, false] #toggles the which lights are on
    yield [true, true, false]  #A truth table
    yield [false, false, true]
    yield [false, true, false]
  end
end

class Bulb < Shoes::Shape #Inheriting from the module "Shoes", inheriting from "shape" class, part of the module
  attr_accessor :stack
  attr_accessor :left
  attr_accessor :top
  attr_accessor :switched_on
  
  def initialize(stack, left, top, switched_on = false)    #default assignment to
    self.stack = stack
    self.left = left    
    self.top = top
    self.switched_on = switched_on
    draw left, top, bulb_colour
  end
  
  # HINT: Shouldn't need to change this method, draws the shape
  def draw(left, top, colour)    
    stack.app do
      fill colour
      stack.append do
        oval left, top, 50
      end
    end
  end
  
  def bulb_colour # update this string to color in the bulbs
    "#999999"
  end  
end

class GoBulb < Bulb
  def bulb_colour
    TL::Go
  end
end

class WaitBulb < Bulb
  def bulb_colour
    TL::Wait  
  end  
end

class StopBulb < Bulb
  def bulb_colour
    TL::Stop
  end  
end

Shoes.app :title => "My Amazing Traffic Light", :width => 150, :height => 250 do
  background "000", :curve => 10, :margin => 25  
  stroke black    
  
  @traffic_light = TrafficLight.new
  @top = StopBulb.new self, 50, 40, false     #instantiating three objects of type bold
  @middle = Bulb.new self, 50, 100, true # numbers are for positioning
  @bottom = Bulb.new self, 50, 160, true
  
  click do #anytime shoes detects a click anywhere on the traffic light, I'll give you a chance to do something
    
    #@top = StopBulb.new self, 50, 40, false # Need to assign the each method's Boolean to switch the correct bulbs
    # @middle = WaitBulb.new self, 50, 100, false
    # @bottom = GoBulb.new self, 50, 160, false

  end
end
