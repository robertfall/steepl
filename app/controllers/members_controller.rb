class MembersController < ApplicationController
  before_filter :require_login
  before_filter(only: [:show, :index]) { |c| c.authorize(:read_members) }
  before_filter(except: [:show, :index]) { |c| c.authorize(:edit_members) }
  before_filter :parse_with_chronic, only: :index
  before_filter :load_attach_to_adapter, only: :index

  respond_to :html, :json, :text

  part_of :membership
  attach_as :member

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

  private
  def parse_with_chronic
    return unless q_params = params[:q]
    time_fields = [:birthday_min, :birthday_max]
    time_fields.each do |field|
      q_params[field] = Chronic.parse(q_params[field]) if q_params[field]
    end
  end
end
