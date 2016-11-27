require 'rails_helper'

RSpec.describe SongParser do
  it "parses the Game of Thrones theme" do
		song = "https://s3.amazonaws.com/meowifier-staging/test_songs/got.mp3"
		song_parser = SongParser.new(song)
		binding.pry
		expect(song_parser.notes).to be_an(Array)
		expect(song_parser.notes[0]["note"]).to eq("c3")
	end

	# it "creates a collection of meows" do
	# 	song = "https://s3.amazonaws.com/meowifier-staging/test_songs/got.mp3"
	# 	song_parser = SongParser.new(song)
	#
	# 	# loop through each of the notes in the parsed song and store
	# 	# a meow of the proper note and duration in a new collection
	#
	# 	expect(song_parser.meows).to be_an(Array)
	# end
end
