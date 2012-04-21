require_relative 'repositories/repository'

module PicasaWebAlbums
  def self.get_repository(email, password)
    Repository.new(email, password)
  end
end
