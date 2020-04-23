module Listing
	class Wait
		def apply(amount)
			[RPG::EventCommand.new(106, 0, [amount])]
		end
	end
end
