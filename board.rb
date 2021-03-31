require 'set'

class Memory
    attr_accessor :words, :random_words, :num_of_words, :seconds, :guess_arr

    def initialize()
        @words = File.readlines("dictionary.txt").map(&:chomp)
        @dictionary = Set.new(words)
        @random_words = []
        @num_of_words = 0
        @guess_arr = []
    end

    def set_random_words
        puts "How many words would you like to memorize?"
        puts "Enter a number"
        num = gets.chomp.to_i
        if num < 100
            while @random_words.length < num
                random_word = @words[rand(@words.length)].to_s
                @random_words << random_word if random_word.length < 7
            end
        else
            puts "Pick a number between 1-100"
            sleep(2)
            system("clear")
            self.set_random_words
        end
        @num_of_words = num
    end

    def render_words
        puts "Memorize these words"
        @random_words.each { |word| puts word }
    end

    def set_time
        puts "How much time would you like?"
        puts "Enter a number in seconds"
      
        num = gets.chomp.to_i
        if num <= 1800 && num > 0 && num != nil
            @seconds = num
        else
            puts "Incorrect value, try again"
            sleep(1)
            system("clear")
            self.set_time
        end
    end

    def timer(seconds)
        time = seconds
        while time > 0
            puts "Time Left:"
            puts time
            puts
            puts @random_words
            sleep(1)
            system("clear")
            time -= 1
        end
    end


    def guess_words
        puts "Enter the correct word order, hit enter after each word:"
        @random_words.each_with_index do |word, idx|
            player_guess = gets.chomp.to_s
            if player_guess == word
                guess_arr << player_guess
                system("clear")
                puts "Your guesses:"
                puts guess_arr
                puts
                puts "____________"
                puts "Correct! Guess again"
            else
                system("clear")
                return p "GAME OVER"
            end
        end
    end

     def new_game
         self.set_random_words
         self.set_time
         system("clear")
         puts "Get read to memorize the word list!"
         sleep(2)
         system("clear")

         self.timer(@seconds)
         #sleep(@seconds)
         system("clear")
         self.guess_words

         puts "____________________"
         puts
         puts "Your guesses:"
         puts @guess_arr
         puts
         puts "Correct Words"
         puts @random_words
     end
end




if $PROGRAM_NAME == __FILE__
    game = Memory.new()
    game.new_game
end