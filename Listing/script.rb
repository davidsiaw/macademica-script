module Listing
	class Script
		def apply(text)
			[RPG::EventCommand.new(355, 0, [text])]
		end
	end
end
