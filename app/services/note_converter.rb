# This class takes the midi pitch value returned from the Sonic API service and translates it into an actual note.
class NoteConverter
	attr_reader :raw_note, :note, :key_type, :key, :octave, :octave_modifier

	NOTE_MAPPINGS = {"12" => "c0", "13" => "c#0", "14" => "d0", "15" => "d#0", "16" => "e0", "17" => "f0", "18" => "f#0",
		 "19" => "g0","20" => "g#0","21" => "a0", "22" => "a#0", "23" => "b0", "24" => "c1", "25" => "c#1", "26" => "d1",
		 "27" => "d#1", "28" => "e1", "29" => "f1", "30" => "f#1", "31" => "g1", "32" => "g#1", "33" => "a1", "34" => "a#1",
		 "35" => "b1", "36" => "c2", "37" => "c#2", "38" => "d2", "39" => "d#2", "40" => "e2", "41" => "f2", "42" => "f#2",
		 "43" => "g2", "44" => "g#2", "45" => "a2", "46" => "a#2", "47" => "b2", "48" => "c3", "49" => "c#3", "50" => "d3",
		 "51" => "d#3", "52" => "e3", "53" => "f3", "54" => "f#3", "55" => "g3", "56" => "g#3", "57" => "a3", "58" => "a#3",
		 "59" => "b3", "60" => "c4", "61" => "c#4", "62" => "d4", "63" => "d#4", "64" => "e4", "65" => "f4", "66" => "f#4",
		 "67" => "g4", "68" => "g#4", "69" => "a4", "70" => "a#4", "71" => "b4", "72" => "c5", "73" => "c#5", "74" => "d5",
		 "75" => "d#5", "76" => "e5", "77" => "f5", "78" => "f#5", "79" => "g5", "80" => "g#5", "81" => "a5", "82" => "a#5",
		 "83" => "b5", "84" =>"c6", "85" => "c#6", "86" => "d6", "87" => "d#6", "88" => "e6", "89" => "f6", "90" => "f#6",
		 "91" => "g6", "92" => "g#6", "93" => "a6", "94" => "a#6", "95" => "b6", "96" => "c7", "97" => "c#7", "98" => "d7",
		 "99" => "d#7", "100" => "e7", "101" => "f7", "102" => "f#7", "103" => "g7", "104" => "g#7", "105" => "a7",
		 "106" => "a#7", "107" => "b7", "108" => "c8", "109" => "c#8"}

	def initialize(midi_num)
		@rounded_midi_num = midi_num.to_f.round
		@midi_num = @rounded_midi_num.to_i.to_s
		@raw_note = NOTE_MAPPINGS[@midi_num]
		@key_type = set_key_type
		@key = set_key
		@octave = set_octave
		@octave_modifier = set_octave_modifier
		@note = set_note
	end

	private

	def new_octave
		octave + octave_modifier
	end

	def change_note
		@note = "#{key}#{new_octave}"
	end

	def in_octave_1?
		@rounded_midi_num < 24
	end

	def in_octaves_2_to_7?
		@rounded_midi_num > 23 && @rounded_midi_num < 109
	end

	def above_octave_7?
		@rounded_midi_num > 108
	end

	def set_key_type
		if @raw_note == nil
		else
			(@raw_note.length == 2) ? "white" : "black"
		end
	end

	def set_key
		(key_type == "white") ? @raw_note[0] : @raw_note[0,2]
	end

	def set_octave
		@raw_note[-1].to_i
	end

	def set_octave_modifier
		if in_octave_1?
			1
		elsif above_octave_7?
			-1
		end
	end

	def set_note
		in_octaves_2_to_7? ? NOTE_MAPPINGS[@midi_num] : change_note
	end
end
