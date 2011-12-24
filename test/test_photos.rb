require 'test/unit'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestPhotos < Test::Unit::TestCase
  
    def setup
      @repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
    end
  
    def test_get_photos_from_album
      album = @repo.get_album_by_id(5461230096110151249)
      photos = @repo.get_photos_by_album_id(album.id)
      assert_equal true, photos.count > 0
    end
  
    def test_get_photo_by_album_and_id
      album = @repo.get_album_by_slug("960x350")
      photo = @repo.get_photo_by_album_id_and_photo_id(album.id, "5577383323184640194")
      assert_equal "Lake Joe Home.", photo.caption
    end
  
    def test_get_photos_by_tags
      photos = @repo.get_photos_by_tags(['brick'])
      assert photos.count > 0
    end
  
  end
end