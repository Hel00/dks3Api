type
    PlayerForeign* = object
        # Basic stats and data
        name:          ptr string
        steamId:       ptr string
        level:         ptr int
        health:        ptr int
        maxBaseHp:     ptr int
        maxHp:         ptr int
        maxStamina:    ptr int
        maxFp:         ptr int
        characterType: ptr int
        teamType:      ptr int
        covenant:      ptr byte

        # Attributes
        vigor:        ptr int64
        attunement:   ptr int64
        endurance:    ptr int64
        vitality:     ptr int64
        strength:     ptr int64
        dexterity:    ptr int64
        intelligence: ptr int64
        faith:        ptr int64
        luck:         ptr int64

        # Misc info
        invadeType:                  ptr byte
        natType:                     ptr int
        gender:                      ptr byte
        chrType:                     ptr int
        region:                      ptr int
        multiPlayCount:              ptr int
        coopPlayCount:               ptr int
        thiefInvadePlaySuccessCount: ptr int
        darkSpiritDefeatCount:       ptr int
        hostDefeatCountCount:        ptr int

proc newPlayerForeign*(playerNum: int8): PlayerForeign =
  var
    foreignPlayerBase: int
  if   playerNum == 1: foreignPlayerBase = 0x38
  elif playerNum == 2: foreignPlayerBase = 0x70
  elif playerNum == 3: foreignPlayerBase = 0xA8
  elif playerNum == 4: foreignPlayerBase = 0xE0
  elif playerNum == 5: foreignPlayerBase = 0x118

  # Basic stats and data
  result.name          = cast[ptr string] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x88] ) )
  result.steamId       = cast[ptr string] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x7D8] ) )
  result.level         = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x70] ) )
  result.health        = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x18] ) )
  result.maxBaseHp     = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x20] ) )
  result.maxHp         = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x1C] ) )
  result.maxStamina    = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x3c] ) )
  result.maxFp         = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x2C] ) )
  result.characterType = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x70] ) )
  result.teamType      = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x74] ) )
  result.covenant      = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xF7] ) )

  # Attributes
  result.vigor        = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x44] ) )
  result.attunement   = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x48] ) )
  result.endurance    = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x4C] ) )
  result.vitality     = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x6C] ) )
  result.strength     = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x50] ) )
  result.dexterity    = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x54] ) )
  result.intelligence = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x58] ) )
  result.faith        = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x5C] ) )
  result.luck         = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x60] ) )

  # Misc info
  result.invadeType                  = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xFD] ) )
  result.natType                     = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x804] ) )
  result.gender                      = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xAA] ) )
  result.chrType                     = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x84] ) )
  result.region                      = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x136] ) )
  result.multiPlayCount              = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xB4] ) )
  result.coopPlayCount               = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xB8] ) )
  result.thiefInvadePlaySuccessCount = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0xBC] ) )
  result.darkSpiritDefeatCount       = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x11C] ) )
  result.hostDefeatCountCount        = cast[ptr int] ( getOffset( processHandle, @[BaseB, 0x40, foreignPlayerBase, 0x1FA0, 0x120] ) )
