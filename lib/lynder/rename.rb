module Lynder
  class Rename
    # This is a destructive operation, it will rename files on your filesystem
    def self.reorder!
      # Gem the list of .mp4 files in the current directory
      files = Dir.glob('*.mp4').map { |f| f.gsub(/^\//, '') }

      # Sort and rename the files
      sort(files).map.with_index(1) do |file, i|
        File.rename(file, File.join(Dir.pwd, "#{sprintf '%03d', i}. #{file}"))
      end
    end

    private
      # Sort files by the numbers in their name
      # Ex. file-360826.mp4, file-360829.mp4
      def self.sort(files)
        files.sort_by do |file|
          file.match(/-(\d+)\..*$/i).captures.first.to_i
        end
      end
  end
end
