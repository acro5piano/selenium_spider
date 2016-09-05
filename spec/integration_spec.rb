require 'spec_helper'

describe SeleniumSpider::Controller do
  before :all do
    @pid = Process.spawn('bundle exec ruby spec/fixtures/app.rb')

    class SpecPagination < SeleniumSpider::Pagination
      next_link 'Next'
      detail_links 'li a[href*="detail"]'
    end

    class Spec < SeleniumSpider::Model
      register :AAA do |attr|
        attr.css = 'th:contains("AAA") + td'
      end
    end

    class SpecController < SeleniumSpider::Controller
      crawl_urls ['http://localhost:4567/list/1']
    end

    @controller = SpecController.new
  end

  after :all do
    Process.kill 9, @pid
  end

  it '#run' do
    expect { @controller.run }.not_to raise_error
  end
end


