module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		
	  def date_picker(attribute_name, opts={}, locale_format=nil)
	  	draw_ext_input(attribute_name, "datepicker", "mm/dd/yy", nil, locale_format, opts)
	  end

	  def time_picker(attribute_name, opts={}, locale_format=nil)
	  	draw_ext_input(attribute_name, "timepicker", nil, "HH:mm", locale_format, opts)
		end

	  def datetime_picker(attribute_name, opts={}, locale_format=:datetime)
	  	draw_ext_input(attribute_name, "datetimepicker", "mm/dd/yy", "HH:mm", locale_format, opts)
		end

		#TODO: If we can get rid of hard coding locale we don't need this separate method
		# def time_picker_w_seconds(attribute_name, opts={}, locale_format=nil)
	 #  	draw_ext_input(attribute_name, "timepicker", nil, nil, :w_seconds, opts)
		# end

		def hd_label(attribute_name)
			label_tag attribute_name
		end

	  private
	  def draw_ext_input(attribute_name, cls, date_format, time_format, locale_format=nil, opts={})
	  	opts.reverse_merge!(html: {})
	  	value = object.send(attribute_name) if object.respond_to? attribute_name
	  	value = I18n.localize(value, format: locale_format) if value.present?
		  
		  #Set html attribute hash here so :class and :id always get overridden in next lines
		  input_html_options = opts[:html] 
		  input_html_options[:class] = cls 
	  	input_html_options[:id] = attribute_name

	  	input_html_options[:data] ||= {}
	  	input_html_options[:data][:date_format] = (opts[:date_format] || date_format)
	  	input_html_options[:data][:time_format] = (opts[:time_format] || time_format)

	  	input_html_options[:data][:hour_grid] = (opts[:hour_grid] || "23")
	  	input_html_options[:data][:minute_grid] = (opts[:minute_grid] || "59")
	  	input_html_options[:data][:second_grid] = (opts[:second_grid] || "59")
	    
	    text_field_tag("#{attribute_name}", (value || ""), input_html_options) + \
	    self.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt", :id => "#{attribute_name}_hdn" })
	  end

	end
end