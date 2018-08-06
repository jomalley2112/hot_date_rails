module FormHelper
	
	module ActionView::Helpers::FormTagHelper
		#for when there's no rails form object and you really just need inputs
		def hd_picker_tag(field_name, value=nil, cls="datepicker", opts={}, locale_format=nil)
	  	draw_ext_input_tag(field_name, value, cls, locale_format, opts)
	  end

	  private
	  def draw_ext_input_tag(field_name, value, cls, locale_format=nil, opts={})
	  	formatted_value = I18n.l(value.to_date) if value.present?
	  	input_attrs = InputAttrs.new(field_name, cls, opts)
	  	text_field_tag("#{field_name}", formatted_value, input_attrs.to_h) + \
	    hidden_field_tag(field_name, nil, { :class => field_name.to_s + "-alt", :id => "#{field_name}_hdn", value: value })
	  end
	end

	class ActionView::Helpers::FormBuilder
		include ActionView::Helpers::FormTagHelper
		extend HotDateRails::Utils
		
		# deprecate(:date_picker, :time_picker, :datetime_picker, :hd_picker)

		#handle type-specific calls (to :date_picker, :time_picker and :datetime_picker)
		def method_missing(method, *args)
			cls = $1 if method =~ /(.*)_picker/
			return super unless cls #not a valid picker method call
			args = (args + Array.new(3)).slice(0..2).push("#{cls}picker") #pad args to 3 and add cls attr to end
			send(:hd_picker, *args)
		end

	  def hd_picker(attr, opts=nil, locale_format=nil, cls=nil)
	  	opts ||= {}
	  	col_type = column_type(attr)
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
	  	formatted_value = I18n.localize(value, format: locale_format) if value.present?
	  	input_attrs = InputAttrs.new(attr, cls, opts)
	  	self.text_field("#{attr}", input_attrs.to_h.merge(value: (formatted_value || ""))) + \
	    self.hidden_field(attr, { :class => attr.to_s + "-alt", id: FormHelper.input_id(object, attr) })
	  end

	  def column_type(attr)
	  	if object.class.respond_to?(:columns_hash)
	  		object.class.columns_hash[attr.to_s].type #AR
	  	else
	  		:datetime
	  	end
	  end
	end

	class InputAttrs < Hash
		def initialize(attr, hd_cls, opts={})
			opts.reverse_merge!(html: {})
			#Set html attribute hash here so :class always gets overridden in next line
		  self.merge! opts[:html] 
		  self[:class] = (self.fetch(:class, "").split(" ") << hd_cls).join(" ")
	  	opts[:hd_opts] ||= {}
	  	opts[:data] ||= {}
	  	data = opts[:hd_opts].merge(opts[:data])
			hd_config = HotDateRails.config
	  	#date_format & time_format are the only options that can be passed in at the top level of opts
	  	data[:date_format] = (opts[:date_format] || hd_config.date_format)
	  	data[:time_format] = (opts[:time_format] || hd_config.time_format)
	  	#Time grids have default values set in config/initializers/hot_date_rails.rb
	  	data[:control_type]   ||= hd_config.control_type
	  	data[:hour_grid]   ||= hd_config.hour_grid
	  	data[:minute_grid] ||= hd_config.minute_grid
	  	data[:second_grid] ||= hd_config.second_grid
	  	self[:data] = data
		end
	end

	private
	def self.input_id(parent_obj, suffix=nil)
		#Uses the parent object for the id because each scope can only have a single input for each attribute
		#TODO: This is not true. What about belongs_to/has_many relationship? May have to with random/unique after all
		"hdr-hidden-#{parent_obj.class.to_s.downcase}_#{parent_obj.object_id}#{suffix}"
	end
end