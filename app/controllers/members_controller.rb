class MembersController < ApplicationController
  before_filter :require_login, :worship_leader_only
  respond_to :html, :json
  part_of :membership

  def index
    @filter_form = MemberFilterForm.new(params[:q])
    respond_with(@filter_form.results)
  end

  def new
    @form = MemberForm.new({})
    @form.add_default_values
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    member = Member.find(params[:id])
    @form = MemberForm.from_member(member)
  end

  def update
    member = Member.find(params[:id])
    @form = MemberForm.from_member(member)
    @form.assign_attributes(params[:form])
    @form.save
    respond_with(@form, location: members_path)
  end

  def create
    @form = MemberForm.new(params[:form])
    @form.save
    respond_with(@form, location: members_path)
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_with(@member, location: members_path)
  end
end
