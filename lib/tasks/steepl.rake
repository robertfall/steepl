namespace :steepl do
  desc 'Update songs last_played_on date'
  task :process_sets => :environment do
    SongSet.process_sets!
  end

  desc 'Update song attachments'
  task :update_song_attachments => :environment do
    Song.update_attachments!
  end

  desc 'Update Post Receive Hook'
  task :update_post_receive_hook => :environment do
    `scp #{Rails.root}/config/git-post-receive afrihost:steepl.git/hooks/post-receive`
  end

  desc "Symlink Assets without digest"
  task non_digested: :environment do
    assets = Dir.glob(File.join(Rails.root, 'public/assets/**/*'))
    regex = /(-{1}[a-z0-9]{32}*\.{1}){1}/
      assets.each do |file|
      next if File.directory?(file) || file !~ regex

      source = file.split('/')
      source.push(source.pop.gsub(regex, '.'))

      non_digested = File.join(source)
      FileUtils.cp(file, non_digested)
      end
  end
end
