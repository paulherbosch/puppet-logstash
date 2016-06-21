require 'spec_helper_acceptance'

describe 'logstash' do
  describe 'running puppet code' do
    it 'should work with no errors' do
      pp = <<-EOS
        include yum
        include stdlib
        include stdlib::stages
        include profile::package_management

        class { 'cegekarepos' : stage => 'setup_repo' }

        Yum::Repo <| title == 'cegeka-unsigned' |>
        Yum::Repo <| title == 'cegeka-unsigned-i386' |>
        Yum::Repo <| title == 'cegeka-custom' |>
        Yum::Repo <| title == 'cegeka-custom-noarch' |>
        Yum::Repo <| title == 'logstash-1_4' |>

        class { 'logstash':
          version            => '1.4.2-1_2c0f5a1',
          status             => 'disabled',
          install_contrib    => true,
          contrib_version    => '1.4.2-1_efd53ef',
          init_defaults      => {
            'LS_USER'     => 'root'
          }
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
    describe package('logstash') do
      it { should be_installed }
    end
  end
end
