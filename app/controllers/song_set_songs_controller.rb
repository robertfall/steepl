class SongSetSongsController < ApplicationController
  def sort
    params[:song_sets_song].each_with_index do |id, index|
      SongSetsSong.update_all({position_number: index+1}, {id: id})
    end
    render nothing: true
  end
end
