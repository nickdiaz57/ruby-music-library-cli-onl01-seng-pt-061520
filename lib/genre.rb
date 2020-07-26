class Genre
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

    def artists
        @songs.collect {|s| s.artist} .uniq
    end
end