module AdvocatoryFormationsHelper
  def t_form(advocatory_formation)
    strong_label_and_content_html_safe(
      t("activerecord.attributes.advocatory_formation.form"),  
      t(AdvocatoryFormation.get_form_values[advocatory_formation.form]))
  end
end
