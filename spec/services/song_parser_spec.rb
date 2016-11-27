require 'rails_helper'

RSpec.describe SongParser do
  it "parses the Game of Thrones theme" do
		song = "https://s3.amazonaws.com/meowifier-staging/test_songs/got.mp3"
		song_parser = SongParser.new(song)

		expect(song_parser.notes).to be_an(Array)
		expect(song_parser.notes[0]["note"]).to eq("c3")
	end
end
