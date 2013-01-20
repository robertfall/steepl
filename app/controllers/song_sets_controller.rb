class SongSetsController < ApplicationController
  before_filter :require_login, :worship_leader_only
  before_filter :parse_play_on, only: [:create, :update]
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

    flash[:notice] = "Set created successfully." if @song_set.save
    respond_with @song_set
  end

  def update
    @song_set = SongSet.find(params[:id])

    flash[:notice] = "Set updated succesfully." if @song_set.update_attributes(params[:song_set])
    respond_with @song_set
  end

  def destroy
    @song_set = SongSet.find(params[:id])
    @song_set.destroy
    respond_with @song_set
  end

  def activate
    self.current_song_set = SongSet.find(params[:song_set_id])
    redirect_to request.referrer
  end

  def deactivate
    self.current_song_set = nil
    redirect_to request.referrer
  end

  protected
  def parse_play_on
    parms = params[:song_set]
    parms[:play_on] = DateTime.parse(parms[:play_on]) if parms[:play_on]
  end
end