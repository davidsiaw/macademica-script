module Listing
	class Label
		def apply(name)
			[RPG::EventCommand.new(118, 0, [name])]
		end
	end

	class GotoLabel
		def apply(name)
			[RPG::EventCommand.new(119, 0, [name])]
		end
	end
end
