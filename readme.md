PicasaWebAlbums
===============

Gem for accessing photos and albums from Picasa Web Albums

Integration
-----------

Add this line to the application's Gemfile:

	gem 'PicasaWebAlbums', :git => 'git@github.com:mkraft/PicasaWebAlbums.git'

Example
-------

	picasa_repo = PicasaWebAlbums.get_repository('someperson@gmail.com', 'somepassword')
	albums = picasa_repo.get_albums
	photos = picasa_repo.get_photos(albums[0])
	photos.each { |photo| puts photo.url }

Repository Methods
-------------------

### Album(s)

- `get_all_albums`
- `get_album_by_id(id)`
- `get_album_by_title(title)`
- `get_album_by_slug(slug)`

### Photo(s)

- `get_photos_by_album_id(album_id)`
- `get_photo_by_album_id_and_photo_id(album_id, photo_id)`

### Tags

- `get_all_tags`
- `get_tags_by_album_id(album_id)`
- `get_tags_by_album_id_and_photo_id(album_id, photo_id)`

Domain Objects
--------------

### Photo

- `id`
- `url`
- `caption`
- `width`
- `height`
- `file_name`

### Album

- `id`
- `photos`
- `title`
- `slug`
- `date_created`
- `date_updated`
- `cover_photo_url`
- `description`

### Tag

- `text`

Future Development
------------------

### Tags

- Search photos using tags

### Comments

- Retrieve the most recent comments
- Retrieve the comments for a photo