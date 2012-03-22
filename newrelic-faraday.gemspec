# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "newrelic-faraday"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Abbott"]
  s.date = "2012-03-22"
  s.description = "Faraday instrumentation for Newrelic."
  s.email = ["eric.abbott@viximo.com"]
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["README.txt", "lib/newrelic-faraday.rb", "lib/newrelic_faraday/instrumentation.rb", "lib/newrelic_faraday/version.rb", "newrelic-faraday.gemspec"]
  s.homepage = "http://github.com/Viximo/newrelic-faraday"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "newrelic-faraday"
  s.rubygems_version = "1.5.3"
  s.summary = "Faraday instrumentation for Newrelic."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["< 0.8"])
      s.add_runtime_dependency(%q<faraday>, [">= 0.6"])
      s.add_runtime_dependency(%q<newrelic_rpm>, ["~> 3.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
    else
      s.add_dependency(%q<faraday>, ["< 0.8"])
      s.add_dependency(%q<faraday>, [">= 0.6"])
      s.add_dependency(%q<newrelic_rpm>, ["~> 3.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
    end
  else
    s.add_dependency(%q<faraday>, ["< 0.8"])
    s.add_dependency(%q<faraday>, [">= 0.6"])
    s.add_dependency(%q<newrelic_rpm>, ["~> 3.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
  end
end
