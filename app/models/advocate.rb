class Advocate < ActiveRecord::Base
  
  belongs_to :acol
  belongs_to :advocatory_formation
  
  # Advocate statuses enum (Symbolize library)
  symbolize :status, :in => [:active, :suspended, :stopped, :removed]
  symbolize :sex, :in => [:male, :female, nil]
  
  validates :reg_num, :format => { :with => /\d+\/\d+/ }
  validates :reg_num, :presence => true
  validates :reg_num, :uniqueness => true

  validates :acol, :presence => true
 
  
  
private 
  
  # Prevent the changes of advocatory formation from advocate model,
  # since there is complex validation logic that based on formation form
  def advocatory_formation=
  end
  def advocatory_formation_id=
  end
  
end
