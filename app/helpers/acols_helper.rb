module AcolsHelper
  
  def highlight_acol_prefix(acol_name)
    if (m = acol_name.match(/^(#{Acol.model_name.human})(.*)$/))
      return ("<strong>#{m[1]}</strong>#{m[2]}").html_safe
    else
      return acol_name
    end
  end
  
  def acol_link_with_bolded_prefix(acol)
    (link_to highlight_acol_prefix(acol.name), acol_path(acol)).html_safe
  end
  
end
