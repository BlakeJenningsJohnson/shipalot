require 'spec_helper'

include ActiveMerchant::Shipping

describe ShippingLog do

  let(:data_params){ { origin: {country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210'}, destination: {country: 'US', state: 'WA', city:  'Seattle', zip:  '98122' }, package: { weight: 100, dimensions: [5, 7, 6] } } }

  let(:origin)      { ShippingLog.parse_origin_parameters(data_params[:origin]) }
  let(:destination) { ShippingLog.parse_destination_parameters(data_params[:destination]) }
  let(:package)     { ShippingLog.parse_package_parameters(data_params[:package]) }
# options = { origin: {country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210'}, destination: {country: 'US', state: 'WA', city:  'Seattle', zip:  '98122' }, package: { weight: 100, dimensions: [5, 7, 6] } }

  describe "parse data parameters" do

    describe "parse origin parameters" do
      it "sets the origin" do
        parsed_origin_data = ShippingLog.parse_origin_parameters(data_params[:origin])
        expect(parsed_origin_data).to be_an_instance_of(ActiveMerchant::Shipping::Location)
      end
    end

    describe "parse destination parameters" do
      it "sets the destination" do
        parsed_destination_data = ShippingLog.parse_destination_parameters(
          data_params[:destination])
        expect(parsed_destination_data).to be_an_instance_of(ActiveMerchant::Shipping::Location)
      end
    end

    describe "parse package parameters" do
      it "sets the package" do
        parsed_package_data = ShippingLog.parse_package_parameters(
          data_params[:package])
        expect(parsed_package_data).to be_an_instance_of(ActiveMerchant::Shipping::Package)
      end
    end
  end

  describe "make_call" do
    it "should attempt to find rates" do
      fake_rates = double("Fake Rates")

      UPS.any_instance.should_receive(:find_rates).with(origin, destination, package) { fake_rates }
      fake_rates.should_receive(:rates)
      ShippingLog.should_receive(:parse_rates)

      ShippingLog.make_call(origin, destination, package, "ups")
    end
  end

  describe "parse_rates" do
    xit "returns parsed rates" do
      fake_rates = double("fake_rates")
      ShippingLog.stub(:find_rates).and_return(:the_rates)
      expect(ShippingLog).to receive(:fake_rates).and_return(ups)

    #   ShippingLog.make_call(set_origin(data_params[:origin]), data_params[:destination], data_params[:package])
    end
  end
end
