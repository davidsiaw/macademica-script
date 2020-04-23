module Listing
	class EraseEvent
		def apply
			[RPG::EventCommand.new(116, 0, [])]
		end
	end
end
