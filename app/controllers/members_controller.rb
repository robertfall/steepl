class MembersController < ApplicationController
  before_filter :require_login
  respond_to :html, :json

  def index
    @songs = Member.all
  end

  def new
    @form = MemberForm.new
  end

  def create
    @form = MemberForm.new(params[:form])
    @form.valid?
    render 'new'
  end
end
