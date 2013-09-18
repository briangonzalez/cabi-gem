
require 'yaml'

Dir.glob( File.expand_path( '..', __FILE__) + '/*.rb' ).each do |f|
  require File.join( File.expand_path( '..', f), File.basename(f, File.extname(f)) )
end 

module Cabi

  DELIMITER       = ':'
  BULK_SELECTOR   = '*'
  YAML_EXT        = '.yml'
  CABI_DATA_ID   = '.cabi-data'
  CABI_DATA_DIR   = './cabi-data'

  def self.read(id)
    Data.read(id)
  end

  def self.write(id, content)
    Data.write(id, content)
  end

  def self.file(id)
    DataFile.file_yaml_or_non_extension_file(id)
  end

end