# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "google_visualr"
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Winston Teo"]
  s.date = "2012-03-01"
  s.description = "This Ruby gem, GoogleVisualr, is a wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just Ruby; you don't have to write any JavaScript at all."
  s.email = ["winston.yongwei+google_visualr@gmail.com"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "https://github.com/winston/google_visualr"
  s.require_paths = ["lib"]
  s.rubyforge_project = "google_visualr"
  s.rubygems_version = "1.8.24"
  s.summary = "A Ruby wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just plain Ruby."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.15"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<rails>, [">= 3.0.9"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.15"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<rails>, [">= 3.0.9"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.15"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<rails>, [">= 3.0.9"])
  end
end
