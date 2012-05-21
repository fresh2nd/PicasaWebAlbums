require_relative '../domain/tag'

module TagsRepository
  def get_all_tags
    xml = get_xml("http://picasaweb.google.com/data/feed/api/user/#{@email}?kind=tag")
    tags = []
    xml.root.elements.each("//entry") do |entry|
      tag = PicasaWebAlbums::Tag.new
      tag.text = entry.elements["title"].text
      tag.weight = entry.elements["gphoto:weight"].text.to_i  #Adding new field to tag. Weight is the number of times that the tag is present.
      tags << tag
    end
    tags
  end

  def get_tags_by_album_id(album_id)
    get_xml("http://picasaweb.google.com/data/feed/api/user/userID/albumid/#{album_id}?kind=tag")
  end

  def get_tags_by_album_id_and_photo_id(album_id, photo_id)
    get_xml("http://picasaweb.google.com/data/feed/api/user/default/albumid/#{album_id}/photoid/#{photo_id}?kind=tag")
  end
end