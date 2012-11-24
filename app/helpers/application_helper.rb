module ApplicationHelper
  @@flash_classes =
    {:notice  => 'alert-info',
     :alert   => 'alert-error',
     :success => 'alert-success'}

  def flash_class_for(key)
    @@flash_classes[key]
  end
  
  def t_info_review_date(datetime, format={})
    if(format.empty?)
      time_string = default_time_tag(datetime)
    else
      time_string = default_time_tag(datetime, format)
    end

    ("<strong>" +
    t("activerecord.attributes.updated_at") +
    "</strong>: " +
    time_string).html_safe
  end
  
  def default_time_tag(datetime, format={:format => "%-d %B %Y"})
    time_tag(datetime, format)
  end

end
