class AttachmentsController < ApplicationController
  respond_to :html, :json
  before_filter :initialize_form, only: :create

  def create
    @join_object = @form.join_object
    @join_object.save
    respond_with @join_object, location: request.referrer ? request.referrer : @message_attachment.message
  end

  def destroy
    @join_object = params[:attachment_type].classify.constantize.find_by_id(params[:id])
    @join_object.destroy
    respond_with @join_object, location: request.referrer ? request.referrer : @message_attachment.message
  end

  private
  def initialize_form
    @form = AttachmentForm.new(params[:form])
  end
end
