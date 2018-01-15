require_relative 'config'
require_relative 'creatures'
require_relative 'battle'

class KudomonGo
    
    def initialize
        #Variable so we know when to quit
        @running = true
        
        # Introduction
        puts
        puts 'Welcome to Kudomon Go!!
        /\︿╱\
        \0__0/
       <  \/  >
        | CK |╱\╱
        \_︹_/'
        puts "Before we start your adventure, what is your name Trainer?"
        
        #List of trainers so we can handle mutliple users in future
        @trainers = []
        #Spawn trainer at point (0,0) on map
        @trainer = Trainer.new(gets.chomp,{ x: 0, y: 0 })
        # Add new trainer to list of active users
        @trainers << @trainer
        puts "Hello #{@trainer.name}!"
        
        # Give the trainer an inital Kudomon
        print "Professor Freddy has given you a Kudomon to start with. "
        @trainer.capture(random_kudomon)
        
        #Spawn Kudomon randomly across the map
        @wild_kudomon = []
        NO_OF_KUDOMON.times do
            invalid_position = true
            #Make sure they're not generated on top of each other
            while invalid_position
                position = { x: rand(1...MAP_SIZE), y: rand(1...MAP_SIZE) }
                invalid_position = @wild_kudomon.any? { |k| k.position == position } ? true : false
            end
            @wild_kudomon << random_kudomon(position)
        end
    end
    
    def kudomon_nearby
        #Return wild kudomon that are within NEARBY (defined in config) of the trainer
        x = @trainer.position[:x]
        y = @trainer.position[:y]
        @wild_kudomon.select { |k| Math.sqrt((k.position[:x] - x)**2 + (k.position[:y] - y)**2) < NEARBY }
    end
    
    #Allow trainer to move across the map grid step by step
    def move(trainer)
        puts "Which direction? N, W, S or E?"
        direction = gets.chomp
        case direction.capitalize
        when "N"
            delta = [0,1]
        when "W"
            delta = [-1,0]
        when "S"
            delta = [0,-1]
        when "E"
            delta = [1,0]
        else
            return
        end
        trainer.move(delta)
    end
    
    def catch(catchable_kudomon)
        # User can choose which to try to catch if more than one nearby
        if catchable_kudomon.length > 1
            puts "There are multiple kudomon nearby. Which would you like to capture?"
            (1..catchable_kudomon.length).each do |i|
                puts "#{i} - #{catchable_kudomon[i-1].name}"
            end
            selection = gets.chomp.to_i
            if selection && catchable_kudomon[selection-1]
                # Create single kudomon array to try and capture
                catchable_kudomon = Array(catchable_kudomon[selection-1])
            else
                puts "Selection not recognised"
            end
        end
        # Battle wild kudomon in order to catch it.
        outcome = battle(@trainer.collection,catchable_kudomon)
        if outcome == VICTORY
            #Check that kudomon is still there
            if @wild_kudomon.include?(catchable_kudomon[0])
                #If win battle then capture kudomon
                @trainer.capture(catchable_kudomon[0])
                @wild_kudomon.delete(catchable_kudomon[0])
            else
            # If kudomon is no longer in wild_kudomon then must have been beaten to it
                puts "Oh no, the wild kudomon has been caught by another player!"
            end
        else
        # If lose the battle, Kudomon not caught. We will leave it in position to try again for now.
            puts "#{catchable_kudomon[0].name} ran away."
        end
        #Whatever the outcome heal trainer's kudomon. In future can add potions
        @trainer.heal
    end
    
    def look(trainer)
        puts "Your kudomon collection is:"
        trainer.collection.each {|k| puts "#{k.name}: #{k.species}. HP = #{k.hp}, CP = #{k.cp}"}
    end
    
    def run_game
        while @running
            puts "\nYou are at position (#{@trainer.position.values.join(", ")})."
            
            # Can the trainer catch anything?
            catchable_kudomon = kudomon_nearby
            if catchable_kudomon.any?
                puts "A " + catchable_kudomon.collect {|k| k.name }.join(", ") + " appears!"
            else
                puts "No wild kudomon nearby."
            end
            
            puts "What do you want to do?"
            puts "- M = Move"
            puts "- C = Catch a kudomon" if catchable_kudomon.any?
            puts "- L = Look at kudomon"
            puts "- Q = Quit"
            action = gets.chomp
            
            case action.capitalize
            when "M"
                move(@trainer)
            when "C"
                if catchable_kudomon.any?
                    catch(catchable_kudomon)
                else
                    puts "No Kudomon to catch nearby."
                end
            when "L"
                look(@trainer)
            when "Q"
                @running = false
            else
                puts "Sorry I don't recognise that action. Please type the letter of your chosen action."
            end
        end
    end
end
# Launch game
KudomonGo.new.run_game


