module Doubles
  def id_double
    double("identifier")
  end
  
  def name_double
    double("name")
  end
end

RSpec.configure do |config|
  config.include Doubles
end
