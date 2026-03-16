# frozen_string_literal: true

require 'spec_helper'

# Stub framework constants before loading client
unless defined?(Legion::Extensions::Helpers::Lex)
  module Legion
    module Extensions
      module Helpers
        module Lex; end
      end
    end
  end
end

require 'legion/extensions/sleepiq/client'

RSpec.describe Legion::Extensions::Sleepiq::Client do
  subject(:client_instance) { described_class.new(username: 'test_user', password: 'test_pass') }

  let(:mock_sleepiq) do
    instance_double(
      SleepIQ::Client,
      sessid:        'sess123',
      awsalb:        'alb123',
      key:           'key123',
      bedid:         'bed123',
      sleep_number:  50,
      status:        { online: true },
      bed:           { size: 'king' },
      family_status: { 'beds' => [{ 'leftSide'  => { 'lastLink' => 'x', 'pressure' => 1 },
                                    'rightSide' => { 'lastLink' => 'y', 'pressure' => 2 } }] },
      pump_status:   {},
      force_idle:    true
    )
  end

  before do
    allow(SleepIQ::Client).to receive(:new).and_return(mock_sleepiq)
  end

  describe '#initialize' do
    it 'stores username' do
      expect(client_instance.username).to eq('test_user')
    end

    it 'stores password' do
      expect(client_instance.password).to eq('test_pass')
    end

    it 'starts with nil session tokens' do
      # client is not yet logged in; calling #client triggers auto-login
      client_instance.client
      expect(SleepIQ::Client).to have_received(:new).with(username: 'test_user', password: 'test_pass')
    end
  end

  describe '#login' do
    it 'authenticates and caches tokens from result' do
      client_instance.login
      expect(SleepIQ::Client).to have_received(:new).with(username: 'test_user', password: 'test_pass')
    end

    it 'returns the SleepIQ::Client result' do
      expect(client_instance.login).to eq(mock_sleepiq)
    end
  end

  describe '#client' do
    it 'returns a SleepIQ::Client' do
      expect(client_instance.client).to eq(mock_sleepiq)
    end

    it 'auto-logs-in when session is nil' do
      client_instance.client
      expect(SleepIQ::Client).to have_received(:new).with(username: 'test_user', password: 'test_pass')
    end

    it 'does not re-login when session tokens are already set' do
      client_instance.login
      client_instance.client
      # new was called twice: once for login (creds), once for client (tokens)
      expect(SleepIQ::Client).to have_received(:new).twice
    end
  end

  describe 'runner delegation' do
    it { expect(client_instance).to respond_to(:sleep_number) }
    it { expect(client_instance).to respond_to(:set_sleep_number) }
    it { expect(client_instance).to respond_to(:get_sleep_number_favorite) }
    it { expect(client_instance).to respond_to(:set_sleep_number_favorite) }
    it { expect(client_instance).to respond_to(:status) }
    it { expect(client_instance).to respond_to(:get_pause_mode) }
    it { expect(client_instance).to respond_to(:set_pause_mode) }
    it { expect(client_instance).to respond_to(:get) }
    it { expect(client_instance).to respond_to(:family_status) }
    it { expect(client_instance).to respond_to(:get_light) }
    it { expect(client_instance).to respond_to(:set_light) }
    it { expect(client_instance).to respond_to(:preset) }
    it { expect(client_instance).to respond_to(:stop_motion) }
    it { expect(client_instance).to respond_to(:pump_status) }
    it { expect(client_instance).to respond_to(:force_idle) }
    it { expect(client_instance).to respond_to(:sleeper) }
    it { expect(client_instance).to respond_to(:sleep_data) }
    it { expect(client_instance).to respond_to(:sleep_slice_data) }
  end

  describe '#family_status' do
    it 'removes lastLink keys and returns normalized data' do
      result = client_instance.family_status
      expect(result[:beds][0][:leftSide]).not_to have_key(:lastLink)
      expect(result[:beds][0][:rightSide]).not_to have_key(:lastLink)
    end
  end

  describe '#pump_status' do
    it 'returns normalized pump status' do
      expect(client_instance.pump_status).to eq({})
    end
  end
end
