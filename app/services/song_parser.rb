class SongParser
	def initialize(song)
		@song = song
		parse
	end

	def notes
		@notes
	end

	private

	def parse
		response = HTTParty.get("https://api.sonicapi.com/analyze/melody?access_id=#{ENV['SONIC_API_ACCESS_ID']}&input_file=#{@song}")
		@notes = response["response"]["melody_result"]["notes"]["note"]
	end
end