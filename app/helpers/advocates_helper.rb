module AdvocatesHelper
  
  def t_reg_num(advocate)
    
    ("<strong>" +
    t("activerecord.attributes.advocate.reg_num") +
    ":</strong> " + 
    advocate.reg_num).html_safe
    
  end
  
  def t_status(advocate)
    
    ("<strong>" + 
    t("activerecord.attributes.advocate.status") + 
    ":</strong> " + 
    t(Advocate.get_status_values[advocate.status])).html_safe
    
  end
  
end
