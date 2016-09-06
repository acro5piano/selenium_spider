require 'selenium_standalone_dsl'
require 'json'

module SeleniumSpider
  class Model < SeleniumStandaloneDSL::Base
    attr_accessor :attributes
    @@attributes = {}

    def initialize(location)
      super()
      visit location
    end

    def self.register(attr_name_sym)
      @@attributes[attr_name_sym] = Attribute.new
      yield @@attributes[attr_name_sym]
    end

    def extract(attr_name_sym)
      attr = @@attributes[attr_name_sym]
      element_str = search(attr.css).inner_text
      if attr.match &&(match = element_str.match(/#{attr.match}/))
        element_str = match[match.length - 1]
      end
      if attr.sub
        element_str = element_str.sub(/#{attr.sub[:match]}/, attr.sub[:replace])
      end
      if attr.lambda
        element_str = attr.lambda.call(element_str)
      end
      element_str
    end

    def extract_all
      extracted = {}
      @@attributes.each do |key, value|
        extracted[key] = extract(key)
      end
      extracted
    end

    # TODO: save to database(sqlite)
    def save
    end

    def output_as_json
      JSON.dump extract_all
    end
  end

  class Attribute
    attr_accessor :css, :match, :lambda, :sub
  end
end

