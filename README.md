# Digital Media Log

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
* Virus scanned (required | controlled list)
* Notes (need to un-comment on app/views/dm_items/form.html.erb)

Inspired by https://github.com/NYULibraries/medialog

This tool is intended to be used behind a firewall. This app used to run on a postgres database; see the postgres branch (no longer actively developed).

## Quick Start

A Docker container is included in this repository so you can quickly spin up a sample site on your computer. With git and Docker installed, run:

    git clone https://github.com/RockefellerArchiveCenter/dm_log.git
    cd dm_log
    docker-compose build
    docker-compose up

The application will be available in your browser at `http://localhost:3000`.



## Requirements

* Rails 5.2
* Ruby 2.5
* MySQL

Because the application makes HTTP using Javascript, CORS needs to be implemented on your ArchivesSpace instance. See [as-cors](https://github.com/RockefellerArchiveCenter/as-cors) for an example of how to do this with an ArchivesSpace plugin.

## Deploying in production

In order to deploy in production, `dm_log` expects the following environment variables to be set (the values associated with each of these may change):

```
MYSQL_ROOT_PASSWORD=example
SECRET_KEY_BASE=Wa4Kdu6hMt3tYKm4jb9p4vZUuc7jBVFw
```

You can either provide these variables on the command line or in an [env file](https://docs.docker.com/compose/env-file/). (These are not needed when running locally due to the `--default-authentication-plugin=mysql_native_password` command.)

Create `app/assets/javascripts/application_settings.js` with the repository ID and base url for your ArchivesSpace instance and a non-expiring session token for an AS user:
```
// Identifier for the ArchivesSpace repository you want to query
var asRepo = "2"

// Non-expiring session token for an AS user
var token = "token";

// Base url for your ArchivesSpace instance, including the backend port number
var baseURL = "http://localhost:8089"
```



## Usage
There is an API that accepts GET, PUT, and PATCH requests in JSON. To access JSON data via the API, requests must container `user_email` and `user_token` parameters, e.g., in the format `/api/dm_items/10?user_email=example@example.com&user_token=1G8_s7P-V-4MGojaKD7a`. The token is available in the app GUI.

## Contributing

Pull requests accepted!

## License

This content is released under MIT-License. Please see `MIT-License.md` for more information.
