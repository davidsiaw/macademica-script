module Listing
	class BoolExpression
		def initialize(var1, oper, var2)
			@var1 = var1
			@oper = oper
			@var2 = var2
		end

		def vartype
			if @var1.to_s[0..5] == 'switch'
				0
			elsif @var1.to_s[0..2] == 'var'
				1
			elsif @var1.to_s[0..4] == 'self'
				2
			end
		end

		def varnum
			if vartype == 0
				@var1.to_s[6..-1].to_i
			elsif vartype == 1
				@var1.to_s[3..-1].to_i
			elsif vartype == 2
				@var1.to_s[4]
			end
		end

		def optype
			if vartype == 0
				@var2
			elsif vartype == 1
				@var2.is_a?(Integer) ? 0 : 1
			elsif vartype == 2
				@var2 ? 1 : 0
			end
		end

		def opnum
			if vartype == 1
				@var2.is_a?(Integer) ? @var2 : @var2.to_s[3..-1]
			else
				0
			end
		end

		def operator
			case @oper
			when :eq
				0
			when :ge
				1
			when :le
				2
			when :gt
				3
			when :lt
				4
			when :ne
				5
			end
		end

		def result
			#p [vartype, varnum, optype, opnum, operator]
			[vartype, varnum, optype, opnum, operator]
		end
	end
end
