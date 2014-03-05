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


  describe 'POST "ups"' do
    it 'should return the rates' do
      
    end
  end

end