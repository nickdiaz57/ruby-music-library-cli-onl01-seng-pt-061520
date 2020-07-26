class MusicLibraryController
    attr_accessor :path

    def initialize(path = './db/mp3s')
        @path = path
        @lib = MusicImporter.new(path).import
    end

    def call
        welcome until @input == 'exit'
    end

    def welcome
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        @input = gets.chomp
        if @input == "list songs"
          list_songs
        elsif @input == "list artists"
          list_artists
        elsif @input == "list genres"
          list_genres
        elsif @input == "list artist"
          list_songs_by_artist
        elsif @input == "list genre"
          list_songs_by_genre
        elsif @input == "play song"
          play_song
        end
    end

    def list_songs
        list = Song.all.sort {|a, b| a.name <=> b.name}
        list.each_with_index {|e, i| puts "#{i + 1}. #{e.artist.name} - #{e.name} - #{e.genre.name}"}
    end

    def list_artists
        list = Artist.all.collect {|a| a.name}
        list.sort.each_with_index {|e, i| puts "#{i + 1}. #{e}"}
    end

    def list_genres
        list = Genre.all.collect {|a| a.name}
        list.sort.each_with_index {|e, i| puts "#{i + 1}. #{e}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp
        if a = Artist.find_by_name(input)
          a.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|s, i| puts "#{i + 1}. #{s.name} - #{s.genre.name}"}
        end
    end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      input = gets.chomp
      if g = Genre.find_by_name(input)
        g.songs.sort {|a, b| a.name <=> b.name}.each_with_index {|s, i| puts "#{i + 1}. #{s.artist.name} - #{s.name}"}
      end
    end

    def play_song
        puts "Which song number would you like to play?"
        list = Song.all.sort {|a, b| a.name <=> b.name}
        choice = gets.chomp
        if choice.to_i > 0 && choice.to_i <= list.length
          puts "Playing #{list[choice.to_i - 1].name} by #{list[choice.to_i - 1].artist.name}"
        end
    end
end