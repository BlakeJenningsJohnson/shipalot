task :wakeup => :environment do
  puts "wakeup, silly little app!"
  options = { origin: {country:  'US', state:  'CA', city:  'Beverly Hills', zip:  '90210'}, destination: {country: 'US', state: 'WA', city:  'Seattle', zip:  '98122' }, package: { weight: 100, dimensions: [5, 7, 6] } }
  HTTParty.post("http://shipalot.herokuapp.com/ups.json", body: options.to_json, headers: {'Content-Type' => 'application/json'})
  puts "I AM AWAKE"
end