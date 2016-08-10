require "lynder/version"

module Lynder
  class Rename
    def self.reorder!
      files = Dir.glob('*').map { |f| f.gsub(/^\//, '') }
      sort(files).map.with_index(1) do |file, i|
        File.rename(file, File.join(Dir.pwd, "#{sprintf '%03d', i}. #{file}"))
      end
    end

    private
      def self.sort(files)
        files.sort_by do |file|
          file.match(/-(\d+)\..*$/i).captures.first.to_i
        end
      end
  end
end
