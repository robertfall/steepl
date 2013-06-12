class MessageAdapter < AbstractController::Base
 include AbstractController::Rendering
 include AbstractController::Layouts
 include AbstractController::Helpers
 include AbstractController::Translation
 include AbstractController::AssetPaths


 self.view_paths = "app/views"
 def initialize(object)
   @object = object
 end

   def to_html
    render template_name, locals: { object: @object, adapter: self }
   end

   def to_description
     @object.respond_to?(:description) ? @object.description : @object.to_s
   end
end
