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
end
