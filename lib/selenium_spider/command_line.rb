#!/usr/bin/env ruby

require 'active_support'
require 'active_support/core_ext'

$LOAD_PATH.unshift File.expand_path('../../../app', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../../examples', __FILE__)

module SeleniumSpider
  class CommandLine
    def self.execute(options)
      new(options)
    end

    def initialize(options)
      @options = options

      if @options[:command] == 'run'
        run
      elsif @options[:command] == 'generate'
        generate
      end
    end

    def run
      if @options[:headless]
        headless = Headless.new(reuse: false, destroy_at_exit: true)
        headless.start
      end

      require "models/#{@options[:site]}"
      require "paginations/#{@options[:site]}_pagination"
      require "controllers/#{@options[:site]}_controller"

      class_name = @options[:site].classify + 'Controller'
      Object.const_get(class_name).new.run

      if @options[:headless]
        headless.destroy
      end
    end

    def generate
      mkdir_if_not_exist './app/models/'
      mkdir_if_not_exist './app/paginations/'
      mkdir_if_not_exist './app/controllers/'

      gem_root = File.expand_path('../lib', ENV['BUNDLE_GEMFILE'])
      generation_path = "#{gem_root}/selenium_spider/generations"
      cp_if_not_exist "#{generation_path}/model.rb", "./app/models/#{@options[:site]}.rb"
      cp_if_not_exist "#{generation_path}/pagination.rb", "./app/paginations/#{@options[:site]}_pagination.rb"
      cp_if_not_exist "#{generation_path}/controller.rb", "./app/controllers/#{@options[:site]}_controller.rb"
    end

    private

      def mkdir_if_not_exist(path)
        return if File.exist? path

        require 'fileutils'
        FileUtils.mkdir_p './app/models/'
      end

      def cp_if_not_exist(from, to)
        if File.exist? to
          puts 'Skip: ' + to
          return
        end

        FileUtils.cp from, to
      end
  end
end

