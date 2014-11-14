#!/usr/bin/env rspec

require 'spec_helper'

describe 'logstash' do
  let (:facts) { {
      :osfamily => 'RedHat'
  } }

  it { should contain_class 'logstash' }
end
