class GroupsController < ApplicationController
  respond_to :html

  before_filter :cache_member_ids, only: :new
  before_filter :load_members, only: :create

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
    @group = Group.new(params[:group])
    @group.members << @members
    @group.save
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

  private
  def cache_member_ids
    @member_ids = params[:with_member_ids]
  end

  def load_members
    return unless params[:member_ids]
    member_ids = params[:member_ids].split(',')
    @members = Member.where(id: member_ids)
  end
end
