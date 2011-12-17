PicasaWebAlbums
===============

Gem for accessing photos and albums from Picasa Web Albums

Rails Integration
-----------------

Add this line to the application's Gemfile:

	gem 'googleapis', :git => 'git@github.com:mkraft/PicasaWebAlbums.git'

Example
--------

	picasa_repo = Googleapis.picasa('someperson@gmail.com', 'somepassword')
	albums = picasa_repo.get_albums
	photos = picasa_repo.get_photos(albums[0])

Methods
-------

- `get_albums()`
- `get_album_by_id(id)`
- `get_album_by_title(title)`
- `get_album_by_slug(slug)`
- `get_photos(album)`
- `get_photo_by_album_and_id(album, photo_id)`

Properties
----------

Photo class:

- `id`
- `url`
- `caption`
- `width`
- `height`
- `file_name`

Album class:

- `id`
- `photos`
- `title`
- `slug`
- `date_created`
- `date_updated`
- `cover_photo_url`
- `description`