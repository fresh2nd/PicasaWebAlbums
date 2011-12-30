require 'test/unit'
require_relative '../../lib/picasawebalbums'

module PicasaWebAlbums
  class TestAlbums < Test::Unit::TestCase
  
    def setup
      @test_account = YAML::load(File.open(File.expand_path('test/config/test_account.yml')))
      @repo = PicasaWebAlbums.get_repository(@test_account["email"], @test_account["password"])
    end
  
    def test_get_all_albums
      albums = @repo.get_all_albums
      assert_equal @test_account["number_of_albums"], albums.count
    end
    
    def test_get_album_by_id
      album = @repo.get_album_by_id(@test_account["album"]["id"])
      assert_equal @test_account["album"]["title"], album.title
    end

    def test_get_album_by_title
      album = @repo.get_album_by_title(@test_account["album"]["title"])
      assert_equal @test_account["album"]["id"], album.id
    end
  
    def test_get_album_by_slug
      album = @repo.get_album_by_slug(@test_account["album"]["slug"])
      assert_equal @test_account["album"]["id"], album.id
    end

    def test_create_new_album
      album = Album.new
      album.title = "Programmatic album title"
      album.description = "This is my programmatic album description!"
      album.access = "private"
      status_code = @repo.create_album(album)
      assert_equal "201", status_code
      #update_album(album.title)
      delete_album
    end

    private
    
    def update_album(album_title)
      album = @repo.get_album_by_title(album_title)
      new_description = "Some new description"
      album.description = new_description
      @repo.update_album(album)
      album_retrieved = @repo.get_album_by_title("Programmatic album title")
      assert_equal new_description, album_retrieved.description
    end
    
    def delete_album
      album = @repo.get_album_by_title("Programmatic album title")
      if (album != nil)
        status_code = @repo.delete_album_by_id(album.id)
        assert_equal "200", status_code
      end
    end
    
  end
end