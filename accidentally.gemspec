# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{accidentally}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["nkpart"]
  s.date = %q{2008-11-19}
  s.description = %q{}
  s.email = ["nkpart@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "TODO", "accidentally.gemspec", "coverage/index.html", "coverage/lib-accidentally-mad_hax_rb.html", "coverage/lib-accidentally-method_invoker_rb.html", "coverage/lib-accidentally-patches-kernel_rb.html", "coverage/lib-accidentally-patches-thread_rb.html", "coverage/lib-accidentally_rb.html", "etc/examples.rb", "etc/textmate_command.rb", "lib/accidentally.rb", "lib/accidentally/mad_hax.rb", "lib/accidentally/method_invoker.rb", "lib/accidentally/patches/kernel.rb", "lib/accidentally/patches/thread.rb", "script/console", "script/destroy", "script/generate", "spec/accidentally_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nkpart/accidentally}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{accidentally}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nkpart-prohax>, [">= 1.0.1"])
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<nkpart-prohax>, [">= 1.0.1"])
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<nkpart-prohax>, [">= 1.0.1"])
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
