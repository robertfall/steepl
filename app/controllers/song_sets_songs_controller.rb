class SongSetsSongsController < ApplicationController
  respond_to :html
  def create
    @song_sets_song = SongSetsSong.new(params[:song_sets_song])
    @song_sets_song.save
    respond_with @song_sets_song, location: request.referrer
  end

  def destroy
    song_sets_song = SongSetsSong.find(params[:id])
    flash[:notice] = "Song Removed" if song_sets_song.destroy
    redirect_to request.referrer
  end

  def sort
    params[:song_sets_song].each_with_index do |id, index|
      SongSetsSong.update_all({position_number: index+1}, {id: id})
    end
    render nothing: true
  end
end
