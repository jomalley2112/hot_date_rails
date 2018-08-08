
	def id_attr(input, type="text")
		Nokogiri::HTML.parse(input).xpath("//input[@type='#{type}']").attribute("id").value
	end

	def id_attr_from_html(html_frag, input_index, type="text")
		Nokogiri::HTML.parse(html_frag).xpath("//input[@type='#{type}'][#{input_index}]").attribute("id").value
	end