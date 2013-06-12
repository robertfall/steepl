class MessagesController < ApplicationController
  ATTACHABLES = %w{ song_set song member }

  before_filter :load_attachable, only: :new

  def new
    @message = EmptyMessages.first || Message.create
    @message.attachments += @attachables if @attachables.present?
    redirect_to edit_message_path(@message)
  end

  def edit
    @message = Message.find_by_id(params[:id])
  end

  def load_attachable
    attachables = params.keys.select do |key|
      key.ends_with?('_id') and ATTACHABLES.include? key.gsub(/_id$/,'')
    end

    @attachables = attachables.map do |attachable|
      klass =attachable.gsub(/_id$/, '').classify.constantize
      MessageAttachment.new(attachable: klass.find(params[attachable]))
    end
  end
end
