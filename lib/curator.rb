class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(artist_id)
    @artists.find do |artist|
      artist.id == artist_id
    end
  end

  def artists_photographs(artist_id)
    @photographs.find_all do |photo|
      photo.artist_id == artist_id
    end
  end

  def photographs_by_artist
    @artists.reduce({}) do |acc, artist|
      acc[artist] = artists_photographs(artist.id)
      acc
    end
  end
end
