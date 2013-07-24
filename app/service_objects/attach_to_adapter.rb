class AttachToAdapter
  include ActiveModel::Model

  REQUIRED_FIELDS = [:host, :attachment_type, :attachment_name]
  attr_accessor :polymorphic, :host, :attachment_name, :attachment_type, :return_path

  def initialize(params)
    raise ArgumentError.new "#{REQUIRED_FIELDS.to_sentence} are all required" unless required_params_present?(params)

    @host = params.delete :host
    @attachment_type = params.delete :attachment_type
    @attachment_name = params.delete :attachment_name
  end

  def required_params_present?(params)
    REQUIRED_FIELDS.all? { |k| params.key? k }
  end

  def host_type
    @host.class
  end

  def host_id
    @host.id
  end

  def self.model_name
    'form'
  end
end
