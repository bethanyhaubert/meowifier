class MeowFileMatcher
	def initialize(parsed_song)
		@parsed_song = parsed_song
		@notes = notes
		@formatted_notes = format_notes
	end

	def meows
		collection = []
		@formatted_notes.each do |note|
			collection << "#{Rails.root}/app/assets/meows/#{note}.wav"
		end
		return collection
	end

	private

	def notes
		@parsed_song.map{ |note| note["note"] }
	end

	def format_notes
		@notes.each do|note|
			note.sub!(/[#]/, '-')
		end
	end
end