module Listing
	class PlaySe
		def apply(se)
			[RPG::EventCommand.new(250, 0, [RPG::AudioFile.new(se)])]
		end
	end
end
