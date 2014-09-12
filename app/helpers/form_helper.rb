module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		
	  def date_picker(attr, opts={}, locale_format=nil)
	  	draw_ext_input(attr, "datepicker", "mm/dd/yy", "", locale_format, opts)
	  end

	  def time_picker(attr, opts={}, locale_format=nil)
	  	draw_ext_input(attr, "timepicker", "", "HH:mm", locale_format, opts)
		end

	  def datetime_picker(attr, opts={}, locale_format=:datetime)
	  	draw_ext_input(attr, "datetimepicker", "mm/dd/yy", "HH:mm", locale_format, opts)
		end

		
		def hd_label(attr)
			label_tag attr
		end

	  private
	  def draw_ext_input(attr, cls, date_format, time_format, locale_format=nil, opts={})
	  	#binding.pry
	  	opts.reverse_merge!(html: {})
	  	value = object.send(attr) if object.respond_to? attr
	  	value = I18n.localize(value, format: locale_format) if value.present?
		  
		  #Set html attribute hash here so :class and :id always get overridden in next lines
		  input_attrs = opts[:html] 
		  input_attrs[:class] = cls 
	  	input_attrs[:id] = attr
	  	#binding.pry
	  	input_attrs[:data] = opts[:data] ||= {}
	  	#date_format & time_format are the only options that can be passed in at the top level of opts
	  	input_attrs[:data][:date_format] = (opts[:date_format] || date_format)
	  	input_attrs[:data][:time_format] = (opts[:time_format] || time_format)
	  	
	  	input_attrs[:data][:hour_grid]   ||= "23"
	  	input_attrs[:data][:minute_grid] ||= "59"
	  	input_attrs[:data][:second_grid] ||= "59"
	    
	    text_field_tag("#{attr}", (value || ""), input_attrs) + \
	    self.hidden_field(attr, { :class => attr.to_s + "-alt", :id => "#{attr}_hdn" })
	  end

	end
end