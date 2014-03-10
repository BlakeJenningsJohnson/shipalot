Shipalot::Application.routes.draw do

  post '/ups',    to: 'shipping_logs#ups_shipping'

  post '/fedex',  to: 'shipping_logs#fedex_shipping'
 
end
