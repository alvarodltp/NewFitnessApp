module ApplicationHelper

  def copyright_generator
    AlvaroDeLaTorreViewTool::Renderer.copyright 'Alvaro De La Torre', 'All rights reserved'
  end
end
