module AdapterHelper
  def adapter
    "#{attachable_type}Adapter".constantize.new(attachable)
  end
end
