class MessageAttachmentForm
  ATTACHABLES = %w{ song_set song member }
  RECEIVABLES = %w{ member group }

  def initialize(params)
    @attachable_keys = []
    @receivable_keys = []
    @params = params

    parse_params(params)
  end

  def attachments
    @attachable_keys and @attachable_keys.map do |attachable|
      class_name = class_name(attachable)
      klass = class_name.classify.constantize
      attachment_ids = @params[attachable].split(',')
      attachments = klass.where(id: attachment_ids)
      attachments.map do |attachment|
        MessageAttachment.new(attachable: attachment)
      end
    end.flatten
  end

  def recipients
    @receivable_keys and @receivable_keys.map do |recipients|
      class_name = class_name(recipients)
      klass = class_name.classify.constantize
      recipient_ids = @params[recipients].split(',')
      recipients = klass.where(id: recipient_ids)
      recipients.map do |recipient|
        MessageRecipient.new(messageable: recipient)
      end
    end.flatten
  end

  private
  def parse_params(params)
    params.keys.select do |key|
      class_name = class_name(key)
      @attachable_keys << key if is_attachable?(key, class_name)
      @receivable_keys << key if is_receivable?(key, class_name)
    end
  end

  def is_attachable?(key, class_name)
    key.start_with?('with_attachment') and ATTACHABLES.include? class_name
  end

  def is_receivable?(key, class_name)
    key.start_with?('with_recipient') and RECEIVABLES.include? class_name
  end

  def class_name(key)
    (ATTACHABLES + RECEIVABLES).each do |class_name|
      return key[/#{class_name}/] if key.include?(class_name)
    end
  end
end
