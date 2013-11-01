
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

  def self.read(id, opts={})
    Data.read(id, opts)
  end

  def self.write(id, content)
    Data.write(id, content)
  end

  def self.create(id, content='')
    Data.write(id, content)
  end

  def self.file(id, opts={})
    DataFile.file_yaml_or_non_extension_file(id)
  end

  def self.list(id='*', opts={})
     Cabi::List.list(id, opts)
  end

  def self.path_to_id(path)
    path = path.split(Cabi.data_dir).last
    path  = path[1..-1] if path[0] == '/' 
    path  = path.gsub('/', DELIMITER)
    path
  end

end