module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		
	  def hd_picker(attr, opts={}, locale_format=nil, cls=nil)
	  	col_type = object.class.columns_hash[attr.to_s].type
	  	#Picker css class...if not explicitly specified get it from the type
	  	cls ||= col_type.to_s + "picker" 
	  	#need to specify datetime in locale file because rails thinks datetime is time
	  	locale_format ||= :datetime if col_type == :datetime
	  	draw_ext_input(attr, cls, locale_format, opts)
	  end
	
		def hd_label(name = nil, content_or_options = nil, options = nil, &block)
			label_tag name, content_or_options, options, &block
		end

	  private
	  def draw_ext_input(attr, cls, locale_format=nil, opts={})
	  	opts.reverse_merge!(html: {})
	  	value = object.send(attr) if object.respond_to? attr
	  	value = I18n.localize(value, format: locale_format) if value.present?
		  
		  #Set html attribute hash here so :class and :id always get overridden in next lines
		  input_attrs = opts[:html] 
		  input_attrs[:class] = (input_attrs.fetch(:class, "").split(" ") << cls).join(" ")
	  	input_attrs[:id] = attr

	  	opts[:hd_opts] ||= {}
	  	opts[:data] ||= {}
	  	input_attrs[:data] = opts[:hd_opts].merge(opts[:data])

	  	hd_config = HotDateRails.config
	  	#date_format & time_format are the only options that can be passed in at the top level of opts
	  	input_attrs[:data][:date_format] = (opts[:date_format] || hd_config.date_format)
	  	input_attrs[:data][:time_format] = (opts[:time_format] || hd_config.time_format)
	  	
	  	#Time grids have default values set in config/initializers/hot_date_rails.rb
	  	input_attrs[:data][:hour_grid]   ||= hd_config.hour_grid
	  	input_attrs[:data][:minute_grid] ||= hd_config.minute_grid
	  	input_attrs[:data][:second_grid] ||= hd_config.second_grid
	    
	    text_field_tag("#{attr}", (value || ""), input_attrs) + \
	    self.hidden_field(attr, { :class => attr.to_s + "-alt", :id => "#{attr}_hdn" })
	  end

	end
end