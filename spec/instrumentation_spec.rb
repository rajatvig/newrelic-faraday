# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Faraday::Connection do
  stubs = Faraday::Adapter::Test::Stubs.new do |stub|
    stub.get('/')         { [200, {}, 'root'] }
    stub.get('/foo/bar')  { [200, {}, 'foo bar'] }
  end

  it 'add metrics to default categories' do
    Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
      metrics.should include("External/sushi.com/all")
      metrics.should include("External/all")
    end

    conn = Faraday::Connection.new "http://sushi.com"
    conn.get('/')
  end

  context 'adds the path to the category name' do
    it 'defaults to /' do
      Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
        metrics.should include("External/sushi.com/Faraday::Connection/get:/")
      end

      conn = Faraday::Connection.new "http://sushi.com"
      conn.get()
    end

    it 'gets the path from the connection' do
      Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
        metrics.should include("External/sushi.com/Faraday::Connection/get:/foo/bar")
      end

      conn = Faraday::Connection.new "http://sushi.com/foo/bar"
      conn.get()
    end

    it 'gets the path from the request' do
      Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
        metrics.should include("External/sushi.com/Faraday::Connection/get:/foo/bar")
      end

      conn = Faraday::Connection.new "http://sushi.com"
      conn.get('/foo/bar')
    end
  end

  it 'adds metrics to allWeb category' do
    pending "could not find a way to test the initializaton"
    NewRelic::Agent::Instrumentation::MetricFrame.should_receive(:recording_web_transaction?).and_return(true)
    Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
      metrics.should include("External/allWeb")
    end
  end

  it 'adds metrics to allOther category' do
    pending "could not find a way to test the initializaton"
    NewRelic::Agent::Instrumentation::MetricFrame.should_receive(:recording_web_transaction?).and_return(false)
    Faraday::Connection.should_receive(:trace_execution_scoped) do |metrics|
      metrics.should include("External/allOther")
    end
  end
end
