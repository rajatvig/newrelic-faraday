if defined?(::Faraday) and not NewRelic::Control.instance['disable_faraday'] and not ENV['NEWRELIC_ENABLE'].to_s =~ /false|off|no/i
  Faraday::Connection.class_eval do
    def run_request_with_newrelic_trace(method, url, params, headers, &block)
      newrelic_host = parse_host_for_newrelic url
      metrics = ["External/#{newrelic_host}/Faraday::Connection/#{method}", "External/#{newrelic_host}/all", "External/all"]
      if NewRelic::Agent::Instrumentation::MetricFrame.recording_web_transaction?
        metrics << "External/allWeb"
      else
        metrics << "External/allOther"
      end
      self.class.trace_execution_scoped metrics do
        run_request_without_newrelic_trace(method, url, params, headers, &block)
      end
    end
    alias run_request_without_newrelic_trace run_request
    alias run_request run_request_with_newrelic_trace

    def parse_host_for_newrelic(url)
      begin
        return host if host
        URI(url).host.to_s
      rescue
        ''
      end
    end
  end
end
