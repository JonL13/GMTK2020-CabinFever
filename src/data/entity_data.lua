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
            },
            ['attack'] = {
                frames = {1,2,3},
                interval = .1,
                texture = 'sprites'
            },
            ['crazy'] = {
                frames = {2,18,3,17},
                interval = .2,
                texture = 'sprites'
            },
        }
    },
    ['zombie'] = {
        walkSpeed = ZOMBIE_WALK_SPEED,
        animations = {
            ['walk'] = {
                frames = {17,18},
                interval = .6,
                texture = 'sprites'
            },
            ['idle'] = {
                frames = {16},
                interval = 1,
                texture = 'sprites'
            }
        }
    }
}