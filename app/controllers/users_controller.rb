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

  def index
    @users = User.all
    respond_with @users
  end

  def edit
    @user = User.find(params[:id])
    respond_with @user
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    @user = User.find(params[:id])
    flash[:notice] = "User updated succesfully." if @user.update_attributes(params[:user])
    respond_with @user, location: users_path
  end
end
