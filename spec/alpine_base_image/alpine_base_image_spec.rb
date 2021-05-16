# frozen_string_literal: true

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

# rubocop:disable Metrics/BlockLength, RSpec/DescribeClass
describe 'Alpine base image Docker container', :extend_helpers do
  set :os, family: :alpine
  set :backend, :docker
  set :docker_image, 'alpine'

  %w[
    /usr/bin/envconsul
    /usr/bin/consul-template
    /usr/bin/gomplate
  ].each do |f|
    describe file(f) do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 755 }
      it { is_expected.to be_owned_by 'root' }
    end
  end

  %w[/tmp/envconsul.zip /tmp/consul-template.zip].each do |zip|
    describe file(zip) do
      it { is_expected.not_to exist }
    end
  end

  describe 'the operating system' do
    it 'is alpine' do
      expect(os_version).to include('alpine')
    end
  end

  describe package('curl') do
    it { is_expected.not_to be_installed }
  end

  describe command('consul-template -v') do
    its(:stderr) { is_expected.to match(/v0\.25\.1/) }
  end

  describe command('envconsul -v') do
    its(:stderr) { is_expected.to match(/v0\.11\.0/) }
  end

  describe command('gomplate -v') do
    its(:stdout) { is_expected.to match(/3\.8\.0/) }
  end
end
# rubocop:enable Metrics/BlockLength,RSpec/DescribeClass
