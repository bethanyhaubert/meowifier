require 'rails_helper'

RSpec.describe MeowFileMatcher do
	it "takes the output from song parser and matches it to a meow" do
		parsed_song = [{"midi_pitch"=>"34.74884033203125", "onset_time"=>"6.9795238095238092413", "duration"=>"0.74646258503401363704", "volume"=>"0.015069787390530109406", "note"=>"b3"}]
		meow_file_matcher = MeowFileMatcher.new(parsed_song)
    time = Time.now

		expect(meow_file_matcher.meows).to eq(["#{Rails.root}/app/assets/outputs/b3-#{time}-0.wav"])
	end
end
