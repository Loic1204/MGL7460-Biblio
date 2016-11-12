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

task :test_emprunter do
     sh "rake test TEST=test/emprunter_test.rb"     
end

##################################################
# Cucumber
##################################################
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



##################################################
# Nettoyage
##################################################
CLEAN << "biblio.log" << ".biblio.txt"
task :cleanxtra => [:clean] do
  remove_dir( 'tmp', true )
  remove_dir( 'coverage', true )
  remove_dir( 'html', true )
end
