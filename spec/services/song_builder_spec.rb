require 'rails_helper'

RSpec.describe SongBuilder do
  it "combines two audio files" do
		file_1 = "#{Rails.root}/app/assets/meows/C4.wav"
    file_2 = "#{Rails.root}/app/assets/meows/D4.wav"
		collection = [file_1, file_2]
		song_builder = SongBuilder.new(collection)

		expect(song_builder.duration_of_song).to eq(5851)
	end

  it "combines three audio files" do
    file_1 = "#{Rails.root}/app/assets/meows/C4.wav"
    file_2 = "#{Rails.root}/app/assets/meows/D4.wav"
    file_3 = "#{Rails.root}/app/assets/meows/E4.wav"
    collection = [file_1, file_2, file_3]
    song_builder = SongBuilder.new(collection)

    expect(song_builder.duration_of_song).to eq(8777)
	end
end
