class MessageAdapter < AbstractController::Base
  include AbstractController::Rendering
  include AbstractController::Layouts
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths

  helper MembersHelper
  helper ApplicationHelper


  self.view_paths = "app/views"
  def initialize(object)
    @object = object
  end

  def to_html
    render "#{template_name}.html.slim", locals: { object: @object, adapter: self }
  end

  def to_text
    render "#{template_name}.txt.erb", locals: {object: @object, adapter: self }
  end

  def to_description
    @object.respond_to?(:description) ? @object.description : @object.to_s
  end
end
