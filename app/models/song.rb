class Song < ActiveRecord::Base
	mount_uploader :file, SongUploader

	def meowify
		song_parser = SongParser.new(:file)
		parsed_song = song_parser.notes
		meow_matcher = MeowFileMatcher.new(parsed_song)
		meows = meow_matcher.meows

		song_builder = SongBuilder.new(meows)
		update_attribute(:meowified_file, song_builder)
	end
end
