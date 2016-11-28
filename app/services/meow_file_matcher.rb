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
			output_file = "#{Rails.root}/app/assets/outputs/#{note["note"]}-#{Time.now}-#{index}.wav"
			note_to_adjust = FFMPEG::Movie.new("#{Rails.root}/app/assets/meows/#{note["note"]}.wav")
			# if note_to_adjust.duration >= note["duration"].to_f
				note_to_adjust.transcode(output_file, ["-ss", "0", "-t", note["duration"]])
			# else
			# 	loops = number_of_loops(note_to_adjust.duration, note["duration"].to_f)
			# 	temp_output_file = "#{Rails.root}/app/assets/loops/#{note["note"]}-#{Time.now}-#{index}.wav"
			# 	note_duration = note["duration"]
			# 	create_looped_file(loops, note_to_adjust, output_file, temp_output_file, note_duration)
			# end
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

	def create_looped_file(loops, note_to_adjust, output_file, temp_output_file, note_duration)
		note_to_adjust.transcode(temp_output_file, ["-stream_loop", "#{loops}"])
		# ffmpeg -stream_loop 2 -i ~/Code/personal/meowifier/app/assets/meows/a-3.wav
		# ~/Code/personal/meowifier/app/assets/meows/looped.wav
		binding.pry

		crop_looped_file(temp_output_file, output_file, note_duration)
	end

	def crop_looped_file(temp_output_file, output_file, note_duration)
		cropped_loops = FFMPEG::Movie.new(temp_output_file)
		cropped_loops.transcode(output_file, ["-ss", "0", "-t", note_duration])
	end
end