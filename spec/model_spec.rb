require 'spec_helper'

describe SeleniumSpider::Model do
  before :all do
    @pid = Process.spawn('bundle exec ruby spec/fixtures/app.rb')

    class Spec < SeleniumSpider::Model
      register :AAA do |attr|
        attr.css = 'th:contains("AAA") + td'
      end
      register :BBB do |attr|
        attr.css = 'th:contains("BBB") + td'
        attr.match = '^b+c'
      end
    end

    @model = Spec.new('http://localhost:4567/detail/1')
  end

  after :all do
    Process.kill 9, @pid
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


