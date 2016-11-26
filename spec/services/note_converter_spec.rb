require 'rails_helper'

RSpec.describe NoteConverter do
  it "converts white key" do
    midi_num = 24
		note_converter = NoteConverter.new(midi_num)

		expect(note_converter.note).to eq("c1")
	end

	it "converts black key" do
    midi_num = 22
    note_converter = NoteConverter.new(midi_num)

    expect(note_converter.note).to eq("a#0")
	end

  it "converts intermediate number to nearest note" do
    midi_num = 62.587276458740234375
    note_converter = NoteConverter.new(midi_num)

    expect(note_converter.note).to eq("d#4")
  end
end
