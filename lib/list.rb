module Cabi
  class List

    def self.list(id, opts={})
      ls    = []
      path  = id.gsub( DELIMITER, '/')

      Dir.glob( "#{Cabi.data_dir}/#{path}") do |item|
        next if item == '.' or item == '..'

        i = opts[:full_path] ? item : Cabi.path_to_id(item)
        ls << [ i, File.directory?(item) ? "dir" : "file", File.basename(item) ]
      end

      ls.sort_by!{ |f| f[1] } if opts[:dirs_first] # "dir" < "file" 
      ls
    end

  end
end