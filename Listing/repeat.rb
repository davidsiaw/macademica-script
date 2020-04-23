module Listing
	class Repeat
		def apply(&block)
			blockgen = BlockGen.new(&block)
			[
				RPG::EventCommand.new(112, 0, []),
				blockgen.result,
				RPG::EventCommand.new(413, 1, []),
			]
		end
	end

	class ExitRepeat
		def apply
			[RPG::EventCommand.new(113, 0, [])]
		end
	end
end
