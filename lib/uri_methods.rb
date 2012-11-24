class String 
  def to_uri
    gsub('\s','_')
  end

  def from_uri
    gsub('_',' ')
  end
end
