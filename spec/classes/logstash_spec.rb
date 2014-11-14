#!/usr/bin/env rspec

require 'spec_helper'

describe 'logstash' do
  let (:facts) { {
      :osfamily => 'RedHat', :kernel => 'Linux', :operatingsystem => 'RedHat'
  } }

  it { should contain_class 'logstash' }
end
