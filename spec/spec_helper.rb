$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'selenium_spider'
require 'pry'

require_relative './fixtures/spec_classes'

RSpec.configure do |config|
  config.before :all do
    @headless = Headless.new(reuse: false, destroy_at_exit: true)
    @headless.start
    @pid = Process.spawn('bundle exec ruby spec/fixtures/app.rb')
  end

  config.after :all do
    @headless.destroy
    Process.kill 9, @pid
  end
end
