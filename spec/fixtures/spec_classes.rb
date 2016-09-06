class SpecPagination < SeleniumSpider::Pagination
  next_link 'Next'
  detail_links 'li a[href*="detail"]'
end

class Spec < SeleniumSpider::Model
  register :AAA do |attr|
    attr.css = 'th:contains("AAA") + td'
  end
  register :BBB do |attr|
    attr.css = 'th:contains("BBB") + td'
    attr.match = '^b+c'
  end
end

class SpecController < SeleniumSpider::Controller
  crawl_urls ['http://localhost:4567/list/1']
end


