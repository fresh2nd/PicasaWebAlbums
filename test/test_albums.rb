require 'test/unit'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestAlbums < Test::Unit::TestCase
  
    def setup
      @repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
    end
  
    def test_get_all_albums
      albums = @repo.get_all_albums
      assert_equal 4, albums.count
    end
    
    def test_get_album_by_id
      album = @repo.get_album_by_id("5461230096110151249")
      assert_equal "Banner Images", album.title
    end

    def test_get_album_by_title
      album = @repo.get_album_by_title("Bio Profile Pics")
      assert_equal "5455332611886090353", album.id
    end
  
    def test_get_album_by_slug
      album = @repo.get_album_by_slug("960x350")
      assert_equal "5577380987485671713", album.id
    end
    
  end
end