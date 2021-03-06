require 'rails_helper'

RSpec.describe NoteConverter do
  it "converts white key" do
    midi_num = 60
		note_converter = NoteConverter.new(midi_num)

		expect(note_converter.note).to eq("c4")
	end

	it "converts black key" do
    midi_num = 61
    note_converter = NoteConverter.new(midi_num)

    expect(note_converter.note).to eq("c#4")
	end

  it "converts intermediate number to nearest note" do
    midi_num = 62.587276458740234375
    note_converter = NoteConverter.new(midi_num)

    expect(note_converter.note).to eq("d#4")
	end

	it "raises the octave of a note by 1" do
		midi_num = 22
		note_converter = NoteConverter.new(midi_num)

		expect(note_converter.note).to eq("a#1")
  end

	it "lowers the octave of a note by 1" do
		midi_num = 109
		note_converter = NoteConverter.new(midi_num)

		expect(note_converter.note).to eq("c#7")
	end
end
