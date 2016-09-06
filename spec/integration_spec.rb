require 'spec_helper'

describe SeleniumSpider::Controller do
  before :all do
    @controller = SpecController.new
  end

  it '#run' do
    expect { @controller.run }.not_to raise_error
  end
end


