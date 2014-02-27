require 'spec_helper'

describe ShippingLog do

  let!(:params){ ['Seattle', 'US', 'WA', '98112',
                       'US', 'Englewood', 'CO', '80111',
                       '100', '10', '14', '4.5'] }

  describe "parse_request_parameters" do
    it "sets the origin" do
      request = ShippingLog.parse_request_parameters(*params)
      expect(request.origin).to be_an_instance_of(ActiveMerchant::Shipping::Location)
    end
  end


  describe "make_api_call" do
    xit "calls UPS" do
      ups = double
      ups.stub(:find_rates).and_return(:the_rates)
      expect(ShippingLog).to receive(:ups).and_return(ups)

      Request.make_api_call(*params)
    end
  end
end
