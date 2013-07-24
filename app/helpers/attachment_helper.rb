module AttachmentHelper
  def attach_to_host_form(attachment_id, adapter)
    capture do
      form_for adapter, as: :form, url: attachments_path do |f|
        concat f.hidden_field :host_type
        concat f.hidden_field :host_id
        concat f.hidden_field :attachment_id, value: attachment_id
        concat f.hidden_field :attachment_name
        concat f.hidden_field :attachment_type
        concat submit_tag nil, class: 'hidden-submit'
        concat(link_to('#', id:'submit-button', class: 'submit-btn js') do
          content_tag 'i', nil, class: 'icon-plus'
        end)
      end
    end
  end

  def remove_from_host_button(attachment, type, html_class=nil)
    html_class = html_class || 'btn-link btn-link-red'
    link_to attachment_path(attachment, attachment_type: type),
      class: "js #{html_class}",
      method: :delete,
      confirm: "Are you sure?" do
        content_tag 'i', nil, class: 'icon-remove'
      end
  end

  def return_to_host_link
    link_to "Back to #{@attach_to_adapter.host.class.name}",
    return_to_host_path(@attach_to_adapter.host),
    class: 'btn'
  end

  def return_to_host_path(host)
    case host
    when Message
      edit_message_path(host)
    when Group
      host
    end
  end

end
