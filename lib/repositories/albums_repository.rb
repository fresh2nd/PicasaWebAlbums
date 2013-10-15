require 'date'
require_relative '../domain/album'

module AlbumsRepository
  def get_all_albums
    xml = get_xml("http://picasaweb.google.com/data/feed/api/user/#{@email}?kind=album&access=all")
    xml.root.elements.collect("//entry") { |entry| gallery_from_entry(entry) }
  end

  def get_album_by_id(id)
    albums = get_all_albums
    albums[albums.find_index{|album| album.id == id.to_s}]
  end

  def get_album_by_title(title)
    albums = get_all_albums
    albums[albums.find_index{|album| album.title == title.to_s}]
  end

  def get_album_by_slug(slug)
    albums = get_all_albums
    albums[albums.find_index{|album| album.slug == slug.to_s}]
  end

  def create_album(new_album)
    atom = get_album_atom(new_album)
    post_new_album(atom)
  end

  def delete_album_by_id(album_id)
    album = get_album_by_id(album_id)
    url = URI.parse(album.edit_url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Delete.new(url.request_uri)
    req['Authorization'] = @authentication_token
    res = http.request(req)
    res.code
  end

  #def update_album(modified_album)
  #  atom = get_album_atom(modified_album)
  #  uri = URI(modified_album.edit_url)
  #  status = ""
  #  Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
  #    request = Net::HTTP::Put.new uri.request_uri
  #    request['Authorization'] = @authentication_token
  #    request['Content-Type'] = "application/atom+xml; charset=UTF-8; type=entry"
  #    request.body = atom
  #    response = http.request(request)
  #    status = response.code
  #  end
  #  return status
  #end

  private

  def element_to_s(element)
    return "" unless !element.nil?
    element.text
  end

  def element_to_i(element)
    return 0 unless !element.nil?
    element.text.to_i
  end

  def element_get_attr(element,attribute)
    return nil unless !element.nil?
    element.attributes[attribute]
  end

  def gallery_from_entry(entry)
    gallery = PicasaWebAlbums::Album.new
    gallery.id = element_to_s(entry.elements["gphoto:id"])
    gallery.title = element_to_s(entry.elements["title"])
    gallery.date_created = DateTime.parse(element_to_s(entry.elements["published"]))
    gallery.date_updated = DateTime.parse(element_to_s(entry.elements["updated"]))
    gallery.slug = element_to_s(entry.elements["gphoto:name"])
    gallery.access = element_to_s(entry.elements["gphoto:access"])
    gallery.number_of_photos = element_to_i(entry.elements["gphoto:numphotos"])
    gallery.number_of_comments = element_to_i(entry.elements["gphoto:commentCount"])
    gallery.number_of_photos_remaining = element_to_i(entry.elements["gphoto:numphotosremaining"])
    gallery.total_bytes = element_to_i(entry.elements["gphoto:bytesUsed"])
    gallery.cover_photo_url = element_get_attr(entry.elements["media:group/media:content"],"url")
    gallery.description = element_to_s(entry.elements["media:group/media:description"])
    gallery.edit_url = get_edit_url_from_entry(entry)
    gallery
  end

  def get_album_atom(album)
    return "<entry xmlns='http://www.w3.org/2005/Atom' xmlns:media='http://search.yahoo.com/mrss/' xmlns:gphoto='http://schemas.google.com/photos/2007'><title type='text'>#{album.title}</title><summary type='text'>#{album.description}</summary><gphoto:location></gphoto:location><gphoto:access>#{album.access}</gphoto:access><gphoto:timestamp></gphoto:timestamp><media:group><media:keywords></media:keywords></media:group><category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#album'></category></entry>"
  end

  def get_edit_url_from_entry(entry)
    href = ""
    entry.elements.each("link") do |link|
      if (link.attributes["rel"] == "edit")
        href = link.attributes["href"]
      end
    end
    href
  end

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
    status
  end
end
