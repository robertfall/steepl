class OfferingsController < ApplicationController
  before_filter { |c| c.authorize(:edit_offerings) }
  respond_to :html, :json
  before_filter :load_offerings, only: [:new, :create]

  def new
    @form = OfferingForm.new(given_on: params[:given_on])
  end

  def create
    @form = OfferingForm.new(params[:form])
    @form.save
    respond_with(@form, location: new_offering_path(given_on: @form.given_on))
  end

  def destroy
    @offering = Offering.find(params[:id])
    @offering.destroy
    redirect_to action: :new, notice: 'Offering Deleted'
  end

  private
  def load_offerings
    @offerings = Offering.created_today
  end
end
