module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Family Connect"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("tree.gif", :alt => "Family Connect", :class => "round")
  end
end