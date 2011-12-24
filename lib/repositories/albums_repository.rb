require 'date'
require_relative '../domain/album'

module AlbumsRepository
  def get_all_albums
    xml = get_xml("http://picasaweb.google.com/data/feed/api/user/#{@email}?kind=album&access=all")
    albums = []
    xml.root.elements.each("//entry") do |entry|
      gallery = PicasaWebAlbums::Album.new
      gallery.id = entry.elements["gphoto:id"].text
      gallery.title = entry.elements["title"].text
      gallery.date_created = DateTime.parse(entry.elements["published"].text)
      gallery.date_updated = DateTime.parse(entry.elements["updated"].text)
      gallery.slug = entry.elements["gphoto:name"].text
      gallery.access = entry.elements["gphoto:access"].text
      gallery.number_of_photos = entry.elements["gphoto:numphotos"].text.to_i
      gallery.number_of_comments = entry.elements["gphoto:commentCount"].text.to_i
      gallery.number_of_photos_remaining = entry.elements["gphoto:numphotosremaining"].text.to_i
      gallery.total_bytes = entry.elements["gphoto:bytesUsed"].text.to_i
      gallery.cover_photo_url = entry.elements["media:group/media:content"].attributes["url"]
      gallery.description = entry.elements["media:group/media:description"].text
      albums << gallery
    end
    return albums
  end

  def get_album_by_id(id)
    albums = get_all_albums
    album_to_return = albums[albums.find_index{|album| album.id == id.to_s}]
    return album_to_return
  end

  def get_album_by_title(title)
    albums = get_all_albums
    album_to_return = albums[albums.find_index{|album| album.title == title.to_s}]
    return album_to_return
  end

  def get_album_by_slug(slug)
    albums = get_all_albums
    album_to_return = albums[albums.find_index{|album| album.slug == slug.to_s}]
    return album_to_return
  end
  
  def create_album(album)
    entry = "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:media='http://search.yahoo.com/mrss/' xmlns:gphoto='http://schemas.google.com/photos/2007'><title type='text'>#{album.title}</title><summary type='text'>#{album.description}</summary><gphoto:location></gphoto:location><gphoto:access>#{album.access}</gphoto:access><gphoto:timestamp></gphoto:timestamp><media:group><media:keywords></media:keywords></media:group><category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#album'></category></entry>"
    post_new_album(entry)
  end
  
  #def delete_album_by_id(album_id)
  #  url = URI.parse("https://picasaweb.google.com/data/entry/api/user/#{@email}/albumid/#{album_id}")
  #  http = Net::HTTP.new(url.host, url.port)
  #  http.use_ssl = (url.scheme == 'https')
  #  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  #  req = Net::HTTP::Delete.new(url.request_uri)
  #  req['Authorization'] = @authentication_token
  #  res = http.request(req)
  #  return res.code
  #end
  
  private
  
  def post_new_album(data)
    uri = URI("https://picasaweb.google.com/data/feed/api/user/#{@email}")
    status = ""
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Post.new uri.request_uri
      request['Authorization'] = @authentication_token
      request['Content-Type'] = "application/atom+xml; charset=UTF-8; type=entry"
      request.body = data
      response = http.request(request)
      status = response.code
    end
    return status
  end
end