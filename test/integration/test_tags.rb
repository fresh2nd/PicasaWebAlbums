require 'test/unit'
require 'shoulda'
require_relative '../../lib/picasawebalbums'

module PicasaWebAlbums
  class TestTags < Test::Unit::TestCase
    
    def setup
      @test_account = YAML::load(File.open(File.expand_path('test/config/test_account.yml')))
      @repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
    end
    
    def test_get_all_tags
      tags = @repo.get_all_tags
      assert tags.count > 0
    end
  
    def test_get_tags_by_album_id
      tags = @repo.get_tags_by_album_id("5461230096110151249")
      assert tags.count > 0
    end
  
    def test_get_tags_by_album_id_and_photo_id
      tags = @repo.get_tags_by_album_id_and_photo_id("5461230096110151249", "5577383323184640194")
      assert tags.count > 0
    end
  
  end
end