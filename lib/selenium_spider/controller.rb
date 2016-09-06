require "selenium_standalone_dsl"

module SeleniumSpider
  class Controller
    def self.crawl_urls(urls)
      @@urls = urls
    end

    def initialize
      @type = self.class.to_s.sub('Controller', '')
      @pagination_class = @type + 'Pagination'
    end

    def run
      @@urls.each_with_index do |url, idx|
        @pagination = SeleniumSpider.const_get(@pagination_class).new(url)
        @pagination.before_crawl idx

        while true
          @pagination.detail_links.each do |detail_link|
            extract_info detail_link
          end

          break if !@pagination.continue?
          @pagination.next
        end

        @pagination.quit
      end
    end

    def extract_info(detail_link)
      model = SeleniumSpider.const_get(@type).new(detail_link)
      puts model.output_as_json
      model.quit
    end
  end
end

