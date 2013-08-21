class MessagesController < ApplicationController
  ATTACHABLES = %w{ song_set song member }
  RECEIVABLES = %w{ member group }

  before_filter :load_attachments_and_recipients, only: :new

  respond_to :html
  part_of :messages

  def index
    @messages = Message.newest
    respond_with(@messages)
  end

  def show
    @message = Message.find_by_id(params[:id])
    return redirect_to edit_message_path(@message) unless @message.sent_at
    respond_with(@message)
  end

  def new
    @message = EmptyMessages.first || Message.create
    @message.attachments += @attachments if @attachments.present?
    @message.recipients += @recipients if @recipients.present?
    redirect_to edit_message_path(@message)
  end

  def edit
    @message = Message.find_by_id(params[:id])
    return redirect_to @message if @message.sent_at
    respond_with @message
  end

  def update
    @message = Message.find_by_id(params[:id])
    @message.update_attributes(params[:message])

    MessageService.send_message(@message) if params[:should_send] == "true"
    respond_with(@message, location: messages_path)
  end

  def destroy
    @message = Message.find_by_id(params[:id])
    @message.destroy
    respond_with @message
  end

  private
  # load attachables from url format:
  # with_attachment_CLASSNAME_ids
  def load_attachments_and_recipients
    form = MessageAttachmentForm.new(params)
    @recipients = form.recipients
    @attachments = form.attachments
  end
end
