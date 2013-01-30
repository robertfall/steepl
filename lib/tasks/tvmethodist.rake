namespace :tvmethodist do
  desc 'Update songs last_played_on date'
  task :process_sets => :environment do
    SongSet.process_sets!
  end

  desc 'Update song attachments'
  task :update_song_attachments => :environment do
    Song.update_attachments!
  end
end
