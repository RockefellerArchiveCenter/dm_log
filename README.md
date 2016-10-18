#Digital Media Log

A Rails app that uses ArchivesSpace's API to quickly inventory digital media items and log disk imaging.

Inspired by https://github.com/NYULibraries/medialog

## Requirements

* Rails 5.0
* Ruby 2.3
* PostgreSQL

Because the application makes HTTP using Javascript, CORS needs to be implemented on your ArchivesSpace instance. See [as-cors](https://github.com/RockefellerArchiveCenter/as-cors) for an example of how to do this with an ArchivesSpace plugin.

## Installation
Edit app/assets/javascripts/dm_items to include the base url for your ArchivesSpace instance and a non-expiring session token for an AS user.

To install locally:

Run PostgreSQL, and execute the following commands in your terminal
```
$ git clone https://github.com/RockefellerArchiveCenter/dm_log.git
$ cd dm_log
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s
```
In your web browser, go to `http://localhost:3000/`. To access the JSON data, append `/json` to the url of the item you want to access (`http://localhost:3000/dm_items/3/json`).

## Contributing

Pull requests accepted!

## License

This content is released under MIT-License. Please see `MIT-License.md` for more information.
