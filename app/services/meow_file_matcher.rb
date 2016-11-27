require 'streamio-ffmpeg'

class MeowFileMatcher
	def initialize(parsed_song)
		@parsed_song = parsed_song
		@formatted_notes = format_notes
	end


	def meows
		notes = []
		index = 0
		@formatted_notes.each do |note|
			file = "#{Rails.root}/app/assets/outputs/#{note["note"]}-#{Time.now}-#{index}.wav"
			adjusted_note = FFMPEG::Movie.new("#{Rails.root}/app/assets/meows/#{note["note"]}.wav")
			options = {convert_duration: note["duration"]}
			adjusted_note.transcode(file, options)
			notes << file
			index += 1
		end
		return notes
	end

	private

	def format_notes
		@parsed_song.each do |note|
			note["note"].sub!(/[#]/, '-')
		end
	end
end