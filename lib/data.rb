module Cabi

  class Data

      def self.read(id, opts={})
        DataFile.contents(id, opts) || nil
      end

      def self.write(id, content)
        file = DataFile.write(id, content)
      end

      def self.create(id, content)
        file = DataFile.create(id, content)
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

  # Helpers for setting/getting data directory.
  def self.data_dir(opts={})
    dir             = Data.user_data_dir || CABI_DATA_DIR
    @@data_dir      = File.expand_path(dir)

    return nil                                              if !File.exists?(@@data_dir) and opts[:quiet]
    raise LoadError.new "Could not find cabi data folder!"  if !File.exists? @@data_dir

    @@data_dir
  end

  def self.reset_data_dir
    @@data_dir = nil
  end

end