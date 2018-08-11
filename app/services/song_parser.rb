# This class makes a request to an API, receives the response, and then creates a collection of notes.
class SongParser
	def initialize(song)
		@song = song
		parse
	end

	def notes
		@note_collection
	end

	private

	def parse
		response = HTTParty.get("https://api.sonicapi.com/analyze/melody?access_id=#{ENV['SONIC_API_ACCESS_ID']}&input_file=#{@song}")
		@note_collection = response["response"]["melody_result"]["notes"]["note"]
		append_array_with_note
	end

	def append_array_with_note
		@note_collection.each do |note|
			note_converter = NoteConverter.new(note["midi_pitch"])
			note["note"] = note_converter.note
		end
		return @note_collection
	end
end