class Region < ActiveRecord::Base

  has_one :acol, :dependent => :nullify
  
  validates :name, :presence => true

  def to_s
    self.name
  end

  def self.default
    self.where(:default => true).first
  end

end
