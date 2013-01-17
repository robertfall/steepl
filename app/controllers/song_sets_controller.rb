class SongSetsController < ApplicationController
  respond_to :html

  def index
    @song_sets = SongSet.all
    respond_with @song_sets
  end

  def show
    @song_set = SongSet.find(params[:id])
    respond_with @song_set
  end

  def new
    @song_set = SongSet.new
    respond_with @song_set
  end

  def edit
    @song_set = SongSet.find(params[:id])
    respond_with @song_set
  end

  def create
    @song_set = SongSet.new(params[:song_set])

    if @song_set.save
    end
    respond_with @song_set
  end

  # PUT /song_sets/1
  # PUT /song_sets/1.json
  def update
    @song_set = SongSet.find(params[:id])

    respond_to do |format|
      if @song_set.update_attributes(params[:song_set])
        format.html { redirect_to @song_set, notice: 'SongSet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /song_sets/1
  # DELETE /song_sets/1.json
  def destroy
    @song_set = SongSet.find(params[:id])
    @song_set.destroy

    respond_to do |format|
      format.html { redirect_to song_sets_url }
      format.json { head :no_content }
    end
  end

  def activate
    self.current_song_set = SongSet.find(params[:song_set_id])
    redirect_to request.referrer
  end
end
