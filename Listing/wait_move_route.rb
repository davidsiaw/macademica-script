module Listing
	class WaitMoveRoute
		def apply
			[RPG::EventCommand.new(210, 0, [])]
		end
	end
end
