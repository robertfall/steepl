class MembersController < ApplicationController
  before_filter :require_login
  respond_to :html, :json

  def index
    @members = Member.order(:last_name, :first_name)
  end

  def new
    @form = MemberForm.new({})
    @form.add_default_values
  end

  def create
    @form = MemberForm.new(params[:form])
    @form.save
    respond_with(@form, location: members_path)
  end
end
