class AdvocatoryFormation < ActiveRecord::Base
  
  # Each advocatory formation belongs to advocatory chamber of loyers
  belongs_to :acol
  
  # Each advocatory formation with college form can have fililas
  has_many :filials, :class_name => "AdvocatoryFormation", :foreign_key => "head_department_id", :dependent => :nullify
  belongs_to :head_department, :class_name => "AdvocatoryFormation"
  
  # Each advocatory formation can have advocates
  has_many :advocates, :dependent => :nullify
  
  # Forms are restricted to the following values
  symbolize :form, :in => 
    {:college => 'activerecord.attributes.advocatory_formation.forms.college',
     :bureau => 'activerecord.attributes.advocatory_formation.forms.bureau',
     :consultation => 'activerecord.attributes.advocatory_formation.forms.consultation',
     :cabinet => 'activerecord.attributes.advocatory_formation.forms.cabinet'}
  validates :name, :presence => true
  
  # Validators for advocatory formations that are not college
  # Formations can't have filials and head departments, except for colleges
  with_options :unless => :college? do |options|
    
    options.validates :filials,
      :absense => {:message => "activerecord.errors.models.advocatory_formation.attributes.filials.present"}
    options.validates :head_department,
      :absense => {:message => "activerecord.errors.models.advocatory_formation.attributes.filials.present"}
      
  end
  
  # Validates that advocate cabinet has a maximum of one advocate
  validate :cabinet_should_have_maximum_one_advocate
  
  validates :acol, :presence => true
  
  
  def to_s
    self.name
  end
  
private

  def college?
    self.form == :college ? true : false
  end
  
  def cabinet?
    self.form == :cabinet ? true : false
  end
  
  def cabinet_should_have_maximum_one_advocate
    if self.form == :cabinet && self.advocates.length > 1
      errors.add(:advocates, "activerecord.errors.models.advocatory_formation.attributes.advocates.count")
    end
  end
  
end
