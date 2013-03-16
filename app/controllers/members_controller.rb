class MembersController < ApplicationController
  before_filter :require_login
  respond_to :html, :json
  part_of :membership

  def index
    @members = Member.order(:last_name, :first_name)
  end

  def new
    @form = MemberForm.new({})
    @form.add_default_values
  end

  def show
    @member = Member.find(params[:id])
  end

  def create
    @form = MemberForm.new(params[:form])
    @form.save
    respond_with(@form, location: members_path)
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    respond_with @member
  end
end
