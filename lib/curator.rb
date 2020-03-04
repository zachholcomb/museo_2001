require_relative 'photograph'
require_relative 'artist'
require 'csv'

class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def load_photographs(photo_file_path)
    csv = CSV.read(photo_file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      new_photo = Photograph.new(row)
      add_photograph(new_photo)
    end
  end

  def load_artists(artist_file_path)
    csv = CSV.read(artist_file_path, headers: true, header_converters: :symbol)

    csv.map do |row|
      new_artist = Artist.new(row)
      add_artist(new_artist)
    end
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

  def photographs_taken_between(year_range)
    years = year_range.to_a
    @photographs.find_all do |photo|
      years.include?(photo.year.to_i)
    end
  end

  def artist_age_by_photo(photo, artist)
    photo.year.to_i - artist.born.to_i
  end

  def artists_photographs_by_age(artist)
    artists_photographs(artist.id).reduce({}) do |acc, photo|
      acc[artist_age_by_photo(photo, artist)] = photo.name
      acc
    end
  end
end
