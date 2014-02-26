class FamiliesController < ApplicationController
  respond_to :html, :json

  def index
    @families = Family.includes(members: :addresses).search(params[:q]).order('name')
    respond_with @families
  end

  def show
    @family = Family.find(params[:id])
  end

  def destroy
    @family = Family.find(params[:id])
    @family.destroy
    redirect_to families_path
  end
end
