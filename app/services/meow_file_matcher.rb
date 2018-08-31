require 'streamio-ffmpeg'

# This class accepts a parsed song and then maps the correct cat meow file to each note,
# while adjusting for length, then pushes it to an output file.
class MeowFileMatcher
	def initialize(parsed_song)
		@parsed_song = parsed_song
		# @formatted_notes = format_notes
	end

	def meows
		notes = []
		index = 0
		parsed_song.each do |note|
			output_file = "#{Rails.root}/app/assets/outputs/#{note["note"]}-#{Time.now}-#{index}.wav"
			input_file = "#{Rails.root}/app/assets/meows/#{note["note"]}.wav"
			note_to_adjust = FFMPEG::Movie.new("#{Rails.root}/app/assets/meows/#{note["note"]}.wav")
			note_duration = note["duration"]

			if note_to_adjust.duration >= note["duration"].to_f
				note_to_adjust.transcode(output_file, ["-ss", "0", "-t", note_duration])
			else
				loops = number_of_loops(note_to_adjust.duration, note["duration"].to_f).to_s
				looped_file = "#{Rails.root}/app/assets/loops/#{note["note"]}-#{Time.now}-#{index}.wav"
				create_looped_file(loops, input_file, output_file, looped_file, note_duration)
			end

			notes << output_file
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

	def number_of_loops(file_length, note_length)
		(note_length/file_length).ceil
	end

	def create_looped_file(loops, input_file, output_file, looped_file, note_duration)
		system "ffmpeg -stream_loop #{loops} -i #{input_file} '#{looped_file}'"
		crop_looped_file(looped_file, output_file, note_duration)
	end

	def crop_looped_file(looped_file, output_file, note_duration)
		cropped_loops = FFMPEG::Movie.new(looped_file)
		cropped_loops.transcode(output_file, ["-ss", "0", "-t", note_duration])
	end
end