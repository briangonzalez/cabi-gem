module Cabi

  class Cache

      def self.read(id)
        DataFile.contents(id) || nil
      end

      def self.write(id, content)
        file = DataFile.write(id, content)
      end

      def self.user_cache_dir
        dir = false

        Dir.foreach('.') do |item|
          next if item == '.' or item == '..'
          if File.directory?(item) and File.exists?( File.join(item, CABI_CACHE_ID) )
            dir = item
          end
          break if dir
        end

        dir
      end

  end

  # Helpers for setting/getting cache dir.
  def self.cache_dir
    @@cache_dir ||= Cache.user_cache_dir || CABI_CACHE_DIR
    raise LoadError.new "Could not find cabi cache folder!" unless File.exists? @@cache_dir
    @@cache_dir
  end

  def self.reset_cache_dir
    @@cache_dir = nil
  end

end