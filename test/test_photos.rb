require 'test/unit'
require 'shoulda'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestPhotos < Test::Unit::TestCase
  
    context "get photos from album" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      album = repo.get_album_by_id(5461230096110151249)
      photos = repo.get_photos_by_album_id(album.id)
      
      should "return at least 1 photo" do
        assert_equal true, photos.count > 0
      end
    end
  
    context "get photo by album and id" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      album = repo.get_album_by_slug("960x350")
      photo = repo.get_photo_by_album_id_and_photo_id(album.id, "5577383323184640194")
      
      should "return 1 photo" do
        assert_equal "Lake Joe Home.", photo.caption
      end
    end
  
  end
end