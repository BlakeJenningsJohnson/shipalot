class ShippingLogsController < ApplicationController

  def create
  end

  def request
    ShippingLog.make_api_call(
      params[:origin_city],
      params[:origin_country],
      params[:origin_state],
      params[:origin_zip],
      params[:destination_country],
      params[:destination_city],
      params[:destination_state],
      params[:destination_zip],
      params[:package_weight],
      params[:package_height],
      params[:package_depth],
      params[:package_length]
    )


  end
end

# to test w/HTTParty, you can add these options: options = { country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210', country:  'US', state: 'WA', city:  'Seattle', postal_code:  '98122', package_weight: 100, package_height: 5, package_depth: 7, package_length: 6 }