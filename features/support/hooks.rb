###
# Base sur hooks.rb de l'application Emprunts
###

Before '@avec_depot_vide' do
  Biblio::DEPOT_DEFAUT ||= './.biblio.txt'
  Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }
  contenu = []

  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end

  @biblio_repository = Biblio::Biblio.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_vide' do
  @biblio_repository.fermer
  FileUtils.rm_f '.emprunts.txt'
end

Before '@avec_depot_emprunts_txt' do
  Biblio::DEPOT_DEFAUT ||= './.biblio.txt'
  Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }

  contenu = [ 'Sarah%@%Harry Potter%JK Rowling%',
              'Jean%@%Les Miserables%Victor Hugo%',
              'Celine%@%Silo%Hugh Howey%true' ]
  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end

  @biblio_repository = Biblio::Biblio.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_emprunts_txt' do
  @biblio_repository.fermer
  FileUtils.rm_f '.emprunts.txt'
end
