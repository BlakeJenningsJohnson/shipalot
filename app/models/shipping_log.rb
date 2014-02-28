class ShippingLog  < ActiveRecord::Base
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination

  def self.make_api_call(params_arg)
    parse_request_parameters(params_arg)
    ups = set_ups_client
    ups_rates = ups.find_rates(@origin, @destination, @package).rates
    parse_ups_rates(ups_rates)
  end

  def self.parse_request_parameters(
        params_arg
      )
    # @package = set_package(package_weight.to_i, [package_height.to_f, package_depth.to_f, package_length.to_f])
    @origin = set_origin(params_arg[:origin])
    @destination = set_destination(params_arg[:destination])
    @package = set_package(params_arg[:package])
      
  end


  def self.parse_ups_rates(ups_rates)
    # response =  ups_client.find_rates(@origin, @destination, @package)
   ups_rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
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

  def self.set_ups_client
    UPS.new(login: ENV['UPS_LOGIN'],
                  password: ENV['UPS_PASSWORD'],
                  key: ENV['UPS_KEY'])
  end

  # def self.usps
  #   # usps = USPS.new(login: )
  # end

end
