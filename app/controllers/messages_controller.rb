class MessagesController < ApplicationController
  ATTACHABLES = %w{ song_set song member }
  before_filter :load_attachable, only: :new

  respond_to :html

  part_of :messages

  def index
    @messages = Message.all
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

    MessageService.send_message(@message) if params[:should_send]
    respond_with(@message, location: messages_path)
  end

  def destroy
    @message = Message.find_by_id(params[:id])
    @message.destroy
    respond_with @message
  end

  private
  def load_attachable
    attachables = params.keys.select do |key|
      key.ends_with?('_id') and ATTACHABLES.include? key.gsub(/_id$/,'')
    end

    @attachables = attachables.map do |attachable|
      klass = attachable.gsub(/_id$/, '').classify.constantize
      MessageAttachment.new(attachable: klass.find(params[attachable]))
    end
  end
end
