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

* Rails 5.0
* Ruby 2.4
* MySQL

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

Run MySQL, and execute the following commands in your terminal
```
$ git clone https://github.com/RockefellerArchiveCenter/dm_log.git
$ cd dm_log
$ bundle install
$ rake db:create
$ rake db:migrate
$ rails s
```
In your web browser, go to `http://localhost:3000/`. To access the JSON data, append `/api` before `/dm_items` for the item you want to access (`http://localhost:3000/api/dm_items/3`).

### Seed Database from CSV
To populate the database from a CSV file, follow these instructions: https://gist.github.com/arjunvenkat/1115bc41bf395a162084

using a seeds.rb file that looks like this:

```
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'dm_items.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  t = DmItem.new
  t.auto_id = row['auto_id']
  t.format = row['format']
  t.status = row['status']
  t.method = row['method']
  t.disposition = row['disposition']
  t.transfer_date = row['transfer_date']
  t.refid = row['ref_id']
  t.display_title = row['display_title']
  t.resource = row['resource']
  t.save
  puts "#{t.auto_id}, #{t.resource} saved"
end


puts "There are now #{DmItem.count} rows in the digital media items table"
```

## Usage
There is an API that accepts GET, PUT, and PATCH requests in JSON. To access JSON data via the API, requests must container `user_email` and `user_token` parameters, e.g., in the format `/api/dm_items/10?user_email=example@example.com&user_token=1G8_s7P-V-4MGojaKD7a`. The token is available in the app GUI.

## Contributing

Pull requests accepted!

## License

This content is released under MIT-License. Please see `MIT-License.md` for more information.
