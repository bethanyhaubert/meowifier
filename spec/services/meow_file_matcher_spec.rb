require 'rails_helper'

RSpec.describe MeowFileMatcher do
	it "takes the output from song parser and matches it to a meow" do
		parsed_song = [
									 {"midi_pitch"=>"34.74884033203125", "onset_time"=>"6.9795238095238092413", "duration"=>"0.74646258503401363704", "volume"=>"0.015069787390530109406", "note"=>"b3"},
									 {"midi_pitch"=>"36.01917266845703125", "onset_time"=>"7.7412925170068023206", "duration"=>"0.36394557823129253249", "volume"=>"0.043341517448425292969", "note"=>"c3"},
									 {"midi_pitch"=>"26.147073745727539062", "onset_time"=>"8.1256462585034014978", "duration"=>"0.70798185941043079161", "volume"=>"0.043479278683662414551", "note"=>"d3"},
									 {"midi_pitch"=>"24.723588943481445312", "onset_time"=>"8.8682993197278907616", "duration"=>"0.23140589569160996408", "volume"=>"0.063901968300342559814", "note"=>"c#3"},
									 {"midi_pitch"=>"36.02741241455078125", "onset_time"=>"9.115147392290248618", "duration"=>"0.28145124716553288069", "volume"=>"0.17634926736354827881", "note"=>"c3"},
									 {"midi_pitch"=>"32.69846343994140625", "onset_time"=>"9.4104308390022683994", "duration"=>"0.49965986394557820871", "volume"=>"0.043139461427927017212", "note"=>"a3"}
									]
		meow_file_matcher = MeowFileMatcher.new(parsed_song)

		expect(meow_file_matcher.meows).to eq(["#{Rails.root}/app/assets/meows/b3-#{Time.now}-0.wav",
																					 "#{Rails.root}/app/assets/meows/c3-#{Time.now}-1.wav",
																					"#{Rails.root}/app/assets/meows/d3-#{Time.now}-2.wav",
																					 "#{Rails.root}/app/assets/meows/c-3-#{Time.now}-3.wav",
																					"#{Rails.root}/app/assets/meows/c3-#{Time.now}-4.wav",
																					 "#{Rails.root}/app/assets/meows/a3-#{Time.now}-5.wav"])
	end
end
