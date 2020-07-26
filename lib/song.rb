require 'pry'
class Song
    attr_accessor :name
    attr_reader :artist, :genre
    extend Concerns::Findable, Concerns::Memorable
    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.find {|s| s == self}
    end

    def self.new_from_filename(file)
        song = self.find_or_create_by_name(file.split(" - ")[1])
        song.artist = Artist.find_or_create_by_name(file.split(" - ")[0])
        song.genre = Genre.find_or_create_by_name(file.split(" - ")[2].split(".")[0])
        song
    end

    def self.create_from_filename(file)
        song = new_from_filename(file)
    end
end
