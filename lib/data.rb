module Cabi

  class Data

      def self.read(id)
        DataFile.contents(id) || nil
      end

      def self.write(id, content)
        file = DataFile.write(id, content)
      end

      def self.user_data_dir
        dir = false

        Dir.foreach('.') do |item|
          next if item == '..' or !File.directory?(item)
          dir = item if File.exists?( File.join(item, CABI_DATA_ID) )
          break if dir
        end

        dir
      end

  end

  # Helpers for setting/getting data dir.
  def self.data_dir
    dir             = Data.user_data_dir || CABI_DATA_DIR
    @@data_dir      = File.expand_path(dir)
    raise LoadError.new "Could not find cabi data folder!" unless File.exists? @@data_dir
    @@data_dir
  end

  def self.reset_data_dir
    @@data_dir = nil
  end

end