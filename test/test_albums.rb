require 'test/unit'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestAlbums < Test::Unit::TestCase
  
    def setup
      @repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
    end
  
    def test_get_all_albums
      albums = @repo.get_all_albums
      assert_equal 3, albums.count
    end
    
    def test_get_album_by_id
      album = @repo.get_album_by_id("5461230096110151249")
      assert_equal "Banner Images", album.title
    end

    def test_get_album_by_title
      album = @repo.get_album_by_title("Bio Profile Pics")
      assert_equal "5689734429356072049", album.id
    end
  
    def test_get_album_by_slug
      album = @repo.get_album_by_slug("960x350")
      assert_equal "5577380987485671713", album.id
    end
    
    def test_create_new_album
      album = Album.new
      album.title = "Programmatic album title"
      album.description = "This is my programmatic album description!"
      album.access = "private"
      status_code = @repo.create_album(album)
      assert_equal "201", status_code
      delete_album
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