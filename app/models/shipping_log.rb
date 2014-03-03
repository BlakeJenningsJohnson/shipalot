class ShippingLog  < ActiveRecord::Base
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination
  #make_ups_call needs logic from make_api_call
  #add method in controller to do call, which is separate from parsing params? (I think this could still be one method, but I'll separate them for now)
  #add make_fedex_call 
  #add make_all_the_calls

  # def self.make_big_api_call(params_arg)
  #   parse_request_parameters(params_arg) #this will move out of here if we separate calls?
  #   make_fedex_call(@origin, @destination, @package)
  #   make_ups_call(@origin, @destination, @package)
  #   # make_usps_call(params_arg)
  # end

  def self.call(params_arg, delivery_carrier)
    parse_request_parameters(params_arg)
    make_call(@origin, @destination, @package, delivery_carrier)
  end

  # def self.fedex_call(params_arg)
  #   parse_request_parameters(params_arg)
  #   make_fedex_call(@origin, @destination, @package)
  # end

  def self.parse_request_parameters(params_arg)
    @origin = set_origin(params_arg[:origin])
    @destination = set_destination(params_arg[:destination])
    @package = set_package(params_arg[:package])    
  end
  
  def self.make_call(origin, destination, package, carrier) #self method?
    client = self.send(:carrier)
    rates = client.find_rates(origin, destination, package).rates
    parse_rates(rates)
  end

  def self.parse_rates(any_rates)
   any_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  end

  def self.make_fedex_call(origin, destination, package) #self method?
    fedex = set_fedex_client
    fedex_rates = fedex.find_rates(origin, destination, package).rates
    parse_rates(fedex_rates)
  end

  # def self.parse_fedex_rates(fedex_rates)
  #   # response =  ups_client.find_rates(@origin, @destination, @package)
  #  fedex_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  # end

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
  # def self.usps
  #   # usps = USPS.new(login: )
  # end

end
