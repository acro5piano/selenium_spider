require "selenium_standalone_dsl"

module SeleniumSpider
  class Pagination < SeleniumStandaloneDSL::Base
    def self.next_link(selector, find_by: :link_text)
      @@next_link = selector
      @@next_link_find_by = find_by
    end

    def self.detail_links(selector)
      @@detail_links = selector
    end

    def initialize(start_url)
      super(headless: true)
      visit start_url
      @uri = URI.parse(start_url)
    end

    def next
      click @@next_link, find_by: @@next_link_find_by
    end

    def detail_links
      search(@@detail_links).map(&->(x){x.attribute('href').value}).map(&->(x){full_url(x)})
    end

    def full_url(path)
      port = (@uri.port == 80) ? '' : ':' + @uri.port.to_s
      @uri.scheme + '://' + @uri.host + port + path
    end

    def continue?
      if has_element? @@next_link, find_by: @@next_link_find_by
        true
      else
        false
      end
    end
  end
end