require "bundler/setup"
require "etna"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Clear stubs and expectation before each test
  config.before :each do
    Typhoeus::Expectation.clear
  end
end

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
