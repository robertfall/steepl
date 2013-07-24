class GroupMembersController < ApplicationController
  respond_to :html, :json
  def create
    @group_member = GroupMember.new(params[:group_member])
    @group_member.save
    respond_with(@group_member, location: request.referrer ? request.referrer : members_path)
  end
end
