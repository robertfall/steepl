class SongsController < ApplicationController
  before_filter :require_login
  respond_to :html
  def index
    @songs = Song.alphabetic
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

    if @song.save
    end
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

  def add_to_set
    song = Song.find(params[:song_id])
    current_song_set.songs << song
    current_song_set.save
    redirect_to request.referrer
  end
end
