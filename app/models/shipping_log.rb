class ShippingLog  < ActiveRecord::Base
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination

  def self.assign_data_and_call(params_arg, carrier)
    @origin = parse_origin_parameters(params_arg[:origin])
    @destination = parse_destination_parameters(params_arg[:destination])
    @package = parse_package_parameters(params_arg[:package])
    make_call(@origin, @destination, @package, carrier)
  end

  def self.parse_origin_parameters(origin_params)
    set_origin(origin_params)
  end

  def self.parse_destination_parameters(destination_params)
    set_destination(destination_params)
  end

  def self.parse_package_parameters(package_params)
    set_package(package_params)
  end

  def self.make_call(origin, destination, package, carrier) #self method?
    client = self.send(carrier.to_sym)
    returned_rates = client.find_rates(origin, destination, package).rates
    parse_rates(returned_rates)
  end

  def self.parse_rates(any_rates)
   any_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  end

  private

  def self.set_origin(origin_info)
    Location.new(origin_info)
  end

  def self.set_package(package_info)
    Package.new(package_info[:weight], package_info[:dimensions]) #this is in grams and LxWxD
  end

  def self.set_destination(destination_info)
    Location.new(destination_info)
  end

  def self.ups
    UPS.new(login: ENV['UPS_LOGIN'],
                  password: ENV['UPS_PASSWORD'],
                  key: ENV['UPS_KEY'])
  end

  def self.fedex
    FedEx.new(:login => ENV['FEDEX_METER'],
              :password => ENV['FEDEX_PASSWORD'], 
              key: ENV['FEDEX_KEY'], 
              account: ENV['FEDEX_ACCOUNT'], 
              :test => true)
  end
end
