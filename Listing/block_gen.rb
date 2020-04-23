module Listing
	class BlockGen < Generator
		def initialize(&block)
			@upper = [
				RPG::EventCommand.new(0, 0, [])
			]
			super
		end

		def otherwise
			@upper = @instructions
			@instructions = []
		end

		def upper
			@upper
		end

		def lower
			@instructions
		end

		def result
			upper +
				[RPG::EventCommand.new(411, 0, [])] +
				lower +
				[RPG::EventCommand.new(412, 0, [])]
		end
	end
end
