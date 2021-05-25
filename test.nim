# nim c -d:release -d:danger --app:lib test.nim

import playerClass
import foreignPlayerClass
import dksUtils

var player = newPlayer()
#[
player.health[] = 1
player.maxHealth[] = 2
player.mana[] = 0
player.maxMana[] = 1
player.strength[] = 23
player.intelligence[] = 99
player.z[] = 1000
player.angle[] = 1.24
player.disableGravity()

addSoul(player.param[], 42069)
player.spEffectId[] = 530
spEffect( spEffectBase,  3 )

itemGibRaw(
  mapItemMan, # Define mapItemMan in this file if it still fails
  [ 1.int32, 0x400001F4.int32, 2.int32, cast[int32](0xFFFFFFFF) ]
  )
]#

import winim
import strutils
import os

while true:
  if GetKey(0x51): # VK_Q
    break
  elif GetKey(0x48): # VK_H
    player.itemGib(0x400001F4, 7)
  elif GetKey(0x4A): # VK_J
    #([[[[[BaseB]+40]+38]+18]+28]+80,12)
    var
      fp1 = newPlayerForeign(1)
    #writeFile("C:\\Users\\hel\\Documents\\NimWorkspace\\dark souls 3\\output.txt", $coords)
    writeFile("C:\\Users\\hel\\Documents\\NimWorkspace\\dark souls 3\\output.txt", $player.getAngle())
  sleep(100)

#[
import winim
import strutils

while true:
  if GetKey(0x51): # VK_Q
    break
  elif GetKey(0x48): # VK_H
    player.itemGib(0x400001F4, 5)
  elif GetKey(0x4A): # VK_J
    var fp1 = newPlayerForeign(1)
    #writeFile("C:\\Users\\hel\\Documents\\NimWorkspace\\dark souls 3\\output.txt", fp1.level[].intToStr())
    var buf = ""
    for i in fp1.name[]:
      if i == '\x00'"
      buf.add(i)
    writeFile("C:\\Users\\hel\\Documents\\NimWorkspace\\dark souls 3\\output.txt", buf)
  sleep(100)
]#
