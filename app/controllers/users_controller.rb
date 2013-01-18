class UsersController < ApplicationController
  before_filter :require_login, :worship_leader_only
  respond_to :html

  def new
    @user = User.new
    respond_with @user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end
end
