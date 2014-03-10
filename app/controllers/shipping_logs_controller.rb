class ShippingLogsController < ApplicationController
  def create
  end

  def ups_shipping
    @ups = RateGetter.new(params, "ups").parsed_rates
    ShippingLog.create(request_dump: params.to_s, response_dump: @ups.to_s)

    respond_to do |format|
      format.json { render json: @ups, status: :ok }
      format.xml { render xml: { msg: "sorry" }, status: :bad_request }
    end
  end

  def fedex_shipping
    @fedex = RateGetter.new(params, "fedex").parsed_rates
    ShippingLog.create(request_dump: params.to_s, response_dump: @fedex.to_s)
    
    respond_to do |format|
      format.json { render json: @fedex, status: :ok }
      format.xml { render xml: { msg: "sorry" }, status: :bad_request }
    end
  end
end

# to test w/HTTParty, you can add these options:
# options = { origin: { country:  'US',
              #           state:  'CA',
              #           city:  'Beverly Hills',
              #           zip:  '90210'},
              # destination: { country: 'US',
              #                state: 'WA',
              #                city:  'Seattle',
              #                zip:  '98122' },
              # package: { weight: 100,
              #            dimensions: [5, 7, 6] } }
