class EmptyMessages
  def self.all
    Message.where <<EOF
subject IS NULL AND body IS NULL
AND (
  SELECT COUNT(*)
  FROM message_attachments
  WHERE message_id = messages.id
) = 0
EOF
  end

  def self.first
    all.first
  end
end
