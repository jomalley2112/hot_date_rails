module HotDateRails::Utils
	def deprecate(dep_mtd, new_mtd)
		define_method(dep_mtd) do |*args, &block|
			warn "Warning: #{dep_mtd}() is deprecated. In the future please use #{new_mtd}()."
			send(new_mtd, *args, &block)
		end
	end
	def deprecate_consolidated(dep_mtds, new_mtd)
		dep_mtds.each { |mtd| deprecate(mtd, new_mtd) }
	end
end