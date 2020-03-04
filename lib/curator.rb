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

  def artists_with_multiple_photographs
    prolific_artists = @artists.find_all do |artist|
      photographs_by_artist[artist].length > 1
    end

    prolific_artists.map do |artist|
      artist.name
    end
  end

  def artists_by_country(country)
    @artists.find_all do |artist|
      artist.country == country
    end
  end

  def photographs_taken_by_artist_from(country)
    artists_by_country(country).flat_map do |artist|
      photographs_by_artist[artist]
    end
  end
end
