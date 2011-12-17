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

Repsository Methods
-------------------

- `get_albums()`
- `get_album_by_id(id)`
- `get_album_by_title(title)`
- `get_album_by_slug(slug)`
- `get_photos(album)`
- `get_photo_by_album_and_id(album, photo_id)`

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

TODO...
-------

### Tags

- List all tags
- List tags by album
- List tags by photo
- Search photos using tags

### Comments

- Retrieve the most recent comments
- Retrieve the comments for a photo