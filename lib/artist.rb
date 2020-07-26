class Artist
    attr_accessor :name, :songs
    extend Concerns::Findable, Concerns::Memorable
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def add_song(song)
        song.artist = self if song.artist == nil
        @songs << song unless @songs.find {|s| s == song}
    end

    def genres
        @songs.collect {|s| s.genre} .uniq
    end
end