require 'spec_helper'

describe Request do
  describe "parse_request_parameters" do
    let!(:params){ ['Seattle', 'US', 'WA', '98112',
                  'US', 'Englewood', 'CO', '80111',
                  '100', '10', '14', '4.5'] }

    it "sets the origin" do
      request = Request.parse_request_parameters(*params)
      expect(request.origin).to be_an_instance_of(ActiveMerchant::Shipping::Location)
    end
  end
end
