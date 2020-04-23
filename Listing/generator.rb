module Listing
	class Generator
		def initialize(&block)
			@instructions = []
			instance_eval(&block) if block
		end

		def camelize(name)
			camelized = ""
			up = true
			name.split('').each do |chr|
				if up
					camelized += chr.upcase
				elsif chr == '_'
					up = true
					next
				else
					camelized += chr
				end
				up = false
			end
			camelized
		end

		def method_missing(name, *args, &block)
			acls = Listing::const_get("#{camelize(name.to_s)}".to_sym)
			return super if acls == nil

			obj = acls.new
			c = obj.apply(*args, &block)
			@instructions += c
		end

		def unstraight
			@instructions + [RPG::EventCommand.new(0, 0, [])]
		end

		def straighten(arr, indent = 0)
			res = []
			arr.each do |x|
				if x.is_a? Array
					res += straighten(x, indent + 1)
				else
					res << RPG::EventCommand.new(x.code, x.indent + indent, x.parameters)
				end
			end
			res
		end

		def result
			straighten(unstraight)
		end
	end
end
