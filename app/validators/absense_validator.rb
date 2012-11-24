class AbsenseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value) 
    if ((value.class == Array && !value.empty?) || (value.class != Array && value)) 
      record.errors[attribute] << (options[:message] || "activerecord.errors.messages.present")
    end    
  end  
end