class MainController < ApplicationController
	def index
		@song = Song.new
	end

	def create
		@song = Song.new(song_params)

		if @song.save
			@song.meowify
			redirect_to show_path(@song), notice: "The song #{@song.title} is being meowified."
		else
			render "index"
		end
	end

	def show
		@song = Song.find(params)
	end

	private
	def song_params
		params.require(:song).permit(:file, :title)
	end
end