class SongsController < ApplicationController
  before_filter :require_login
  before_filter :add_to_set, only: :index
  part_of :worship

  respond_to :html, :json
  def index
    @songs = Song.includes(:latest_mp3, :latest_sheet_music, :attachments).alphabetic
    respond_with @songs
  end

  def show
    @song = Song.find(params[:id])
    respond_with @song
  end

  def new
    @song = Song.new
    respond_with @song
  end

  def edit
    @song = Song.find(params[:id])
    respond_with @song
  end

  def create
    @song = Song.new(params[:song])
    @song.save
    respond_with @song
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private
  def add_to_set
    return unless @song_set = SongSet.find_by_id(params[:add_to_set])
  end
end
