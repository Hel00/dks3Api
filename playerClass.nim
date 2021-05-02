import winim
import bitops

# Function that just get's an offset, basically like cheat engine does
# usage will explain gud
proc getOffset(processHandle: HANDLE, offsets: seq[int64]): int64 =
  var
    value: int64
  for i in 0 .. offsets.len - 1:
    discard ReadProcessMemory(processHandle, cast[LPVOID](value + offsets[i]), LPVOID(addr(value)), SIZE_T(sizeof(value)), nil)
  return value

# Function types
type
  InvadeProc    = proc(base: int64, invadeType: int) {.fastcall.}
  AddSoulProc   = proc(playerParamBase: int64, souls: int) {.fastcall.}
  AddEffectProc = proc(playerBase: int64, effect: int) {.fastcall.}

# Just some initialization and bases
let
  processHandle = GetCurrentProcess()
  BaseA: int64 = 0x144740178
  BaseB: int64 = 0x144768E78
  addSoulBase: int64 = getOffset(processHandle, @[BaseB, 0x80, 0x1FA0])
  addSoul = cast[AddSoulProc](0x1405A3310)
  addEffect = cast[AddEffectProc](0x140886C40)

# Player class with its stats and shit
type
  Player = object
    base: ptr int64
    param: ptr int64

    # Current stats
    health:  ptr int64
    mana:    ptr int64
    stamina: ptr int64

    # Base stats
    baseHealth:  ptr int64
    baseMana:    ptr int64
    baseStamina: ptr int64

    # Max stats
    maxHealth:  ptr int64
    maxMana:    ptr int64
    maxStamina: ptr int64

    # Attributes
    soulAmount: ptr int64
    soulLevel:  ptr int64
    humanity:   ptr int64

    vigor:        ptr int64
    attunement:   ptr int64
    endurance:    ptr int64
    vitality:     ptr int64
    strength:     ptr int64
    dexterity:    ptr int64
    intelligence: ptr int64
    faith:        ptr int64
    luck:         ptr int64

    # Resistances
    poison: ptr int64
    toxic:  ptr int64
    bleed:  ptr int64
    curse:  ptr int64
    frost:  ptr int64

    # Max resistances
    maxPoison: ptr int64
    maxToxic:  ptr int64
    maxBleed:  ptr int64
    maxCurse:  ptr int64
    maxFrost:  ptr int64

    # Player flags
    noHitFlag:            ptr byte
    noAttackFlag:         ptr byte
    noMoveFlag:           ptr byte
    noGoodsConsumeFlag:   ptr byte
    noUpdateFlag:         ptr byte
    disableGravityFlag:   ptr byte
    noDeadFlag:           ptr byte
    noDamageFlag:         ptr byte
    noStaminaConsumeFlag: ptr byte
    noManaConsumeFlag:    ptr byte
    invulnerabilityFlag:  ptr byte
    iFramesFlag:          ptr byte
    parryFlag:            ptr byte
    eventSuperArmorFlag:  ptr byte
    enableCharAsmFlag:    ptr byte

    # Position
    x:     ptr float64
    y:     ptr float64
    z:     ptr float64
    angle: ptr float64

    # Player param
    playerNo: ptr int64
    playerId: ptr int64

# Constructor for the Player class
proc newPlayer(): Player =
  result.base  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80] ) )
  result.param = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0] ) )
  # Current stats
  result.health  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xD8 )
  result.mana    = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xDC )
  result.stamina = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xE0 )

  # Base stats
  result.baseHealth  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xE4 )
  result.baseMana    = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xE8 )
  result.baseStamina = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xEC )

  # Max stats
  result.maxHealth  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xF0 )
  result.maxMana    = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xF4 )
  result.maxStamina = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0xF8 )

  # Attributes
  result.vigor        = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x44 )
  result.attunement   = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x48 )
  result.endurance    = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x4C )
  result.vitality     = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x6C )
  result.strength     = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x50 )
  result.dexterity    = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x54 )
  result.intelligence = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x58 )
  result.faith        = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x5C )
  result.luck         = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x60 )

  # Resistances
  result.poison = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1E0 )
  result.toxic  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1E4 )
  result.bleed  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1E8 )
  result.curse  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1EC )
  result.frost  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1F0 )

  # Max resistances
  result.maxPoison = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1F4 )
  result.maxToxic  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1F8 )
  result.maxBleed  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x1FC )
  result.maxCurse  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x200 )
  result.maxFrost  = cast[ptr int64] ( getOffset( processHandle, @[BaseB, 0x80, 0x1FA0, 0x18] ) + 0x204 )

  # Player flags
  result.noHitFlag            = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1ED8 )
  result.noAttackFlag         = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1ED8 )
  result.noMoveFlag           = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1ED8 )
  result.noGoodsConsumeFlag   = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1ED8 )
  result.noUpdateFlag         = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1EE9 )
  result.disableGravityFlag   = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1A08 )
  result.noDeadFlag           = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0x1C0 )
  result.noDamageFlag         = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0x1C0 )
  result.noStaminaConsumeFlag = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0x1C0 )
  result.noManaConsumeFlag    = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18] ) + 0x1C0 )
  result.invulnerabilityFlag  = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80] ) + 0x1A09 )
  result.iFramesFlag          = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x0] ) + 0x58 )
  result.parryFlag            = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x0] ) + 0x58 )
  result.eventSuperArmorFlag  = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x10] ) + 0x40 )
  result.enableCharAsmFlag    = cast[ptr byte] ( getOffset( processHandle, @[BaseB, 0x80, 0x1F90, 0x18, 0x8] ) + 0x2098 )

  # Position
  result.x     = cast[ptr float64] ( getOffset( processHandle, @[BaseB, 0x40, 0x28] ) + 0x80 )
  result.y     = cast[ptr float64] ( getOffset( processHandle, @[BaseB, 0x40, 0x28] ) + 0x84 )
  result.z     = cast[ptr float64] ( getOffset( processHandle, @[BaseB, 0x40, 0x28] ) + 0x88 )
  result.angle = cast[ptr float64] ( getOffset( processHandle, @[BaseB, 0x40, 0x28] ) + 0x74 )

  # Player param
  result.playerNo = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x10 )
  result.playerId = cast[ptr int64] ( getOffset( processHandle, @[BaseA, 0x10] ) + 0x14 )


# Player class methods
proc noHit           (this: var Player) = flipBit( this.noHitFlag[], 5 )
proc noAttack        (this: var Player) = flipBit( this.noAttackFlag[], 6 )
proc noMove          (this: var Player) = flipBit( this.noMoveFlag[], 7 )
proc noGoodsConsume  (this: var Player) = flipBit( this.noGoodsConsumeFlag[], 3 )
proc noUpdate        (this: var Player) = flipBit( this.noUpdateFlag[], 3 )
proc disableGravity  (this: var Player) = flipBit( this.disableGravityFlag[], 6 )
proc noDead          (this: var Player) = flipBit( this.noDeadFlag[], 2 )
proc noDamage        (this: var Player) = flipBit( this.noDamageFlag[], 1 )
proc noStaminaConsum (this: var Player) = flipBit( this.noStaminaConsumeFlag[], 4 )
proc noManaConsume   (this: var Player) = flipBit( this.noManaConsumeFlag[], 5 )
proc invulnerability (this: var Player) = flipBit( this.invulnerabilityFlag[], 7 )
proc iFrames         (this: var Player) = flipBit( this.iFramesFlag[], 1 )
proc parry           (this: var Player) = flipBit( this.parryFlag[], 2 )
proc eventSuperArmor (this: var Player) = flipBit( this.eventSuperArmorFlag[], 0 )

# Test

var player = newPlayer()

#[player.health[] = 1
player.maxHealth[] = 2
player.mana[] = 0
player.maxMana[] = 1
player.strength[] = 23
player.intelligence[] = 99
player.z[] = 1000
player.angle[] = 1.24
player.disableGravity()]#

addSoul(player.param[], 42069)
addEffect(player.base[], 33)
