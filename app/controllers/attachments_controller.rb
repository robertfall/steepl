class AttachmentsController < ApplicationController
  respond_to :html, :json
  def create
    song = Song.find(params[:song_id])
    @attachment = song.attachments.create(params[:attachment])
    respond_with @attachment, location: song
  end
end
