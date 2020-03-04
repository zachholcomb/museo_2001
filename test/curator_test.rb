require 'minitest/autorun'
require 'minitest/pride'
require './lib/artist'
require './lib/photograph'
require './lib/curator'

class CuratorTest < Minitest::Test
  def setup
    @curator = Curator.new
    @photo_1 = Photograph.new({
         id: "1",
         name: "Rue Mouffetard, Paris (Boy with Bottles)",
         artist_id: "1",
         year: "1954"
    })
    @photo_2 = Photograph.new({
         id: "2",
         name: "Moonrise, Hernandez",
         artist_id: "2",
         year: "1941"
    })
    @photo_3 = Photograph.new({
         id: "3",
         name: "Identical Twins, Roselle, New Jersey",
         artist_id: "3",
         year: "1967"
    })
    @photo_4 = Photograph.new({
         id: "4",
         name: "Monolith, The Face of Half Dome",
         artist_id: "3",
         year: "1927"
    })
    @artist_1 = Artist.new({
        id: "1",
        name: "Henri Cartier-Bresson",
        born: "1908",
        died: "2004",
        country: "France"
    })
    @artist_2 = Artist.new({
        id: "2",
        name: "Ansel Adams",
        born: "1902",
        died: "1984",
        country: "United States"
    })
    @artist_3 = Artist.new({
         id: "3",
         name: "Diane Arbus",
         born: "1923",
         died: "1971",
         country: "United States"
    })
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.photographs
    assert_equal [], @curator.artists
  end

  def test_it_can_load_photographs
    assert_equal [], @curator.photographs

    @curator.load_photographs('./data/photographs.csv')
    assert_equal 4, @curator.photographs.length
    assert_instance_of Photograph, @curator.photographs.last
    assert_equal "Rue Mouffetard, Paris (Boy with Bottles)",
    @curator.photographs.first.name
  end

  def test_it_can_load_artists
    assert_equal [], @curator.artists
    @curator.load_artists('./data/artists.csv')
    assert_equal 6, @curator.artists.length
    assert_instance_of Artist, @curator.artists.first
    assert_equal "Bill Cunningham", @curator.artists.last.name
  end

  def test_it_can_add_photographs
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    assert_equal [@photo_1, @photo_2], @curator.photographs
  end
  def test_it_can_add_artists
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    assert_equal [@artist_1, @artist_2], @curator.artists
  end

  def test_it_can_find_artist_by_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    assert_equal @artist_1, @curator.find_artist_by_id("1")
    assert_equal @artist_2, @curator.find_artist_by_id("2")
  end

  def test_it_can_find_all_photographs_by_artist_id
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)
    assert_equal [@photo_1], @curator.artists_photographs("1")
    assert_equal [@photo_2], @curator.artists_photographs("2")
    assert_equal [@photo_3, @photo_4], @curator.artists_photographs("3")
  end

  def test_it_can_get_photographs_by_artist
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    expected = {
      @artist_1 => [@photo_1],
      @artist_2 => [@photo_2],
      @artist_3 => [@photo_3, @photo_4]
    }
    assert_equal expected, @curator.photographs_by_artist
  end

  def test_it_can_find_artists_with_multiple_photographs
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    assert_equal ["Diane Arbus"], @curator.artists_with_multiple_photographs
  end

  def test_it_can_find_artists_by_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    assert_equal [@artist_2, @artist_3], @curator.artists_by_country("United States")
    assert_equal [@artist_1], @curator.artists_by_country("France")
    assert_equal [], @curator.artists_by_country("Argentina")
  end

  def test_it_can_find_photographs_taken_by_artists_from_a_given_country
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_artist(@artist_3)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)
    @curator.add_photograph(@photo_3)
    @curator.add_photograph(@photo_4)

    assert_equal [@photo_2, @photo_3, @photo_4],
    @curator.photographs_taken_by_artist_from("United States")

    assert_equal [], @curator.photographs_taken_by_artist_from("Argentina")
  end
end



# pry(main)> curator.load_artists()
#
# pry(main)> curator.photographs_taken_between(1950..1965)
# #=> [#<Photograph:0x00007fd986254740...>, #<Photograph:0x00007fd986254678...>]
#
# pry(main)> diane_arbus = curator.find_artist_by_id("3")
#
# pry(main)> curator.artists_photographs_by_age(diane_arbus)
# => {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
# ```
