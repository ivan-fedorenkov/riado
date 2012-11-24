#encoding: utf-8

class WebSupport

  def WebSupport.selector(arg)
    case arg 
    when "правой части экрана"
      return "#right"
    when "центральной части экрана"
      return "#center"
    end
  end

end
