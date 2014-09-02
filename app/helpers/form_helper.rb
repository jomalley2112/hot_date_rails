module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		
	  def date_picker(attribute_name, *args)
	  	draw_ext_input(attribute_name, "datepicker", "mm/dd/yy", nil, nil, *args)
	  end

	  def time_picker(attribute_name, *args)
	  	draw_ext_input(attribute_name, "timepicker", nil, "HH:mm", nil, *args)
		end

	  def datetime_picker(attribute_name, *args)
	  	#datetime_picker(:attr, { :date_format => "mm/dd/yy", :time_format => "HH:mm", :html => {} })
	  	draw_ext_input(attribute_name, "datetimepicker", "mm/dd/yy", "HH:mm", :datetime, *args)
		end

		

		def time_picker_w_seconds(attribute_name, *args)
	  	draw_ext_input(attribute_name, "timepicker", nil, "HH:mm:ss", :w_seconds, *args)
		end

		# def timepicker_w_locale(attribute_name, locale_format, *args)
			
		# end




		def hd_label(attribute_name)
			label_tag attribute_name
		end

	  private
	  def draw_ext_input(attribute_name, cls, date_format, time_format, locale_format=nil, *args)
	  	opts = args.extract_options!
	  	opts.reverse_merge!(html: {})
	  	value = object.send(attribute_name) if object.respond_to? attribute_name
	  	input_html_options = {}
	  	value = I18n.localize(value, format: locale_format) if value.present?
		  input_html_options[:class] = cls
	  	input_html_options[:id] = attribute_name
	  	input_html_options[:data] ||= {}
	  	input_html_options[:data][:date_format] = (opts[:date_format] || date_format)
	  	input_html_options[:data][:time_format] = (opts[:time_format] || time_format)
	    text_field_tag("#{attribute_name}", (value || ""), input_html_options) + \
	    self.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt", :id => "#{attribute_name}_hdn" })
	  end

	end
end