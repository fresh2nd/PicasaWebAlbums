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
end