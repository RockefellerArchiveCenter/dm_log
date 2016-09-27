#Digital Media Log

A Rails app that uses ArchivesSpace's API to quickly inventory digital media items and log disk imaging.

Inspired by https://github.com/NYULibraries/medialog 

## Requirements

* Rails 5.0
* Ruby 2.3
* PostgreSQL

Because the application makes HTTP using Javascript, CORS needs to be implemented on your ArchivesSpace instance. See [as-cors](https://github.com/RockefellerArchiveCenter/as-cors) for an example of how to do this with an ArchivesSpace plugin.

## License

This content is released under MIT-License. Please see `MIT-License.md` for more information.