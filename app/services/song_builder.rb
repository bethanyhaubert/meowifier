require 'wavefile'
include WaveFile

class SongBuilder
	OUTPUT_FORMAT = Format.new(:stereo, :pcm_16, 44100)
	SAMPLE_FRAMES_PER_BUFFER = 4096

	def initialize(collection, file_name=Time.now.to_i)
		@collection = collection
		@file_name = file_name
		#TODO: Store this file on S3
		@file_path = "#{Rails.root}/app/assets/songs/#{@file_name}.wav"
		combine
	end

	def combine
		Writer.new(@file_path, OUTPUT_FORMAT) do |writer|
			@collection.each do |file|
				Reader.new(file).each_buffer(SAMPLE_FRAMES_PER_BUFFER) do |buffer|
					writer.write(buffer)
				end
			end
		end
	end

	def combined_duration_of_collection
		duration = 0
		@collection.each do |file|
			duration += duration_of_individual_file(file)
		end
		duration + duration_adjustment
	end

	def duration_of_song
		duration_of_individual_file(@file_path)
	end

private

	def duration_of_individual_file(file)
		reader = Reader.new(file)
		(reader.total_duration.minutes * 60000) +(reader.total_duration.seconds * 1000) + reader.total_duration.milliseconds
	end

	def duration_adjustment
		@collection.length-1
	end
end