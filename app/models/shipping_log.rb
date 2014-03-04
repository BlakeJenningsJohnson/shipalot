class ShippingLog  < ActiveRecord::Base
  # include ActiveMerchant::Shipping

  # attr_reader :origin, :package, :destination
  # attr_accessor :params_hash, :carrier

  # # before_validation :extract_params


  # # def extract_params
  # #   self.request_dump = params_hash.to_s
  # #   make_call
  # # end

  # def origin
  #   Location.new(params_hash[:origin])
  # end

  # def destination
  #   Location.new(params_hash[:destination])
  # end

  # def package
  #   Package.new(params_hash[:package][:weight], params_hash[:package][:dimensions])
  # end

  # def make_call
  #   self.add_response(returned_rates)
  #   parse_rates(returned_rates)
  # end

  # def client
  #   self.send(carrier.to_sym)
  # end

  # def returned_rates
  #   client.find_rates(origin, destination, package).rates
  # end

  # # def add_response(returned_rates)
  # #   response_dump = returned_rates.to_s
  # # end

  # def parse_rates(any_rates)
  #   any_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  # end

  # private

  # def ups
  #   UPS.new(
  #     login: ENV['UPS_LOGIN'],
  #     password: ENV['UPS_PASSWORD'],
  #     key: ENV['UPS_KEY']
  #     )
  # end

  # def fedex
  #   FedEx.new(
  #     login: ENV['FEDEX_METER'],
  #     password: ENV['FEDEX_PASSWORD'],
  #     key: ENV['FEDEX_KEY'],
  #     account: ENV['FEDEX_ACCOUNT'],
  #     test: true
  #     )
  # end
end
