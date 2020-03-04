class Artist
  attr_reader :id, :name, :born, :died, :country

  def initialize(artist_info)
    @id = artist_info[:id]
    @name = artist_info[:name]
    @born = artist_info[:born]
    @died = artist_info[:died]
    @country = artist_info[:country]
  end

  def age_at_death
    @died.to_i - @born.to_i
  end
end
