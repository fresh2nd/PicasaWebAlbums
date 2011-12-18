#require "PicasaWebAlbums/version"
require 'net/http'
require 'rexml/document'
require 'date'
require 'uri'
require_relative 'album'
require_relative 'photo'
require_relative 'tag'
require_relative 'repository'

module PicasaWebAlbums
  def self.get_repository(email, password)
    picasa_repo = Repository.new(email, password)
    return picasa_repo
  end
end
