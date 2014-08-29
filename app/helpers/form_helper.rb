module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		
	  def date_picker(attribute_name)
			value = object.send(attribute_name) if object.respond_to? attribute_name
	  	input_html_options = {}
	  	value = I18n.localize(value) if value.present?
	  	input_html_options[:class] = "datepicker"
	    text_field_tag("#{attribute_name}_vis", (value || ""), input_html_options) + \
	    self.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt" })
	  end

	  def time_picker(attribute_name)
			value = object.send(attribute_name) if object.respond_to? attribute_name
	  	input_html_options = {}
	  	value = I18n.localize(value) if value.present?
	  	input_html_options[:class] = "timepicker"
	    text_field_tag("#{attribute_name}_vis", (value || ""), input_html_options) + \
	    self.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt" })
	  end

	  def datetime_picker(attribute_name)
			value = object.send(attribute_name) if object.respond_to? attribute_name
	  	input_html_options = {}
	  	value = I18n.localize(value, :format => :datetime) if value.present?
	  	input_html_options[:class] = "datetimepicker"
	    text_field_tag("#{attribute_name}_vis", (value || ""), input_html_options) + \
	    self.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt" })
	  end

	  #TODO: DRY This up with a private method
	  
	end
end