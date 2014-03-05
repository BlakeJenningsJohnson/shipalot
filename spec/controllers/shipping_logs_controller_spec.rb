require 'spec_helper'

describe ShippingLogsController do

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
  before do
    request.env['HTTP_ACCEPT'] = 'application/json'
  end


  describe 'POST "ups"' do
    it 'should be successful' do
      VCR.use_cassette 'ups' do
        post :ups_shipping, data_params
      end
      expect(assigns(:ups)).to be_an_instance_of Array
    end
  end
end
