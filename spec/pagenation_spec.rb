require 'spec_helper'

describe SeleniumSpider::Pagination do
  before :all do
    @pid = Process.spawn('bundle exec ruby spec/fixtures/app.rb')

    class OtherPagination < SeleniumSpider::Pagination
      next_link ''
      detail_links ''
    end

    class SpecPagination < SeleniumSpider::Pagination
      next_link 'Next'
      detail_links 'li a[href*="detail"]'
    end

    @pagination = SpecPagination.new('http://localhost:4567/list/1')


  end

  after :all do
    Process.kill 9, @pid
    @pagination.quit
  end

  it 'visit next page' do
    @pagination.next
    expect(@pagination.driver.current_url).to eq 'http://localhost:4567/list/2'
  end

  it 'extract links for detail pages' do
    expect(@pagination.detail_links).to eq %w(
      http://localhost:4567/detail/1
      http://localhost:4567/detail/2
      http://localhost:4567/detail/3
    )
  end
end

