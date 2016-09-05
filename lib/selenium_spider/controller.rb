require "selenium_standalone_dsl"

module SeleniumSpider
  class Controller
    def self.crawl_urls(urls)
      @@urls = urls
    end

    def run
      @@urls.each do |url|
        type = self.class.to_s.sub('Controller', '')
        pagenation_class = type + 'Pagination'
        @pagination = SeleniumSpider.const_get(pagenation_class).new(url)
        while @pagination.continue?
          @pagination.detail_links.each do |detail_link|
            @model = SeleniumSpider.const_get(type).new(detail_link)
            @model.save
            @model.quit
          end
          @pagination.next
        end
        @pagination.quit
      end
    end
  end
end

