module FormHelper
	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		extend HotDateRails::Utils
		
		deprecate :date_picker, :hd_picker
		deprecate :time_picker, :hd_picker
		deprecate :datetime_picker, :hd_picker
		
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
	  	value = object.send(attr) if object.respond_to? attr
	  	value = I18n.localize(value, format: locale_format) if value.present?
		  input_attrs = InputAttrs.new(attr, cls, opts)
	    text_field_tag("#{attr}", (value || ""), input_attrs) + \
	    self.hidden_field(attr, { :class => attr.to_s + "-alt", :id => "#{attr}_hdn" })
	  end

	end

	class InputAttrs < Hash
		def initialize(attr, hd_cls, opts={})
			opts.reverse_merge!(html: {})
			#Set html attribute hash here so :class and :id always get overridden in next lines
		  self.merge! opts[:html] 
		  self[:class] = (self.fetch(:class, "").split(" ") << hd_cls).join(" ")
	  	self[:id] = attr
			opts[:hd_opts] ||= {}
	  	opts[:data] ||= {}
	  	data = opts[:hd_opts].merge(opts[:data])
			hd_config = HotDateRails.config
	  	#date_format & time_format are the only options that can be passed in at the top level of opts
	  	data[:date_format] = (opts[:date_format] || hd_config.date_format)
	  	data[:time_format] = (opts[:time_format] || hd_config.time_format)
	  	#Time grids have default values set in config/initializers/hot_date_rails.rb
	  	data[:hour_grid]   ||= hd_config.hour_grid
	  	data[:minute_grid] ||= hd_config.minute_grid
	  	data[:second_grid] ||= hd_config.second_grid
	  	self[:data] = data
		end
	end
end