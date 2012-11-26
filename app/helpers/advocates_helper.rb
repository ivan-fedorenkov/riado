module AdvocatesHelper
  
  def t_reg_num(advocate)
    
    strong_label_and_content_html_safe(
      t("activerecord.attributes.advocate.reg_num"),
      advocate.reg_num)
    
  end
  
  def t_status(advocate)
    strong_label_and_content_html_safe(
      t("activerecord.attributes.advocate.status"),
      t(Advocate.get_status_values[advocate.status]))
  end
  
end
