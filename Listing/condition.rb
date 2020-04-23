module Listing
	class Condition
		def apply(var1, oper, var2, &block)
			vartype = 0
			varnum = 0
			operator = 0
			optype = 0
			operand = 0

			expr = BoolExpression.new(var1, oper, var2)
			blockgen = BlockGen.new(&block)
			[
				RPG::EventCommand.new(111, 0, expr.result),
				blockgen.result,
			]
		end
	end
end
