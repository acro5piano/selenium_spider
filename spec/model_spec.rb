require 'spec_helper'

describe SeleniumSpider::Model do
  before :all do
    @model = Spec.new(location: 'http://localhost:4567/detail/1')
  end

  after :all do
    @model.quit
  end

  it 'extract information from detail pages' do
    expect(@model.extract(:AAA)).to eq 'aaa'
  end

  it 'extract information from detail pages using regexp' do
    expect(@model.extract(:BBB)).to eq 'bbbc'
  end

  it 'extract all information from detail pages' do
    expect(@model.extract_all).to eq ({AAA: 'aaa',
                                       BBB: 'bbbc'})
  end
end


