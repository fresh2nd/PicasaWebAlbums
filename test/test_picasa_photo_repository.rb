require 'test/unit'
require 'shoulda'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestPicasaPhotoRepository < Test::Unit::TestCase
  
    context "get all albums" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return albums" do
        albums = repo.get_albums
        assert_equal 4, albums.count
      end
    end
  
    context "get album by id" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return an album" do
       album = repo.get_album_by_id(5461230096110151249)
       assert_equal "Banner Images", album.title
      end
    end
  
    context "get album by title" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return an album" do
       album = repo.get_album_by_title("Bio Profile Pics")
       assert_equal "5455332611886090353", album.id
      end
    end
  
    context "get album by slug" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return an album" do
       album = repo.get_album_by_slug("960x350")
       assert_equal "5577380987485671713", album.id
      end
    end
  
    context "get photos from album" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return at least 1 photo" do
       album = repo.get_album_by_id(5461230096110151249)
       photos = repo.get_photos(album)
       assert_equal true, photos.count > 0
      end
    end
  
    context "get photo by album and id" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return 1 photo" do
       album = repo.get_album_by_slug("960x350")
       photo = repo.get_photo_by_album_and_id(album, "5577383323184640194")
       assert_equal "Lake Joe Home.", photo.caption
      end
    end
  
  end
end