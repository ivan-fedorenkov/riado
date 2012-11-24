module AdvocatoryFormationsHelper
  def t_form(advocatory_formation)
    ("<strong>" + 
      t("activerecord.attributes.advocatory_formation.form") +
      ":</strong> " + 
      t(AdvocatoryFormation.get_form_values[advocatory_formation.form])).html_safe
  end
end
