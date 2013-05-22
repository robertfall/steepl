class SongSetAdapter < MessageAdapter
  def template_name
    'message_adapters/song_set_adapter'
  end

  def to_s
    song_adapters.join("\r\n")
  end

  def song_adapters
    @object.songs.map { |song| SongAdapter.new(song) }
  end
end
