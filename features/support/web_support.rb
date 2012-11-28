#encoding: utf-8

module WebSupport

  def WebSupport.selector(arg)
    case arg 
    when "правой части экрана"
      return "#right"
    when "центральной части экрана"
      return "#center"
    when "меню навигации"
      return ".navbar"
    when "нотификаций"
      return "#notifications"
    end  
  end

end

World(WebSupport)
