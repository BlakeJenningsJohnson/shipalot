class ShippingLogsController < ApplicationController

  def create
  end

  def shipping_info
    @ups = ShippingLog.make_big_api_call(
      params
    )
     respond_to do |format|
      format.json { render json: @ups, status: :ok }
      format.xml { render xml: { msg: "sorry" }, status: :bad_request }
    end
  end
end

# to test w/HTTParty, you can add these options: 
# options = { origin: {country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210'}, destination: {country: 'US', state: 'WA', city:  'Seattle', zip:  '98122' }, package: { weight: 100, dimensions: [5, 7, 6] } }