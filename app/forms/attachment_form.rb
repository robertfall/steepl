class AttachmentForm
  include ActiveModel::Model

  attr_accessor :host, :attachment, :attachment_name

  def initialize(params)
    @host = params[:host_type].classify.constantize.find_by_id(params[:host_id])
    attachment_klass = params[:attachment_type].classify.constantize
    attachable_ids = params[:attachment_id].split(',')
    @attachables = attachment_klass.where(id: attachable_ids)
    @attachment_name = params[:attachment_name]
  end

  def join_objects
    @attachables.map do |attachable|
      object = host.send(attachment_name.pluralize.to_sym).build

      attachable_association = object.reflections.keys.find do |k|
        k !=  host.class.name.downcase.to_sym
      end

      object.send("#{attachable_association}=", attachable)
      object
    end
  end
end
