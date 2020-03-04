require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'

class ArtistTest < Minitest::Test
  def setup
    attributes = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @artist = Artist.new(attributes)
  end

  def test_it_exists
    assert_instance_of Artist, @artist
  end

  def test_it_has_attributes
    assert_equal "2", @artist.id
    assert_equal "Ansel Adams", @artist.name
    assert_equal "1902", @artist.born
    assert_equal "1984", @artist.died
    assert_equal "United States", @artist.country
  end
end

# pry(main)> require './lib/photograph'
# #=> true
#
# pry(main)> require './lib/artist'
# #=> true
#
# pry(main)> attributes = {
#   id: "1",
#   name: "Rue Mouffetard, Paris (Boy with Bottles)",
#   artist_id: "4",
#   year: "1954"
# }
#
# pry(main)> photograph = Photograph.new(attributes)
# #=> #<Photograph:0x00007fc2d1050c80...>
#
# pry(main)> photograph.id
# #=> "1"
#
# pry(main)> photograph.name
# #=> "Rue Mouffetard, Paris (Boy with Bottles)"
#
# pry(main)> photograph.artist_id
# #=> "4"
#
# pry(main)> photograph.year
# #=> "1954"
#
# pry(main)>

# pry(main)> artist.age_at_death
# #=> 82
