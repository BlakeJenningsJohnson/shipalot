class ShippingLog  < ActiveRecord::Base
  include ActiveMerchant::Shipping

  attr_reader :origin, :package, :destination

  def self.make_api_call(*args)
    parse_request_parameters(*args)
    ups.find_rates(@origin, @destination, @package)
    # usps.find_rates(@origin, @destination, @package)
    # find_ups_rates(new_ups_client)

    # fedex.find_rates . . .
  end

  def self.parse_request_parameters(
        origin_city, origin_country, origin_state, origin_zip,
        destination_country, destination_city, destination_state, destination_zip,
        package_weight, package_height, package_depth, package_length
      )
      # current_request = self.new #self is optional here
    @origin = set_origin(origin_country, origin_state, origin_city, origin_zip)
    @destination = set_destination(destination_country, destination_state, destination_city, destination_zip)
    @package = set_package(package_weight.to_i, [package_height.to_f, package_depth.to_f, package_length.to_f])
      
  end


  # def find_ups_rates(ups_client)
  #   response =  ups_client.find_rates(@origin, @destination, @package)

  #   response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price, rate.delivery_date]}
  # end

  private

  def new_ups_client
    UPS.new(login:        ENV['UPS_LOGIN'],
                 password: ENV['UPS_PASSWORD'],
                 key:          ENV['UPS_KEY'])
  end

  def self.set_origin(origin_country, origin_state, origin_city, origin_zip)
    Location.new(country: origin_country,
                        state: origin_state,
                        city: origin_city,
                        zip: origin_zip)
  end

  def self.set_package(package_weight, package_dimensions)
    Package.new(package_weight, package_dimensions) #this is in grams and LxWxD
  end

  def self.set_destination(destination_country, destination_city, destination_state, destination_zip)
    Location.new(country: destination_country,
                                  state: destination_state,
                                   city: destination_city,
                                    zip: destination_zip)
  end

  def self.ups
    ups = UPS.new(login: ENV['UPS_LOGIN'], 
                  password: ENV['UPS_PASSWORD'],
                  key: ENV['UPS_KEY'])
  end

  def self.fedex
  # def self.usps
  #   # usps = USPS.new(login: )
  # end

end
