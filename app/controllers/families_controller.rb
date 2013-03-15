class FamiliesController < ApplicationController
  respond_to :json
  def index
    @families = Family.includes(:members).order('name')
    respond_with @families
  end
end
