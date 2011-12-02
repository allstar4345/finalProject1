module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Kays App", :class => "round")
  end
end