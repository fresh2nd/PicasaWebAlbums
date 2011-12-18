require_relative 'repositories/repository'

module PicasaWebAlbums
  def self.get_repository(email, password)
    picasa_repo = Repository.new(email, password)
    return picasa_repo
  end
end
