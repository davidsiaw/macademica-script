class BookService
	def run(event_id)
		if VariableService.curious_about_golem?
			VariableService.curious_about_golem = false
			return ScriptService.new.run do
				message 'There should be something in here about the golem.'
				message "Ah yes."
				
				script "VariableService.knows_what_golem_is = true"
			end
		end

		return ScriptService.new.run do
			message "Someone must've left this here a long time ago"
		end
	end
end
