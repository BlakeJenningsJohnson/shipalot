require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/cassette_library'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { record: :once }
end