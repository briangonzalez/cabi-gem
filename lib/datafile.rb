module Cabi

  class DataFile

    def self.contents(id)
      return File.read( self.file(id) )                 if self.file_exists?(id)
      return File.read( self.yaml_file(id) )            if self.yaml_exists?(id)
      return File.read( self.non_extension_file(id) )   if self.non_extension_file(id)
      return self.sub_yaml(id)
    end

    def self.write(id, content)
      file      = self.file_yaml_or_non_extension_file(id)
      new_file  = self.file(id)

      if not file
        parent    = File.expand_path( '..', new_file )
        FileUtils.mkdir_p(parent)     unless File.exists?(parent)
        FileUtils.touch(new_file)     unless File.exists?(new_file)
        file = new_file
      end

      File.open( file, 'w') {|f| f.write(content) } 
    end

    def self.exists?(id)
      self.file_exists?(id) or self.yaml_exists?(id)
    end

    def self.file_exists?(id)
      File.exists?( self.file(id) )
    end

    def self.yaml_exists?(id)
      File.exists?( self.yaml_file(id) )
    end

    def self.file_yaml_or_non_extension_file(id)
      return self.file(id)                if self.file_exists?(id)
      return self.yaml_file(id)           if self.yaml_exists?(id)
      return self.non_extension_file(id)  if self.non_extension_file(id)
      nil
    end

    def self.file(id)
      id = id.split( DELIMITER )
      id = [Cabi.cache_dir] + id
      File.join( *id )
    end

    def self.yaml_file(id)
      File.join( self.file(id) + YAML_EXT )
    end

    def self.file_parent(id)
      File.dirname( self.file(id) ) 
    end

    def self.non_extension_file(id)
      base = id.split( DELIMITER ).last

      file = false
      Dir.glob( self.file_parent(id) + '/*' ).each do |f|
        file = File.join(f) if File.basename(f, File.extname(f)) == base
        break if file
      end

      file
    end

    def self.sub_yaml(id)
      id = id.split( DELIMITER )
      val = false
      id.each_with_index do |key, index|
        break if val

        a                 =  [Cabi.cache_dir] + id[0..index] 
        a[ a.length - 1 ] =  a[a.length - 1 ] + YAML_EXT
        f = File.join( *a )

        if File.exists? f
          data = YAML.load( File.read(f) )
          val = data.access( id[index+1..-1].join(DELIMITER) )
        end
      end

      val
    end

  end

end