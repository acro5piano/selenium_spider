require 'spec_helper'

describe SeleniumSpider do
  before :all do
    @pid = Process.spawn('bundle exec ruby spec/fixtures/app.rb')
  end

  after :all do
    Process.kill 9, @pid
  end

  it '' do
    expect(true).to be true
  end
end
