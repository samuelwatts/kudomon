# Fight between individual kudomon
def kudomon_battle(trainer_kudomon,enemy_kudomon)
    puts "#{trainer_kudomon.name} HP:#{trainer_kudomon.hp} is fighting #{enemy_kudomon.name} HP:#{enemy_kudomon.hp}"
    #Randomly decide who attacks first
    my_turn = rand(1) == 1
    # Work out if they're super effective against each other
    trainer_effective = super_effective(trainer_kudomon.type,enemy_kudomon.type)
    enemy_effective = super_effective(enemy_kudomon.type,trainer_kudomon.type)
    
    #Battle until one faints
    while trainer_kudomon.hp > 0 && enemy_kudomon.hp > 0 do
        if my_turn
            damage = (trainer_kudomon.cp * trainer_effective).round.to_i
            puts "#{trainer_kudomon.name} attacks causing #{damage} damage!#{' It is super effective!' if trainer_effective > 1}"
            enemy_kudomon.hp -= trainer_kudomon.cp
            my_turn = false
        else
            damage = (enemy_kudomon.cp * enemy_effective).round.to_i
            puts "#{enemy_kudomon.name} attacks causing #{damage} damage!#{' It is super effective!' if enemy_effective > 1}"
            trainer_kudomon.hp -= enemy_kudomon.cp
            my_turn = true
        end
    end
    
    if trainer_kudomon.hp <= 0
        puts "Your Kudomon #{trainer_kudomon.name} faints!"
        puts "#{enemy_kudomon.name} still has #{enemy_kudomon.hp} HP left."
        return false
    else
        puts "#{enemy_kudomon.name} faints!"
        puts "#{trainer_kudomon.name} still has #{trainer_kudomon.hp} HP left."
        return true
    end
end

# Battle between collections of kudomon. Currently enemy is only one wild kudomon but can be used for trainer v trainer battles in future
def battle(trainer_collection,enemy_collection)
    keep_fighting = true
    # Create copies of collections, as we remove elements
    trainer_collection = trainer_collection.collect{|k| k }
    enemy_collection = enemy_collection.collect{|k| k }
    
    while trainer_collection.any? && enemy_collection.any? && keep_fighting
        puts "You have #{trainer_collection.length} kudomon ready to fight."
        # Select random kudomon from collections to fight each other
        trainer_kudomon = trainer_collection.sample
        enemy_kudomon = enemy_collection.sample
        # Remove losing kudomon from collection
        if kudomon_battle(trainer_kudomon,enemy_kudomon)
            enemy_collection.delete(enemy_kudomon)
        else
            trainer_collection.delete(trainer_kudomon)
        end
        
        if trainer_collection.any? && enemy_collection.any?
            puts "Do you want to keep fighting? Y/N"
            unless gets.chomp.capitalize == "Y"
                keep_fighting = false
                puts "You run away."
                return RUN_AWAY
            end
        elsif trainer_collection.empty?
            puts "You lost."
            return LOSS
        else
            puts "You won! Awesome!"
            return VICTORY
        end
    end
end

# Calculate multiplier of attack
def super_effective(type1, type2)
    # Psychic effective against everything non-pyschic
    if type1 == :psychic && type2 != :psychic
        return SUPER_EFFECTIVE_FACTOR
    elsif SUPER_EFFECTIVE[type1] == type2
        return SUPER_EFFECTIVE_FACTOR
    else
        return 1
    end
end


