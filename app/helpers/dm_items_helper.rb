module DmItemsHelper
  
  def find_by_id(refID)
    baseURL = 'http://192.168.50.7:8089'
  
    token = '4359a30a831e429f1ea1c6a5f5e7017e37a99924cc03c30da587f085b6d2980f'
  
    findByIdURL = 'http://192.168.50.7:8089/repositories/2/find_by_id/archival_objects?ref_id[]=' + refID

    # status_test = open(findByIdURL, 'X-ArchivesSpace-Session' => token).status

    findByIdJSON = open(findByIdURL, 'X-ArchivesSpace-Session' => token).read

    parsed = JSON.parse(findByIdJSON)

    archivalObjectURL = baseURL + parsed["archival_objects"].first["ref"]

    archivalObjectJSON = open(archivalObjectURL, 'X-ArchivesSpace-Session' => token).read

    parsed = JSON.parse(archivalObjectJSON)

    display_title = parsed["display_string"]

    resourceURL = baseURL + parsed["resource"]["ref"]

    resourceJSON = open(resourceURL, 'X-ArchivesSpace-Session' => token).read

    parsed = JSON.parse(resourceJSON)

    resource = parsed["title"]
  end
  
end
