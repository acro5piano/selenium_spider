$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'selenium_spider'
require 'pry'

RSpec.configure do |config|
  config.before :all do
    @headless = Headless.new(reuse: false, destroy_at_exit: true)
    @headless.start
  end

  config.after :all do
    @headless.destroy
  end
end
