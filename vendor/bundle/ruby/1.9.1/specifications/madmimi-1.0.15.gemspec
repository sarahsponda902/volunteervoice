# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "madmimi"
  s.version = "1.0.15"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nicholas Young", "Marc Heiligers"]
  s.date = "2011-03-20"
  s.description = "Send emails, track statistics, and manage your subscriber base with ease."
  s.email = "nicholas@madmimi.com"
  s.extra_rdoc_files = ["LICENSE", "README.rdoc"]
  s.files = ["LICENSE", "README.rdoc"]
  s.homepage = "http://github.com/madmimi/madmimi-gem"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Mad Mimi API wrapper for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<crack>, ["> 0.1.7"])
      s.add_development_dependency(%q<jeweler>, ["> 1.4"])
      s.add_development_dependency(%q<fakeweb>, ["> 1.2"])
      s.add_development_dependency(%q<shoulda>, ["> 2.10"])
    else
      s.add_dependency(%q<crack>, ["> 0.1.7"])
      s.add_dependency(%q<jeweler>, ["> 1.4"])
      s.add_dependency(%q<fakeweb>, ["> 1.2"])
      s.add_dependency(%q<shoulda>, ["> 2.10"])
    end
  else
    s.add_dependency(%q<crack>, ["> 0.1.7"])
    s.add_dependency(%q<jeweler>, ["> 1.4"])
    s.add_dependency(%q<fakeweb>, ["> 1.2"])
    s.add_dependency(%q<shoulda>, ["> 2.10"])
  end
end
