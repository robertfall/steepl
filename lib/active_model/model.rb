module ActiveModel
  module Model
    def self.included(base)
      base.class_eval do
        extend  ActiveModel::Naming
        extend  ActiveModel::Translation
        include ActiveModel::Validations
        include ActiveModel::Conversion
      end
    end

    def assign_attributes(params={})
      params.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if params
    end

    def initialize(params={})
      self.assign_attributes(params)
    end

    def persisted?
      false
    end
  end
end
