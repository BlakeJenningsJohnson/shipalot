class RateGetter
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination
  attr_accessor :params_hash, :carrier

  def initialize(params_hash, carrier)
    @params_hash = params_hash
    @carrier = carrier
  end

  def origin
    Location.new(params_hash[:origin])
  end

  def destination
    Location.new(params_hash[:destination])
  end

  def package
    Package.new(params_hash[:package][:weight], params_hash[:package][:dimensions])
  end

  def client
    self.send(carrier.to_sym)
  end

  def returned_rates
    client.find_rates(origin, destination, package).rates
  end

  def parsed_rates
    returned_rates.flatten.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  end

  private

  def ups
    UPS.new(
      login: ENV['UPS_LOGIN'],
      password: ENV['UPS_PASSWORD'],
      key: ENV['UPS_KEY']
      )
  end

  def fedex
    FedEx.new(
      login: ENV['FEDEX_METER'],
      password: ENV['FEDEX_PASSWORD'],
      key: ENV['FEDEX_KEY'],
      account: ENV['FEDEX_ACCOUNT'],
      test: true
      )
  end
end

