
require 'yaml'

Dir.glob( File.expand_path( '..', __FILE__) + '/*.rb' ).each do |f|
  require File.join( File.expand_path( '..', f), File.basename(f, File.extname(f)) )
end 

module Cabi

  DELIMITER       = ':'
  BULK_SELECTOR   = '*'
  YAML_EXT        = '.yml'
  CABI_CACHE_ID   = '.cabi-cache'
  CABI_CACHE_DIR  = './cabi-cache'

  def self.read(id)
    Cache.read(id)
  end

  def self.write(id, content)
    Cache.write(id, content)
  end

end