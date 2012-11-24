class Acol < ActiveRecord::Base
  belongs_to :region
  has_many :advocates, :dependent => :nullify
  has_many :advocatory_formations, :dependent => :nullify
  
  validates :name, :presence => true
  
  def to_s
    self.name
  end
end
