# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','biblio','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'biblio'
  s.version = Biblio::VERSION
  s.author = 'Guy Tremblay'
  s.email = 'tremblay.guy@uqam.ca'
  s.homepage = 'http://www.labunix.uqam.ca/~tremblay'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Petit systeme de gestion de prets de livres'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options << '--title' << 'biblio' << '--main' << 'README.rdoc' << '-ri'

  s.bindir = 'bin'

  s.executables << 'biblio'

  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_development_dependency('simplecov')
  
  s.add_runtime_dependency('gli','2.12.0')
  s.add_runtime_dependency('tlsmail')
end
