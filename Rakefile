###############################################################
# Fichier genere initialement par 'gli scaffold'.
###############################################################

require 'rubygems'
require 'rake/clean'
require 'rubygems/package_task'
require 'rdoc/task'
require 'cucumber'
require 'cucumber/rake/task'
require 'biblio'

BIBLIO = 'bundle exec bin/biblio'

##################################################
# default
##################################################

task :default => [:spec]

##################################################

task :test_emprunteur do
     sh "rake test TEST=test/emprunteur_test.rb"     
end

task :test_lister do
     sh "rake test TEST=test/lister_test.rb"     
end

task :test_emprunts do
     sh "rake test TEST=test/emprunts_test.rb"     
end

task :test_trouver do
     sh "rake test TEST=test/trouver_test.rb"     
end

task :biblio_features do
  sh "cucumber features/biblio-emprunteur.feature"
  sh "cucumber features/biblio-indiquer_perte.feature"
  sh "cucumber features/biblio-init.feature"
  sh "cucumber features/biblio-lister.feature"
  sh "cucumber features/biblio-rapporter.feature"
  sh "cucumber features/biblio-trouver.feature"
  sh "cucumber features/biblio-selectionner.feature"
  sh "cucumber features/biblio-emprunter.feature"
end

##################################################
# Cucumber
##################################################
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'Your application title'
end

spec = eval(File.read('biblio.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end

CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

desc 'Run features tagged as work-in-progress (@wip)'
Cucumber::Rake::Task.new('features:wip') do |t|
  tag_opts = ' --tags ~@pending'
  tag_opts = ' --tags @wip'
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty -x -s#{tag_opts}"
  t.fork = false
end

task :cucumber => :features
task 'cucumber:wip' => 'features:wip'
task :wip => 'features:wip'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end


##################################################
# Nettoyage
##################################################
CLEAN << "biblio.log" << ".biblio.txt"
task :cleanxtra => [:clean] do
  remove_dir( 'tmp', true )
  remove_dir( 'coverage', true )
  remove_dir( 'html', true )
end
