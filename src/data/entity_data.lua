ENTITY_DEFS = {
    ['player'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        maxHealth = PLAYER_MAX_HEALTH,
        animations = {
            ['walk'] = {
                frames = {2,3},
                interval = .3,
                texture = 'sprites'
            },
            ['idle'] = {
                frames = {1},
                interval = 1,
                texture = 'sprites'
            }
        }
    },
    ['zombie'] = {
        walkSpeed = ZOMBIE_WALK_SPEED,
        animations = {
            ['walk'] = {
                frames = {16,17},
                interval = .6,
                texture = 'sprites'
            }
        }
    }
}