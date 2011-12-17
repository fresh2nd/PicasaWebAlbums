require 'test/unit'
require 'shoulda'
require_relative '../lib/picasawebalbums'

module PicasaWebAlbums
  class TestTags < Test::Unit::TestCase
    
    context "get all tags" do
      repo = PicasaWebAlbums.get_repository('apitest33@gmail.com', 'ruhak23A')
      should "return at least 1 tag" do
        tags = repo.get_tags
        assert tags.count > 0
      end
    end
  
  end
end