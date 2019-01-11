require 'rails_helper'

RSpec.describe AdjustedMeow do
  it "creates a 0.25 second meow from a 0.741 second meow" do
    meow = "#{Rails.root}/app/assets/meows/c4.wav"
    duration = 0.25
		adjust = AdjustedMeow.new(meow, duration)
		adjusted_meow = adjust.adjust

		expect(adjust.duration_of_meow_in_seconds(meow)).to eq(0.995)
		# expect(adjust.duration_of_meow_in_seconds(adjusted_meow)).to eq(0.25)
	end

  it "creates a 1.25 second meow from a 0.762 second meow" do
    meow = "#{Rails.root}/app/assets/meows/c#4.wav"
    duration = 1.25
    adjust = AdjustedMeow.new(meow, duration)

    expect(adjust.duration_of_meow_in_seconds(meow)).to eq(0.955)
	end
end
