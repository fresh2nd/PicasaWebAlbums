module PicasaWebAlbums
  class Repository
    def initialize(email, password)
      @email = email
      @authentication_token = get_authentication_token(email, password)
    end

    def get_all_albums
      xml = get_multiple_album_xml
      albums = []
      xml.root.elements.each("//entry") do |entry|
        gallery = Album.new
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
      index_of_album_with_id = albums.find_index{|album| album.id == id.to_s}
      album_to_return = albums[index_of_album_with_id]
      return album_to_return
    end

    def get_album_by_title(title)
      albums = get_all_albums
      index_of_album_with_title = albums.find_index{|album| album.title == title.to_s}
      album_to_return = albums[index_of_album_with_title]
      return album_to_return
    end

    def get_album_by_slug(slug)
      albums = get_all_albums
      index_of_album_with_slug = albums.find_index{|album| album.slug == slug.to_s}
      album_to_return = albums[index_of_album_with_slug]
      return album_to_return
    end

    def get_photos_by_album_id(id)
      xml = get_single_album_xml(id)
      photos = []
      xml.root.elements.each("//entry") do |entry|
        photo = Photo.new
        photo.id = get_photo_id_from_photo_id_url(entry.elements["id"].text)
        photo.url = entry.elements["media:group/media:content"].attributes["url"]
        photo.width = entry.elements["media:group/media:content"].attributes["width"].to_i
        photo.height = entry.elements["media:group/media:content"].attributes["height"].to_i
        photo.caption = entry.elements["media:group/media:description"].text
        photo.file_name = entry.elements["media:group/media:title"].text
        photos << photo
      end
      return photos
    end

    def get_photo_by_album_id_and_photo_id(album_id, photo_id)
      photos = get_photos_by_album_id(album_id)
      photo_to_return = Photo.new
      photos.each do |photo|
        if photo.id == photo_id
        photo_to_return = photo
      end
      end
      return photo_to_return
    end
    
    def get_all_tags
      xml = get_tags_xml
      tags = []
      xml.root.elements.each("//entry") do |entry|
        tag = Tag.new
        tag.text = entry.elements["title"].text
        tags << tag
      end
      return tags
    end
    
    def get_tags_by_album_id(album)
    end
    
    def get_tags_by_photo_id(photo)
    end

    private

    def get_tags_xml
      uri = URI("http://picasaweb.google.com/data/feed/api/user/#{@email}?kind=tag")
      request = Net::HTTP::Get.new(uri.request_uri)
      request['Authorization'] = @authentication_token
      response = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(request)
      }
      body = response.body
      xml = REXML::Document.new(body)
      return xml
    end

    def get_photo_id_from_photo_id_url(photo_id_url)
      start_index = photo_id_url.index('/photoid/') + 9
      slice_of_id_url_to_end = photo_id_url[start_index..-1]
      end_index = slice_of_id_url_to_end.index(/[?|\/]/)
      id = slice_of_id_url_to_end[0...end_index]
      return id
    end

    def get_authentication_token(email, password)
      body = ""
      uri = URI("https://www.google.com/accounts/ClientLogin")
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do   |http|
        request = Net::HTTP::Post.new uri.request_uri
        data = "accountType=HOSTED_OR_GOOGLE&Email=#{email}&Passwd=#{password}&service=lh2&source=someapp1"
        response = http.request(request, data)
        body = response.body
      end
      start_index = body.index('Auth=')
      slice_of_auth_to_end = body[start_index..-1]
      end_index = slice_of_auth_to_end.index("\n")
      auth_string = slice_of_auth_to_end[0...end_index]
      auth_token = "GoogleLogin #{auth_string}"
      return auth_token
    end

    def get_multiple_album_xml
      uri = URI("http://picasaweb.google.com/data/feed/api/user/#{@email}?kind=album&access=all")
      request = Net::HTTP::Get.new(uri.request_uri)
      request['Authorization'] = @authentication_token
      response = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(request)
      }
      body = response.body
      xml = REXML::Document.new(body)
      return xml
    end

    def get_single_album_xml(album_id)
      uri = URI("http://picasaweb.google.com/data/feed/base/user/#{@email}/albumid/#{album_id}")
      request = Net::HTTP::Get.new(uri.request_uri)
      request['Authorization'] = @authentication_token
      response = Net::HTTP.start(uri.hostname, uri.port) { |http|
      http.request(request)
      }
      body = response.body
      xml = REXML::Document.new(body)
      return xml
    end
  end
end