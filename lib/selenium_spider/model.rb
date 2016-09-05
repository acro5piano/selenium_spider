require "selenium_standalone_dsl"

module SeleniumSpider
  class Model < SeleniumStandaloneDSL::Base
    attr_accessor :attributes
    @@attributes = {}

    def initialize(detail_link)
      super(headless: true)
      visit detail_link
    end

    def self.register(attr_name_sym)
      @@attributes[attr_name_sym] = Attribute.new
      yield @@attributes[attr_name_sym]
    end

    def extract(attr_name_sym)
      attr = @@attributes[attr_name_sym]
      element_str = search(attr.css).inner_text
      element_str = element_str.match(/#{attr.match}/)[0] if attr.match
      element_str
    end

    def extract_all
      extracted = {}
      @@attributes.each do |key, value|
        extracted[key] = extract(key)
      end
      extracted
    end

    # TODO: データベースに保存するようにする
    def save
      @@attributes.each do |key, value|
        puts extract(key)
      end
    end
  end

  class Attribute
    attr_accessor :css, :match
  end
end

