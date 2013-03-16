class FamiliesController < ApplicationController
  respond_to :json
  def index
    @families = Family.includes(:members).search(params[:q]).order('name')
    respond_with @families
  end
end
