class MembersController < ApplicationController
  before_filter :require_login
  respond_to :html, :json

  def index
    @members = Member.all
  end

  def new
    @form = MemberForm.new({})
    @form.add_default_values
  end

  def create
    @form = MemberForm.new(params[:form])
    render 'new' unless @form.save
  end
end
