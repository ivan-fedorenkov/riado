module ApplicationHelper
  
  @@flash_classes =
    {:notice  => 'alert-info',
     :alert   => 'alert-error'}

  def flash_class_for(key)
    @@flash_classes[key]
  end
  
  
  def strong_label_and_content_html_safe(label, content)
    (content_tag(:strong, label + ": ") + content).html_safe
  end
  
  def t_info_review_date(datetime, format={})
    if(format.empty?)
      time_string = default_time_tag(datetime)
    else
      time_string = default_time_tag(datetime, format)
    end
  
    strong_label_and_content_html_safe(
      t("activerecord.attributes.updated_at"),
      time_string)

  end
  
  def default_time_tag(datetime, format={:format => "%-d %B %Y"})
    time_tag(datetime, format)
  end
  
end
