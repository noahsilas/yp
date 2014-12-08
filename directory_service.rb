require 'rf-rest-open-uri'
require 'csv'

class DirectoryService
  
  # get the directory at the specified URI
  # @param uri [String] The uri of the directory, in CSV format
  # @return [Array<String>] A list of (name, number) of people in the directory
  def self.getDirectory(uri)
    directory = Hash.new

    file_contents = open(uri).read
    CSV.new(file_contents, { headers: true } ).each { |entry|
      directory[entry["first name"]] = entry["phone"]
    }

    return directory
  end
end
