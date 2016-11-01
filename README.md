#Digital Media Log

A Rails app that uses ArchivesSpace's API to quickly inventory digital media items and log disk imaging.

You can use this app to:

* Identify digital media items during processing in order to plan for and perform preservation actions
* Log basic digital media stabilization information
* Integrate with existing collections management system (ArchivesSpace) to reduce duplicate data entry and to record location of item

Fields include:

* Unique ID (required | auto-generated)
* AS archival object URI (required | manually entered)
* AS parent component and resource title (required | automatic via API)
* Format (required | controlled list)
* Transfer status (required | controlled list
* Transfer method (controlled list)
* Date of transfer (date field)
* Container disposition (required | controlled list)
* Notes (need to un-comment on app/views/dm_items/form.html.erb)


Inspired by https://github.com/NYULibraries/medialog

## Requirements

* Rails 5.0
* Ruby 2.3
* PostgreSQL

Because the application makes HTTP using Javascript, CORS needs to be implemented on your ArchivesSpace instance. See [as-cors](https://github.com/RockefellerArchiveCenter/as-cors) for an example of how to do this with an ArchivesSpace plugin.

## Installation
Create `app/assets/javascripts/application_settings.js` with the repository ID and base url for your ArchivesSpace instance and a non-expiring session token for an AS user:
```
// Identifier for the ArchivesSpace repository you want to query
var asRepo = "2"

// Non-expiring session token for an AS user
var token = "token";

// Base url for your ArchivesSpace instance, including the backend port number
var baseURL = "http://localhost:8089"
```

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
