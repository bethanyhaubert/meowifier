require 'wavefile'
include WaveFile

class SongBuilder
	def initialize(collection, new_file_name)
		@collection = collection
		@new_file_name = new_file_name
	end

	def combine
		@file_name = Time.now.to_i
		sample_frames = 4096
		format = Format.new(:stereo, :pcm_16, 44100)
		File.new("#{Rails.root}/app/assets/songs/#{@file_name}.wav", "w")

		Writer.new("#{Rails.root}/app/assets/songs/#{@file_name}.wav", format) do |writer|
			@collection.each do |file|
				Reader.new(file).each_buffer(sample_frames) do |buffer|
					writer.write(buffer)
				end
			end
		end
	end

	def combined_duration_of_collection
		duration = 0
		index = -1
		@collection.each do |file|
			reader = Reader.new(file)
			milliseconds = (reader.total_duration.seconds * 1000) + reader.total_duration.milliseconds
			duration += milliseconds
			index += 1
		end
		duration + index
	end

	def duration_of_song
		combine
		reader = Reader.new("#{Rails.root}/app/assets/songs/#{@file_name}.wav")
		(reader.total_duration.seconds * 1000) + reader.total_duration.milliseconds
	end
end