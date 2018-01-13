class Creature
    attr_accessor :position
    
    def initialize(name, position)
        @name = name
        #Check position is valid
        raise "Position invalid" unless position == nil || (position[:x].between?(0,MAP_SIZE) && position[:y].between?(0,MAP_SIZE))
        @position = position
    end
end

class Kudomon < Creature
    attr_reader :species
    attr_reader :type
    attr_accessor :name
    attr_accessor :hp
    attr_accessor :cp
    
    def initialize(species, position=nil)
        raise "Unknown Kudomon species" unless KUDOMON.include?(species)
        @species = species
        name = "Wild " + species
        super(name,position)
        @type = KUDOMON[@species][:type]
        @hp = KUDOMON[@species][:hp]
        @cp = KUDOMON[@species][:cp]
    end
end

class Trainer < Creature
    attr_reader :name
    attr_reader :collection
    
    def initialize(name, position)
        super
        @collection = []
    end
    
    def capture(kudomon)
        raise "That's no Kudomon!" unless kudomon.is_a?(Kudomon)
        puts kudomon.name + " caught!"
        puts "What do you want to call your new #{kudomon.species}?"
        kudomon.name = gets.chomp
        @collection << kudomon
    end
    
    def move(delta)
        new_x = @position[:x] + delta[0]
        new_y = position[:y] + delta[1]
        if new_x < 0 || new_y < 0
            puts "You can't move in that direction."
        else
            @position[:x] = new_x
            @position[:y] = new_y
        end
        puts @position
    end
    
    def heal
        @collection.each { |k| k.hp = KUDOMON[k.species][:hp] }
        puts "Your kudomon have been healed back to full health."
    end
end

def random_kudomon(position=nil)
    species = KUDOMON.keys[rand(KUDOMON.length)]
    Kudomon.new(species,position)
end

