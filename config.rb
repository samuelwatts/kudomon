KUDOMON = {
    "Sourbulb" => { type: :grass, hp: 45, cp: 8 },
    "Mancharred" => { type: :fire, hp: 39, cp: 10 },
    "Chikapu" => { type: :electric, hp: 35, cp: 12 },
    "Tursqule" => { type: :water, hp: 44, cp: 8 },
    "Xino" => { type: :rock, hp: 35, cp: 10 },
    "Mu" => { type: :psychic, hp: 60, cp: 14 }
}
#Constants
MAP_SIZE = 5

NO_OF_KUDOMON = 10

NEARBY = 3

SUPER_EFFECTIVE_FACTOR = 1.5

# To record battle outcome
RUN_AWAY = 0
LOSS = 1
VICTORY = 2

# Hash of types in order of strength. Each type is super effective against the one it's mapped to.
# :psychic is treated separately
SUPER_EFFECTIVE = {
    :water => :fire,
    :fire => :grass,
    :grass => :rock,
    :rock => :electric,
    :electric => :water
}
