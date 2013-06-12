class MessageAttachmentsController < ApplicationController
  respond_to :html, :json

  def create
    @message_attachment = MessageAttachment.new(params[:message_attachment])
    @message_attachment.save
    respond_with @message_attachment, location: request.referrer
  end
end
