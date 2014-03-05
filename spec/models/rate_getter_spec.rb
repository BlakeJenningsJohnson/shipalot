require 'spec_helper'

include ActiveMerchant::Shipping

describe RateGetter do
  # use_vcr_cassette "ups", :record => :new_episodes

  let(:data_params){ { origin:
                        { country: 'US',
                          state:  'CA',
                          city:  'Beverly Hills',
                          zip:  '90210'},
                       destination:
                        { country: 'US',
                          state: 'WA',
                          city:  'Seattle',
                          zip:  '98122' },
                       package:
                        { weight: 100,
                          dimensions: [5, 7, 6] }
                      } }

  let(:rate_object) { RateGetter.new(data_params,
                                     'ups')}

  describe 'origin' do
    it 'should return a Location object with valid origin info' do
      expect(rate_object.origin).to be_an_instance_of(ActiveMerchant::Shipping::Location)
    end
  end

  describe 'destination' do
    it 'should return a Location object' do
      expect(rate_object.destination).to be_an_instance_of(ActiveMerchant::Shipping::Location)
    end
  end

  describe 'package' do
    it 'should return a Package object' do
      expect(rate_object.package).to be_an_instance_of(ActiveMerchant::Shipping::Package)
    end
  end

  describe 'client' do
    it 'should set a client' do
      expect(rate_object.client).to be_an_instance_of(ActiveMerchant::Shipping::UPS)
    end
  end

  # these two tests are so slow! why?
  describe 'parsed_rates' do
    it 'parses rates correctly with a ups api call' do
      
      response = VCR.use_cassette 'ups' do
         rate_object.parsed_rates
       end
      expect(response).to be_an_instance_of Array 
    end 

    it 'parses rates correctly with a fedex api call' do
      rate_object = RateGetter.new(data_params, 'fedex')
      
      response = VCR.use_cassette 'fedex' do
         rate_object.parsed_rates
       end
      expect(response).to be_an_instance_of Array 
    end 
  end
end
