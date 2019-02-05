require 'spec_helper'

# Some helpers for rspec
module Helpers
  def os_version
    command('cat /etc/os-release').stdout
  end
end

RSpec.configure do |c|
  c.include Helpers
  c.extend Helpers
end

# rubocop:disable Metrics/BlockLength
describe 'Alpine base image Docker container', :extend_helpers do
  set :os, family: :alpine
  set :backend, :docker
  set :docker_image, 'alpine-base'

  describe file('/usr/bin/consul-template') do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
  end

  describe file('/usr/bin/envconsul') do
    it { should be_file }
    it { should be_mode 755 }
    it { should be_owned_by 'root' }
  end

  %w[/tmp/envconsul.zip /tmp/consul-template.zip].each do |zip|
    describe file(zip) do
      it { should_not exist }
    end
  end

  describe 'the operating system' do
    it 'is alpine' do
      expect(os_version).to include('alpine')
    end
  end

  describe package('curl') do
    it { should_not be_installed }
  end

  describe command('consul-template -v') do
    its(:stderr) { should match(/v0\.19\.5/) }
  end

  describe command('envconsul -v') do
    its(:stderr) { should match(/v0\.7\.3/) }
  end
end
