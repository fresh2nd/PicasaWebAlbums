require 'test/unit'
require 'shoulda'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestAlbums < Test::Unit::TestCase
  
    context "get all albums" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      albums = repo.get_all_albums
      
      should "return albums" do
        assert_equal 4, albums.count
      end
    end
  
    context "get album by id" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      album = repo.get_album_by_id("5461230096110151249")
      
      should "return an album" do
        assert_equal "Banner Images", album.title
      end
    end
  
    context "get album by title" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      album = repo.get_album_by_title("Bio Profile Pics")
      
      should "return an album" do
        assert_equal "5455332611886090353", album.id
      end
    end
  
    context "get album by slug" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      album = repo.get_album_by_slug("960x350")
      
      should "return an album" do
        assert_equal "5577380987485671713", album.id
      end
    end
  
  end
end