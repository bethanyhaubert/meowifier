require 'streamio-ffmpeg'
require 'wavefile'
include WaveFile

# This class accepts a meow and a duration and adjusts it so that a new file is created with the correct length
#
# NOT CURRENTLY IN USE
class AdjustedMeow
	def initialize(meow, duration)
		@meow = meow
		@new_duration = duration
	end

	def adjust
		meow = FFMPEG::Movie.new("#{Rails.root}/app/assets/meows/")
	end

	def duration_of_meow_in_seconds(meow)
		reader = Reader.new(meow)
		(reader.total_duration.minutes * 60000).to_f + reader.total_duration.seconds.to_f + (reader.total_duration.milliseconds.to_f/1000.0)
	end
end
