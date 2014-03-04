class ShippingLog  < ActiveRecord::Base
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination

  def add_response(returned_rates)
    update(response_dump: returned_rates.to_s)
  end

  def self.assign_data_and_call(params_arg, carrier, log)
    @origin = Location.new(params_arg[:origin])
    @destination = Location.new(params_arg[:destination])
    @package = Package.new(params_arg[:package][:weight], params_arg[:package][:dimensions])
    make_call(@origin, @destination, @package, carrier, log)
  end

  def self.make_call(origin, destination, package, carrier, log) #self method?
    client = self.send(carrier.to_sym) # set up a new API client

    returned_rates = client.find_rates(origin, destination, package).rates
    log.add_response(returned_rates)
    parse_rates(returned_rates)
  end

  def self.parse_rates(any_rates)
    any_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  end

  private

  def self.ups
    UPS.new(
      login: ENV['UPS_LOGIN'],
      password: ENV['UPS_PASSWORD'],
      key: ENV['UPS_KEY']
      )
  end

  def self.fedex
    FedEx.new(
      login: ENV['FEDEX_METER'],
      password: ENV['FEDEX_PASSWORD'],
      key: ENV['FEDEX_KEY'],
      account: ENV['FEDEX_ACCOUNT'],
      test: true
      )
  end
end
