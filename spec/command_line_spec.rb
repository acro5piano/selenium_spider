require 'spec_helper'
require 'fileutils'

describe SeleniumSpider::CommandLine do

  before do
    FileUtils.cd 'spec/tmp'
    options = { site: 'yahoo' }
    @cli = SeleniumSpider::CommandLine.new(options)
  end

  after do
    FileUtils.rm_r 'app' if Dir.exist?('app')
  end

  describe '#generate' do
    it 'create directories' do
      @cli.generate
      expect(File.exist?('./app/models/yahoo.rb')).to be true
      expect(File.exist?('./app/paginations/yahoo_pagination.rb')).to be true
      expect(File.exist?('./app/controllers/yahoo_controller.rb')).to be true
    end
  end
end

