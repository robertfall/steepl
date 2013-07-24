class MessageMailer < ActionMailer::Base
  default from: '"Steepl" <messages@steepl.co>'

  def message_mail(message)
    recipients = message.recipients.map {|r| r.adapter.email_address }.flatten

    mail_html = BlueCloth.new(message.body).to_html
    mail_txt = message.body

    attachment_adapters = message.attachments.map &:adapter
    attachments_html = attachment_adapters.map {|a| a.to_html}.join('</br>')
    attachments_text = attachment_adapters.map {|a| a.to_text}.join("\n\n")

    final_html = mail_html + attachments_html
    final_text = [mail_txt, attachments_text].join("\n\n")

    mail(to: recipients, subject: message.subject) do |format|
      format.html do |html|
        render inline: final_html
      end
      format.text do |html|
        render inline: final_text
      end
    end
  end
end
