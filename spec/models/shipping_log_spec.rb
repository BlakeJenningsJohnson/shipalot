require 'spec_helper'

include ActiveMerchant::Shipping

describe ShippingLog do
  # use_vcr_cassette "ups", :record => :new_episodes

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

  describe "REMOTE parse_rates" do
    it "parses rates correctly" do

      response = VCR.use_cassette 'ups' do
        ShippingLog.make_call(origin, destination, package, "ups")
      end

      expect(response).to be_an_instance_of(Array)
      expect(response.first).to eq ["UPS Ground", 1077, nil]
      expect(response.last.first).to eq("UPS Next Day Air Early A.M.")
    end
  end
end
