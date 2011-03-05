namespace :toastunes do
  
  namespace :read do
    
    # rake RAILS_ENV=production toastunes:read:artists[w2] --trace
    desc "load the given directory inside public/music, containing artist subdirectories"
    task :artists, [:library] => [:environment] do |t, args|
      args.with_defaults :library => 'w2'
      p = Toastunes::DirectoryParser.new(:library => args.library)
      p.parse!
    end
    
    # rake RAILS_ENV=production toastunes:read:artist[w2,Radiohead] --trace
    desc "load the given artist directory in public/music/[library]/[artist]"
    task :artist, [:dir, :artist] => [:environment] do |t, args|
      args.with_defaults :library => 'w2', :artist => 'Radiohead'
      p = Toastunes::DirectoryParser.new(:library => args.library)
      dir = File.join(Rails.root, 'public', 'music', args.library)
      p.parse_artist(dir, args.artist)
    end
    
    # rake RAILS_ENV=production toastunes:read:itunes --trace
    desc "edit config/toastunes.yml, then load the iTunes XML library"
    task :itunes => :environment do |t, args|
      Toastunes::TunesParser.parse!
    end
    
  end
  
end