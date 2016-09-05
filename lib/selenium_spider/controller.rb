require "selenium_standalone_dsl"

module SeleniumSpider
  class Controller
    def self.crawl_urls(urls)
      @@urls = urls
    end

    def run
      @@urls.each do |url|
        type = self.class.to_s.sub('Controller', '')
        class_name = type + 'Pagination'
        @pagination = SeleniumSpider.const_get(class_name).new(url)
        @pagination.next
        @pagination.detail_links.each do |detail_link|
          @model = SeleniumSpider.const_get(type).new(detail_link)
          @model.extract(:AAA)
          @model.extract_all
          @model.save
        end
      end
    end
  end
end

