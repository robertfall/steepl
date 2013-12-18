class SongAttachmentsController < ApplicationController
  before_filter(only: [:show, :index]) { |c| c.authorize(:read_worship) }
  before_filter(except: [:show, :index]) { |c| c.authorize(:edit_worship) }

  respond_to :html, :json
  def create
    song = Song.find(params[:song_id])
    @attachment = song.attachments.create(params[:attachment])
    respond_with @attachment, location: song
  end

  def destroy
    song = Song.find(params[:song_id])
    @attachment = song.attachments.find(params[:id])
    flash[:notice] = "Attachment Removed" if @attachment.destroy
    respond_with @attachment, location: song
  end
end
