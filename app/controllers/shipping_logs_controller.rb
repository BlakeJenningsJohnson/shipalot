class ShippingLogsController < ApplicationController

  def create
  end

  def ups_shipping
    ShippingLog.create(request_dump: params.to_s)

    @ups = ShippingLog.assign_data_and_call(params, 'ups')
    respond_to do |format|
      format.json { render json: @ups, status: :ok }
      format.xml { render xml: { msg: "sorry" }, status: :bad_request }
    end
  end

  def fedex_shipping
    ShippingLog.create(request_dump: params.to_s)

    @fedex = ShippingLog.assign_data_and_call(params, 'fedex')
    respond_to do |format|
      format.json { render json: @fedex, status: :ok }
      format.xml { render xml: { msg: "sorry" }, status: :bad_request }
    end
  end
end

# to test w/HTTParty, you can add these options: 
# options = { origin: {country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210'}, destination: {country: 'US', state: 'WA', city:  'Seattle', zip:  '98122' }, package: { weight: 100, dimensions: [5, 7, 6] } }