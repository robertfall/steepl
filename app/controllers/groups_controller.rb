class GroupsController < ApplicationController
  respond_to :html

  attach_as :group
  part_of :membership

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.create(params[:group])
    respond_with @group
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributs(params[:group])
    respond_with(@group)
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    respond_with @group
  end
end
