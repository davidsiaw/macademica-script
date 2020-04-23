module Listing
	class Message
		def apply(text)
			[RPG::EventCommand.new(101, 0, [text])]
		end
	end
end
