# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{accidently}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["nkpart"]
  s.date = %q{2008-11-18}
  s.description = %q{}
  s.email = ["nkpart@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "TODO", "accidently.gemspec", "coverage/index.html", "coverage/lib-accidently-mad_hax_rb.html", "coverage/lib-accidently-method_invoker_rb.html", "coverage/lib-accidently-patches-kernel_rb.html", "coverage/lib-accidently-patches-thread_rb.html", "coverage/lib-accidently_rb.html", "etc/examples.rb", "etc/textmate_command.rb", "lib/accidently.rb", "lib/accidently/mad_hax.rb", "lib/accidently/method_invoker.rb", "lib/accidently/patches/kernel.rb", "lib/accidently/patches/thread.rb", "script/console", "script/destroy", "script/generate", "spec/accidently_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nkpart/accidently}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{accidently}
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
