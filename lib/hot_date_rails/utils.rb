require 'pry'
module HotDateRails::Utils
	def deprecate(*dep_mtds, new_mtd)
		dep_mtds.each do |dep_mtd|
			define_method(dep_mtd) do |*args, &block|
				# warn "Warning: #{dep_mtd}() is deprecated. In the future please use #{new_mtd}()."
				send(new_mtd, *args, &block)
			end
		end
	end
end