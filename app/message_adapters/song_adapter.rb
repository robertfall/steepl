class SongAdapter < MessageAdapter
  def template_name
    'message_adapters/song_adapter'
  end

  def to_s
    @object.name
  end
end
