class MessagesController < ApplicationController
  ATTACHABLES = %w{ song_set song member }

  before_filter :load_attachables, only: :new

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
    @message.attachments += @attachables if @attachables.present?
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
  # with_CLASSNAME_ids
  def load_attachables
    attachables = params.keys.select do |key|
      _, class_name, _ = key.split('_')
      key.start_with?('with_') and ATTACHABLES.include? class_name
    end

    @attachables = attachables.map do |attachable|
      _, class_name, _ = attachable.split('_')
      klass = class_name.classify.constantize
      attachment_ids = params[attachable].split(',')
      attachments = klass.where(id: attachment_ids)
      attachments.map do |attachment|
        MessageAttachment.new(attachable: attachment)
      end
    end.flatten
  end
end
