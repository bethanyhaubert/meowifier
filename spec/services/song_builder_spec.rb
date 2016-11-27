require 'rails_helper'

RSpec.describe SongBuilder do
  it "combines two audio files" do
		file_1 = "#{Rails.root}/app/assets/meows/beth_C4.wav"
    file_2 = "#{Rails.root}/app/assets/meows/beth_D4.wav"
		collection = [file_1, file_2]
		song_builder = SongBuilder.new(collection)

		expect(song_builder.duration_of_song).to eq(5851)
	end

  it "combines three audio files" do
    file_1 = "#{Rails.root}/app/assets/meows/beth_C4.wav"
    file_2 = "#{Rails.root}/app/assets/meows/beth_D4.wav"
    file_3 = "#{Rails.root}/app/assets/meows/beth_E4.wav"
    collection = [file_1, file_2, file_3]
    song_builder = SongBuilder.new(collection)

    expect(song_builder.duration_of_song).to eq(8777)
	end

	# it "creates the Game of Thrones theme" do
	# 	song = "https://s3.amazonaws.com/meowifier-staging/test_songs/got.mp3"
	# 	song_parser = SongParser.new(song)
	# 	parsed_song = song_parser.notes
	# 	song_builder = SongBuilder.new(parsed_song)
	#
	# 	expect(song_builder)
	# end
end
