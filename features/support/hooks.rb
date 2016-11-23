Before '@avec_depot_vide' do
  contenu = []
  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end
  
  Biblio::DEPOT_DEFAUT ||= './.biblio.txt' unless Biblio::DEPOT_DEFAUT
  Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }

  @biblio_repository = Biblio::Biblio.ouvrir( '.emprunts.txt' )
  @emprunts_repository = Biblio::Emprunts.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_vide' do
  FileUtils.rm_f '.emprunts.txt'
end

Before '@avec_depot_emprunts_txt' do
  contenu = [ 'Sarah%@%Harry Potter%JK Rowling%',
              'Jean%@%Les Miserables%Victor Hugo%',
              'Celine%@%Silo%Hugh Howey%true' ]
  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end

  Biblio::DEPOT_DEFAUT ||= './.biblio.txt'
  Biblio::ServicesExternes.emprunts ||= {
  ".txt" => Biblio::EmpruntsTxt,
  ".yaml" => Biblio::EmpruntsYAML }

  @biblio_repository = Biblio::Biblio.ouvrir( '.emprunts.txt' )
  @emprunts_repository = Biblio::Emprunts.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_emprunts_txt' do
  FileUtils.rm_f '.emprunts.txt'
end
