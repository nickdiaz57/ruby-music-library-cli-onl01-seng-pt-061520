class MusicImporter
    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        Dir.glob("*.mp3", base: @path)
    end

    def import
        list = self.files
        list.each {|s| Song.create_from_filename(s)}
    end
end