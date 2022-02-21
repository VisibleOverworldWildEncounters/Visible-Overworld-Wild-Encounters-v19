
  #====================================================================#
  #                                                                    #
  #     Visible Overworld Wild Encounters V19.1,0.1 for PEv19.1        #
  #                         - by derFischae (Credits if used please)   #
  #                                                                    #
  #====================================================================#

# UPDATED TO VERSION 19.1.0.1 FOR POKEMON ESSENTIALS V19.1. REDESIGNED as a PLUGIN.
# This script is for Pokémon Essentials v19 and v19.1 (for short PEv19).

# As in Pokemon Let's go Pikachu/Eevee or Pokemon Shild and Sword wild encounters
# pop up on the overworld, they move around and you can start the battle with
# them simply by moving to the pokemon. Clearly, you also can omit the battle
# by circling around them.


#===============================================================================
#            FEATURES
#===============================================================================

#  [*] set steps a pokemon remains on map before despawning depending on pokemon properties 
#  [*] Choose whether you can battle water pokemon while not surfing or not
#  [*] In water pokemon won't spawn above other tiles, which made them stuck or walk on ground
# UPSCALED FEATURES INCLUDED from PEv18:
#  [*] see the pokemon on the overworld before going into battle
#  [*] no forced battling against overworld encounters
#  [*] plays the pokemon cry while spawning
#  [*] Choose whether encounters occure on all terrains or only on the terrain of the player
#  [*] you can have instant wild battle and overworld spawning at the same time and set the propability of that by default and change it ingame and store it with a $game_variable
#  [*] In caves, pokemon don't spawn on impassable Rock-Tiles, which have the Tile-ID 4 
#  [*] You can check during the events @@OnWildPokemonCreate, @@OnStartBattle, ... if you are battling a spawned pokemon with the global variable $PokemonGlobal.battlingSpawnedPokemon
#  [*] You can check during the event @@OnWildPokemonCreate if the pokemon is created for spawning on the map or created for a different reason with the Global variable $PokemonGlobal.creatingSpawningPokemon
#  [*] If you want to add a procedure that modifies a pokemon only for spawning but not before battling then you can use the Event @@OnWildPokemonCreateForSpawning.
# ADDITIONAL FEATURES BY ADD-ONS:
#  [*] Additional Animations Add-On
#    [*] manage different appear animations of overworld spawning encounters depending on encounter type and pokemon properties
#    [*] Play animations while PokeEvent is visible on screen, such as a shiny animation
#  [*] Different Spawn And Normal Encounters (like in Pokemon Sword/Shield) Add-On
#    [*] Introduces Overworld Encounter Types you can set in your encounters.txt PBS-file.
#    [*] This allows you to define different encounters for overworld spawning and instant battling on the same map.
#  [*] Max Spawn Add-On
#    [*] Define a maximal limit of spawned pokemon on the overworld at the same time.
#    [*] After reaching that limit MAX_SPAWN no pokemon will spawn until another pokemon despawned.
#  [*] Additional Despawn Methods Add-On
#    [*] Choose to remove PokeEvent distanced on screen from the player with REMOVE_DISTANCED
#    [*] The distance (steps) is edited in DISTANCE_VANISH and DISTANCE_VANISH_SHINY
#    [*] Remove by time chronometer with REMOVE_PROLONGED
#    [*] Use your own overworld spawn chance in VISIBLE_ENCOUNTER_PROBABILITY
#  [*] Fixed Spawn Probability Add-On
#    [*] Define your own overworld spawn chance in Percentage
#    [*] Spawn chance becomes independent from the default PEv19.1 encounter chance calculator
#  [*] Variable Spawn/Normal Encounter Proportion During Game  
#    [*] You can change the percentage between overworld spawning and normal encounters in story driven events during playthrough
#    [*] in Percentage, from only normal encounters to only spawning encounters
#  [*] Remove Poke Events on load/save/transfer Add-On
#    [*] Remove overworld encounters on load/save and on map transfer
#  [*] Overworld Lavender Town Ghosts Add-On
#    [*] Shows ghost sprite for overworld encounters, needs Lavender Town Ghosts Plugin 


#===============================================================================
#            INSTALLATION
#===============================================================================

# Installation as simple as it can be.
# [1] Add Graphics: Either get the resources from Gen 8 Project [url]https://reliccastle.com/resources/670/[/url]
#  and install the "Graphics/Characters" folder in your game file system.
#  Or you place your own sprites for your pokemon/fakemon with the right names in your "\Graphics\Characters\Follower" folder and your shiny sprites in your "\Graphics\Characters\Follower shiny" folder. 
#  The right name of sprites is:
#    usual form     - SPECIES.png   where SPECIES is the species name in capslock (e.g. PIDGEY.png)
#    alternate form - SPECIES_n.png where n is the number of the form (e.g. PIKACHU_3.png)
#    female form    - SPECIES_female.png or SPECIES_n_female (e.g. PIDGEY_female.png or PIKACHU_3_female.png)
# [2] Add Script: Copy the folder "Visible Overworld Wild Encounters - Script" in your "/plugins/" folder.
# [3] Install Add-Ons (from the other folders): There are a lot of Add-Ons and parameter settings for your personal optimal solution. So, install Add-Ons and edit parameters in settings to your liking.
#  Some Add-On and parameter combinations can produce lag, e.g. a high spawning rate without a spawning cap, or e.g. "NO_OF_CHOSEN_TILES=0" (or too high) when having other scripts like Pokemon Following.
# [4] If you use any other script that triggers on change of direction of the player, then either 
#     [*] these scripts have to be below this visible overworld wild encounter script, or
#     [*] you have to use the bug fix for OnChangeDirection (See below).
# [5] Enjoy!


#===============================================================================
#             CHANGELOG
#===============================================================================

# NEW FEATURES FROM VERSION 19.1.0,1 FOR PEv19:
#  - bug fix concerning roaming pokemon
#  - included an easy way to set the steps a pokemon remains on map before despawning depending on pokemon properties 
#  - rearranged features of previous version as add-ons, including
#     - trigger different appear animations depending on encounter type, shinyness
#     - shiny animation while PokeEvent is visible on screen
#     - stop more pokemon from spawning with the MAX_SPAWN parameter
#     - choose wether remove distanced spawned pokemon or not with REMOVE_DISTANCED parameter
#     - choose wether remove by time chronometer or not with REMOVE_PROLONGED
#     - added to add your own overworld encounter chance with VISIBLE_ENCOUNTER_PROBABILITY

# NEW FEATURES FROM VERSION 19.0.10 FOR PEv19:
#  - fixed water pokemon spawning in platform above water tile
#  - water pokemon won't appear in the border
#  - choose wether battling water pokemon from ground or not with BATTLE_WATER_ONGROUND parameter
#  - stop more pokemon from spawning with the MAX_SPAWN parameter
#  - choose wether remove distanced spawned pokemon or not with REMOVE_DISTANCED parameter
#  - shiny animation while PokeEvent is visible on screen
#  - choose wether remove by time chronometer or not with REMOVE_PROLONGED
#  - added to add your own chance with VISIBLE_ENCOUNTER_PROBABILITY
#  - aggressive ecounters restricted to player movements
#
# NEW FEATURES FROM VERSION 19.0.9 FOR PEv19:
#  - updated script to work with PEv19.1
#  - used $PokemonTemp.encounterType to trigger diferent appear animations
#  - added alternative stepcount before vanishining for shiny pokemon
#
# NEW FEATURES FROM VERSION 18.0.8 FOR PEv18:
#  - tiny bug fix for $PokemonTemp.encounterType
#
# NEW FEATURES FROM VERSION 18.0.7 FOR PEv18:
#  - removed a bug concerning changing the standard form when goining into battle
#
# NEW FEATURES FROM VERSION 18.0.6 FOR PEv18:
#   - (hopefully) removed a rare crash concerning character_sprites
#
# NEW FEATURES FROM VERSION 2.0.5 FOR PEv18:
#   - removed bug that makes all water encounter vanish
#
# NEW FEATURES FROM VERSION 2.0.4 FOR PEv18:
#   - encounters dont spawn on impassable tiles in caves
#
# NEW FEATURES FROM VERSION 2.0.3 FOR PEv18:
#   - poke radar works as usual
#
# NEW FEATURES FROM VERSION 2.0.2 FOR PEv18:
#   - added new global variable $PokemonGlobal.creatingSpawningPokemon to check during the event @@OnWildPokemonCreate if the pokemon is created for spawning on the map or created for a different reason
#
# UPSCALED FEATURES FROM VERSION 2.0.1 FOR PEv17.2:
#   - less lag
#   - supports sprites for alternative forms of pokemon
#   - supports sprites for female/male/genderless pokemon
#   - bug fixes for roaming encounter and double battles
#   - more options in settings
#   - roaming encounters working correctly
#   - more lag reduction 
#   - included automatic spawning of pokemon, i.e. spawning without having to move the player
#   - included vendilys rescue chain, i. e. if pokemon of the same species family spawn in a row and will be battled in a row, then you increase the chance of spawning
#     an evolved pokemon of that species family. Link: https://www.pokecommunity.com/showthread.php?t=415524
#   - removed bug occuring after fainting against wild overworld encounter
#   - for script-developers, shortened the spawnPokeEvent method for better readablitiy
#   - removed bugs from version 1.9
#   - added shapes of overworld encounter for rescue chain users
#   - supports spawning of alternate forms while chaining
#   - if overworld sprites for alternative, female or shiny forms are missing,
#     then the standard sprite will be displayed instead of an invisible event
#   - bug fix for shiny encounters
#   - respecting shiny state for normal encounters when using overworld and normal encounters at the same time
#   - easier chaining concerning Vendilys Rescue chain, i.e. no more resetting of the chain when spawning of a pokemon of different family but when fighting with a pokemon of different family
#   - Added new Event @@OnPokemonCreateForSpawning which only triggers on spawning
#   - Added new global variable $PokemonGlobal.battlingSpawnedShiny to check if an active battle is against a spawned pokemon.
#   - removed bug to make the new features in version 1.11 work
#   - reorganised and thin out the code to organise code as add-ons
#   - removed Vendilys Rescue Chain, Let's Go Shiny Hunting and automatic spawning as hard coded feature and provide it as Add-Ons instead
#   - Now, using overworld and normal encounters at the same time is a standard feature
#   - autospawning will not trigger instant battles anymore
#   - removed a bug that came from reorganising the code in original code and add-ons concerning Let's go shiny hunting add-on

#===============================================================================
#                             Settings            
#===============================================================================

module VisibleEncounterSettings
  #------------- SPAWN RATE AND SPAWN PROPABILITY ------------ 
  INSTANT_WILD_BATTLE_PROPABILITY = 0 # default 0.
  # This parameter holds the default propability of normal to overworld encountering.
  # The propability is stored in percentage with possible values 0,1,2,...,100.
  # <= 0           - means only overworld encounters, no instant battles
  # > 0 and < 100  - means overworld encounters and normal encounters at the same time.
  # >= 100         - means only normal encounters and instant battles as usual, no overworld spawning
  
  NO_OF_CHOSEN_TILES = 1 # default 1
  # Pokemon only spawn on allowed ground. This parameter needs to be an integer.
  # It says up to how many different, random tiles in SPAWN_RANGE to the player
  # will be checked for beeing allowed spawning ground.
  # = 0  - means that it will choose a random tile until one of them 
  #       is possible to spawn a pokemon or all tiles in SPAWN_RANGE to the player were chosen
  #       (this will increase the spawn probability)
  #       (may cause lag with other scripts)
  # = 1  - means that only one random tile around the player will be chosen
  # > 1   - maximal number of chosen tiles to find a possible tile where a pokemon can spawn
  #         (the more you use, more performance needed)
  
  #--------------- SPAWN POSITION ------------------
  SPAWN_RANGE = 4 # default 4
  # This parameter needs to be a positive integer. It is the maximum range from the player a PokeEvent will be able to spawn 

  RESTRICT_ENCOUNTERS_TO_PLAYER_MOVEMENT = false # default false
  # true - means that water encounters are popping up
  #       if and only if player is surfing
  #       (perhaps decreases encounter rate)
  # false - means that all encounter types can pop up
  #        close to the player (as long as there is a suitable tile)
  
  NO_SPAWN_ON_BORDER = false # default false
  # true  - means that pokemon on water won't spawn in the border
  # false - means that pokemon will also spawn on the border of water   

  #--------------- DIFFERENT POKEEVENTS --------------------
  AGGRESSIVE_ENCOUNTER_PROBABILITY = 20 # default 20 
  #this is the probability in percent of spawning of an aggressive encounter, that runs to you
  #0   - means that there are no aggressive encounters
  #100 - means that all encounter are aggressive
  
  #---------------- GRAPHICS OF SPAWNED POKEMON -------------------
  SPRITES = [true, true, true] # default [true, true, true]
  # This parameter must be an array [alt_form, female, shiny] of three bools.
  # alt_form/ female/ shiny = false means: you don't use alternative/ female/ shiny sprites for your overworld encounter.
  #                         = true  means: alternative forms/ female forms/ shiny pokemon have there own special overworld sprite.
  # If true, make sure that you have the overworld sprites with the right name in your "\Graphics\Characters\Follower" folder
  # and that you have the shiny overworld sprites with the same name in your "\Graphics\Characters\Follower shiny" folder.
  # The right name of sprites:
  #  usual form     - SPECIES.png   where SPECIES is the species name in capslock (e.g. PIDGEY.png)
  #  alternate form - SPECIES_n.png where n is the number of the form (e.g. PIKACHU_3.png)
  #  female form    - SPECIES_female.png or SPECIES_n_female (e.g. PIDGEY_female.png or PIKACHU_3_female.png)
  
  USE_STEP_ANIMATION = true # default true
  #false - means that overworld encounters don't have a stop- animation
  #true - means that overworld encounters have a stop- animation similar as  
  #       following pokemon
  
  #------------------- MOVEMENT OF SPAWNED POKEMON -----------------------
  DEFAULT_MOVEMENT = [3, 3, 1] # default [3, 3, 1]
  # This parameter stores an array [move_speed, move_frequency, move_type] of three integers where
  # move_speed/ move_frequency/ move_type is the default movement speed/ frequency/ type of spawned PokeEvents.
  # See RPGMakerXP for more details (compare to autonomous movement of events).
  # speed/ frequency = 1   - means lowest movement speed/ frequency
  # speed/ frequency = 6   - means highest movement speed/ frequency
  # type = 0/ 1/ 3         - means no movement/ random movement/ run to player
  # ...

  ENC_MOVEMENTS = [                  # default
    [:aggressive, true, 3, 5, 3],    # [:aggressive, true, 3, 5, 3] means that aggressive encounters will be faster and run to the player
    [:species, :SLOWPOKE, 1, 1, nil] # [:species, :SLOWPOKE, 1, 1, nil] means that slowpoke is very slow. It might still want to run random or to the player.
  ]
  # This parameter is used to change movement of spawned PokeEvents depending on the spawned pokemon.
  # The data is stored as an array of arrays. You can add your own 
  # The data is stored as an array of entries [variable, value, move_speed, move_frequency, move_type], where variable
  # is a variable or method which does not require parameters of the class Pokemon,
  # value is a possible outcome value of variable and move_speed, move_frequency and move_type are the movement speed,
  # frequency and type all PokeEvents should get if value == pokemon.variable.
  # nil  - means that the movement-parameter will not be changed.

  #--------------- BATTLING SPAWNED POKEMON ------------------
  BATTLE_WATER_FROM_GROUND = true #default true
  # this is used if you want to battle water pokemon without surfing
  # (default is true but I think is better in false)
  #false - means the battle wont start if not surfing 
  #true - means you can battle from the ground a pokemon from the water

  #--------------- VANISHING OF SPAWNED POKEMON AFTER STEPS -------------------
  DEFAULT_STEPS_BEFORE_VANISH = 10 # default 10
  # This is the number of steps a wild encounter goes by default before vanishing on the map.

  ADD_STEPS_BEFORE_VANISH = [ # default
    [:shiny?, true, 8],       # [:shiny, true, 8]       - means that spawned shiny pokemon will more 8 steps longer on the map than default.
    [:aggressive, true, 6],   # [:aggressive, true, 6]  - means that spawned shiny pokemon will stay longer (6 steps more) on the map
    [:species, :PIDGEY, -2]   # [:species, :PIDGEY, -2] - means that pidgeys will be gone faster (2 steps earlier).
  ]
  # This is an array of arrays. You can add your own conditions as an additional array. It must be of the form [variable, value, number] where
  # variable is a variable or an method that does not need any parameters of the class Pokemon,
  # value is a possible value of variable and number is the number of steps an pokemon goes more (or less) than default before vanishing on the map 
  # if it satisfies pokemon.variable == value
  
end

#===============================================================================
#                              THE SCRIPT
#===============================================================================

          #########################################################
          #                                                       #
          #      0. PART: BUG FIX FOR ONCHANGEDIRECTION           #
          #                                                       #
          #########################################################

#===============================================================================
# (Bug Fix for Events.onChangeDirection)
#   - ChangeDirection will be considered as taking a step
#===============================================================================

Events.onChangeDirection.clear
# Notice that this will clear everything related to onChangeDirection
# (on PEv19.1 there is only one proc, so this entire script must be above
#  any other script by the community that uses it)

Events.onChangeDirection += proc {
  pbBattleOrSpawnOnStepTaken($PokemonGlobal.repel > 0) if !$game_temp.in_menu
}


          #########################################################
          #                                                       #
          #      1. PART: SPAWNING THE OVERWORLD ENCOUNTER        #
          #                                                       #
          #########################################################


#===============================================================================
# We override the original method "pbOnStepTaken" in Script Overworld it was 
# originally used for wild encounter battles
#===============================================================================
def pbOnStepTaken(eventTriggered)
  if $game_player.move_route_forcing || pbMapInterpreterRunning?
    Events.onStepTakenFieldMovement.trigger(nil,$game_player)
    return
  end
  $PokemonGlobal.stepcount = 0 if !$PokemonGlobal.stepcount
  $PokemonGlobal.stepcount += 1
  $PokemonGlobal.stepcount &= 0x7FFFFFFF
  repel_active = ($PokemonGlobal.repel > 0)
  Events.onStepTaken.trigger(nil)
#  Events.onStepTakenFieldMovement.trigger(nil,$game_player)
  handled = [nil]
  Events.onStepTakenTransferPossible.trigger(nil,handled)
  return if handled[0]
  if !eventTriggered && !$game_temp.in_menu
    pbBattleOrSpawnOnStepTaken(repel_active)
  end
  $PokemonTemp.encounterTriggered = false   # This info isn't needed here
end

#===============================================================================
# new Method to decide pbBattleOrSpawnOnStepTaken if if a normal encounter
# encounters or an overworld pokemon spawns
#===============================================================================
def pbBattleOrSpawnOnStepTaken(repel_active)
  if (rand(100) < VisibleEncounterSettings::INSTANT_WILD_BATTLE_PROPABILITY) || pbPokeRadarOnShakingGrass
    pbBattleOnStepTaken(repel_active) # STANDARD WILD BATTLE
  else
    pbSpawnOnStepTaken(repel_active)  # OVERWORLD ENCOUNTERS
  end
end

#===============================================================================
# new method pbSpawnOnStepTaken working almost like pbBattleOnStepTaken
#===============================================================================
def pbSpawnOnStepTaken(repel_active)
  return if $Trainer.able_pokemon_count == 0 #check if trainer has pokemon
  #First we decide if there are too many PokeEvents encounters in current map
  pos = pbChooseTileOnStepTaken
  return if !pos
  encounter_type = $PokemonEncounters.encounter_type_on_tile(pos[0],pos[1])
  return if !encounter_type
  return if !$PokemonEncounters.encounter_triggered_on_tile?(encounter_type, repel_active, true)
  $PokemonTemp.encounterType = encounter_type
  encounter = $PokemonEncounters.choose_wild_pokemon(encounter_type)
  encounter = EncounterModifier.trigger(encounter)
  if $PokemonEncounters.allow_encounter?(encounter, repel_active)
    $PokemonGlobal.creatingSpawningPokemon = true
    pokemon = pbGenerateWildPokemon(encounter[0],encounter[1])
    # trigger event on spawning of pokemon
    Events.onWildPokemonCreateForSpawning.trigger(nil,pokemon)
    $PokemonGlobal.creatingSpawningPokemon = false
    pbPlaceEncounter(pos[0],pos[1],pokemon)
    # $PokemonEncounters.reset_step_count # added such that your encounter rate resets after spawning of an overworld pokemon 
    $PokemonTemp.encounterType = nil
    $PokemonTemp.encounterTriggered = true
  end
  $PokemonTemp.forceSingleBattle = false
  EncounterModifier.triggerEncounterEndSpawn
  EncounterModifier.triggerEncounterEnd
end

#===============================================================================
# new method pbChooseTileOnStepTaken to choose the tile on which the pkmn spawns 
#===============================================================================
def pbChooseTileOnStepTaken
  x = $game_player.x
  y = $game_player.y
  range = VisibleEncounterSettings::SPAWN_RANGE
  rolls = VisibleEncounterSettings::NO_OF_CHOSEN_TILES # maybe 1 or higher or 0 (means rolling till there are all tiles checked near player)
  rolls = 8*range*(range+1)/2 if rolls > 8*range*(range+1)/2 || rolls <= 0
  positions = []
  for j in 0..rolls-1 do
    if j == 0
      i = rand(range)
      r = rand((i+1)*8)
    else
      k = rand(positions.length)
      i,r = positions[k]
    end
    if r<=(i+1)*2
      new_x = x-i-1+r
      new_y = y-i-1
    elsif r<=(i+1)*6-2
      new_x = [x+i+1,x-i-1][r%2]
      new_y = y-i+((r-1-(i+1)*2)/2).floor
    else
      new_x = x-i+r-(i+1)*6
      new_y = y+i+1
    end
    return [new_x,new_y] if pbTileIsPossible(new_x,new_y)
    return if j >= rolls-1
    if j == 0
      for i2 in 0..range-1
        for r2 in 0..(i2+1)*8-1
          positions.push([i2,r2])
        end
      end
    end
    positions.delete([i,r])
    return if positions.length == 0
  end
  return
end


#===============================================================================
# new method pbTileIsPossible to check if tile is good to spawn
#===============================================================================
def pbTileIsPossible(x,y)
  if !$game_map.valid?(x,y) #check if the tile is on the map
    return false
  else
    tile_terrain_tag = $game_map.terrain_tag(x,y)
  end
  for event in $game_map.events.values
    if event.x==x && event.y==y
      return false
    end
  end
  return false if !tile_terrain_tag
  #check if it's a valid grass, water or cave etc. tile
  return false if tile_terrain_tag.ice
  return false if tile_terrain_tag.ledge
  return false if tile_terrain_tag.waterfall
  return false if tile_terrain_tag.waterfall_crest
  return false if tile_terrain_tag.id == :Rock
  if VisibleEncounterSettings::RESTRICT_ENCOUNTERS_TO_PLAYER_MOVEMENT
    return false if !tile_terrain_tag.can_surf && 
              $PokemonGlobal && $PokemonGlobal.surfing
    return false if tile_terrain_tag.can_surf && 
              !($PokemonGlobal && $PokemonGlobal.surfing)
  end
  if tile_terrain_tag.can_surf
    for i in [2, 1, 0]
      tile_id = $game_map.data[x, y, i]
      return false if !tile_id || tile_id < 0
      next if tile_id == 0
      terrain = GameData::TerrainTag.try_get($game_map.terrain_tags[tile_id])
      passage = $game_map.passages[tile_id]
      priority = $game_map.priorities[tile_id]
      break if terrain.can_surf
      # Ignore if tile above water
      return false if passage!=0
      return false if priority==0 && !terrain.ignore_passability
    end
  else
    return false if !$game_map.passableStrict?(x, y, 0)
  end
  
  return false if !$PokemonEncounters.encounter_possible_here_on_tile?(x,y)
  
  return true
end

#===============================================================================
# defining new method pbPlaceEncounter to add/place and visualise the pokemon
# "encounter" on the overworld-tile (x,y)
#===============================================================================
def pbPlaceEncounter(x,y,pokemon)
  # place event with random movement with overworld sprite
  # We define the event, which has the sprite of the pokemon and activates the wildBattle on touch
  if !$MapFactory
    $game_map.spawnPokeEvent(x,y,pokemon)
  else
    mapId = $game_map.map_id
    spawnMap = $MapFactory.getMap(mapId)
    spawnMap.spawnPokeEvent(x,y,pokemon)
  end
  pbPlayCryOnOverworld(pokemon.species, pokemon.form) # Play the pokemon cry of encounter
end

class Pokemon
  #===============================================================================
  # adding new variable aggressive in Class Pokemon. Every spawned, aggressive 
  # Pokemon, i.e. a Pokemon that follows you on the map has this variable set true
  #===============================================================================
  attr_accessor :aggressive

  #===============================================================================
  # adding new Method aggressive? in Class Pokemon
  #===============================================================================
  def aggressive?(encType)
    encType = GameData::EncounterType.try_get(encType)
    return self.aggressive if self.aggressive == true || self.aggressive == false
    if encType
      #aggressive Pokemon on water only when surfing, and on land when not surfing
      if (!$PokemonGlobal.surfing && encType.type == :water) || ($PokemonGlobal.surfing && encType.type != :water)
        self.aggressive = false 
        return false
      end
    end
    if rand(100) < VisibleEncounterSettings::AGGRESSIVE_ENCOUNTER_PROBABILITY
      self.aggressive = true
      return true
    end
  end
end

#===============================================================================
# adding new Method encounter_type_on_tile in Class PokemonEncounters
#===============================================================================
class PokemonEncounters  
  def encounter_type_on_tile(x,y)
    time = pbGetTimeNow
    ret = nil
    if $game_map.terrain_tag(x,y).can_surf_freely
      ret = find_valid_encounter_type_for_time(:Water, time)
    else   # Land/Cave (can have both in the same map)
      if has_land_encounters? && $game_map.terrain_tag(x, y).land_wild_encounters
        ret = :BugContest if pbInBugContest? && has_encounter_type?(:BugContest)
        ret = find_valid_encounter_type_for_time(:Land, time) if !ret
      end
      if !ret && has_cave_encounters?
        ret = find_valid_encounter_type_for_time(:Cave, time)
      end
    end
    return ret
  end
  
  #===============================================================================
  # adding new method encounter_possible_here_on_tile? in class PokemonEncounters
  # in file 003_Overworld_WildEncounters.rb to check at arbitrary coordinates x
  # and y and not only at players position such as encounter_possible_here? does
  #===============================================================================
  def encounter_possible_here_on_tile?(x,y)
    tile_terrain_tag = $game_map.terrain_tag(x,y)
    if tile_terrain_tag.can_surf_freely
      if VisibleEncounterSettings::NO_SPAWN_ON_BORDER
        return false if !$game_map.terrain_tag(x+1,y).can_surf_freely
        return false if !$game_map.terrain_tag(x-1,y).can_surf_freely
        return false if !$game_map.terrain_tag(x,y+1).can_surf_freely
        return false if !$game_map.terrain_tag(x,y-1).can_surf_freely
      end
      return true
    end
    return true if tile_terrain_tag.can_surf_freely
    return false if tile_terrain_tag.ice
    return true if has_cave_encounters?   # i.e. this map is a cave
    return true if has_land_encounters? && tile_terrain_tag.land_wild_encounters
    return false
  end

  #===============================================================================
  # adding new Method encounter_triggered_on_tile? to Class PokemonEncounters
  # to returns whether a overworld wild encounter should happen, based on its encounter
  # chance. Called when taking a step. Add-ons may overwrite this method.
  #===============================================================================
  def encounter_triggered_on_tile?(enc_type, repel_active = false, triggered_by_step = true)
    return $PokemonEncounters.encounter_triggered?(enc_type, repel_active, true)
  end

  #===============================================================================
  # adding new method have_double_wild_battle_on_tile? in class PokemonEncounters
  # Returns whether a wild encounter should be turned into a double wild encounter
  # similar to have_double_wild_battle but depends on tile.
  #===============================================================================
  def have_double_wild_battle_on_tile?(x, y, map_id)
    return false if $PokemonTemp.forceSingleBattle
    return false if pbInSafari?
    return true if $PokemonGlobal.partner
    return false if $Trainer.able_pokemon_count <= 1
    if $MapFactory
      terrainTag = $MapFactory.getTerrainTag(map_id,x,y)
    else
      terrainTag = $game_map.terrain_tag(x,y)
    end
    return true if terrainTag.double_wild_encounters && rand(100) < 30  
    return false
  end
end

#===============================================================================
# adding new Class Game_PokeEvent and a new method attr_accessor to this Class
# to store the corresponding Pokemon in the Game_Event
#===============================================================================
class Game_PokeEvent < Game_Event
  #attr_accessor :event
  attr_accessor :pokemon # contains the original pokemon of class Pokemon

  def initialize(map_id, event, map=nil)
    super(map_id, event, map)
  end
end

#===============================================================================
# new Method spawnPokeEvent in Class Game_Map in Script Game_Map
#===============================================================================
class Game_Map
  def spawnPokeEvent(x,y,pokemon)
    #--- generating a new event ---------------------------------------
    event = RPG::Event.new(x,y)
    #--- nessassary properties ----------------------------------------
    key_id = (@events.keys.max || -1) + 1
    event.id = key_id
    event.x = x
    event.y = y
    #--- Graphic of the event -----------------------------------------
    encounter = [pokemon.species,pokemon.level]
    form = pokemon.form
    gender = pokemon.gender
    shiny = pokemon.shiny?
    #event.pages[0].graphic.tile_id = 0
    graphic_form = (VisibleEncounterSettings::SPRITES[0] && form!=nil) ? form : 0
    graphic_gender = (VisibleEncounterSettings::SPRITES[1] && gender!=nil) ? gender : 0
    graphic_shiny = (VisibleEncounterSettings::SPRITES[2] && shiny!=nil) ? shiny : false
    fname = GameData::Species.ow_sprite_filename(encounter[0].to_s, graphic_form, graphic_gender, graphic_shiny)
    fname.gsub!("Graphics/Characters/","")
    event.pages[0].graphic.character_name = fname
    #--- movement of the event --------------------------------
    event.pages[0].move_speed = VisibleEncounterSettings::DEFAULT_MOVEMENT[0]
    event.pages[0].move_frequency = VisibleEncounterSettings::DEFAULT_MOVEMENT[1]
    event.pages[0].move_type = VisibleEncounterSettings::DEFAULT_MOVEMENT[2]
    event.pages[0].step_anime = true if VisibleEncounterSettings::USE_STEP_ANIMATION
    event.pages[0].trigger = 2
    event.pages[0].move_route.list[0].code = 10
    event.pages[0].move_route.list[1] = RPG::MoveCommand.new
    for move in VisibleEncounterSettings::ENC_MOVEMENTS do
      if pokemon.method(move[0]).call == move[1]
        event.pages[0].move_speed = move[2] if move[2]
        event.pages[0].move_frequency = move[3] if move[3]
        event.pages[0].move_type = move[4] if move[4]
      end
    end
    #--- event commands of the event -------------------------------------
    #  - add a method that stores temp data when PokeEvent is triggered, must include
    #    $PokemonGlobal.roamEncounter, $PokemonTemp.roamerIndex, $PokemonGlobal.nextBattleBGM, $PokemonTemp.forceSingleBattle, $PokemonTemp.encounterType
    Compiler::push_script(event.pages[0].list,sprintf(" pbStoreTempForBattle()"))
    #  - set data for roamer and encounterType, that is
    #    $PokemonGlobal.roamEncounter, $PokemonTemp.roamerIndex, $PokemonGlobal.nextBattleBGM, $PokemonTemp.forceSingleBattle, $PokemonTemp.encounterType
    if $PokemonGlobal.roamEncounter!=nil # i.e. $PokemonGlobal.roamEncounter = [i,species,poke[1],poke[4]]
      parameter1 = $PokemonGlobal.roamEncounter[0].to_s
      parameter2 = $PokemonGlobal.roamEncounter[1].to_s
      parameter3 = $PokemonGlobal.roamEncounter[2].to_s
      $PokemonGlobal.roamEncounter[3] != nil ? (parameter4 = '"'+$PokemonGlobal.roamEncounter[3].to_s+'"') : (parameter4 = "nil")
      parameter = " $PokemonGlobal.roamEncounter = ["+parameter1+",:"+parameter2+","+parameter3+","+parameter4+"] "
    else
      parameter = " $PokemonGlobal.roamEncounter = nil "
    end
    Compiler::push_script(event.pages[0].list,sprintf(parameter))
    parameter = ($PokemonTemp.roamerIndex!=nil) ? " $PokemonTemp.roamerIndex = "+$PokemonTemp.roamerIndex.to_s : " $PokemonTemp.roamerIndex = nil "
    Compiler::push_script(event.pages[0].list,sprintf(parameter))
    parameter = ($PokemonGlobal.nextBattleBGM!=nil) ? " $PokemonGlobal.nextBattleBGM = '"+$PokemonGlobal.nextBattleBGM.to_s+"'" : " $PokemonGlobal.nextBattleBGM = nil "
    Compiler::push_script(event.pages[0].list,sprintf(parameter))
    parameter = ($PokemonTemp.forceSingleBattle!=nil) ? " $PokemonTemp.forceSingleBattle = "+$PokemonTemp.forceSingleBattle.to_s : " $PokemonTemp.forceSingleBattle = nil "
    Compiler::push_script(event.pages[0].list,sprintf(parameter))
    parameter = ($PokemonTemp.encounterType!=nil) ? " $PokemonTemp.encounterType = :"+$PokemonTemp.encounterType.to_s : " $PokemonTemp.encounterType = nil "
    Compiler::push_script(event.pages[0].list,sprintf(parameter))
    #  - add a branch to check if player can battle water pokemon from ground
    Compiler::push_branch(event.pages[0].list,sprintf(" pbCheckBattleAllowed()"))
    #  - set $PokemonGlobal.battlingSpawnedPokemon = true
    Compiler::push_script(event.pages[0].list,sprintf(" $PokemonGlobal.battlingSpawnedPokemon = true",1))    
    #  - add method pbSingleOrDoubleWildBattle for the battle
    if !$MapFactory
      parameter = " pbSingleOrDoubleWildBattle( $game_map.events[#{key_id}].map.map_id, $game_map.events[#{key_id}].x, $game_map.events[#{key_id}].y, $game_map.events[#{key_id}].pokemon )"
    else
      mapId = $game_map.map_id
      parameter = " pbSingleOrDoubleWildBattle( $MapFactory.getMap("+mapId.to_s+").events[#{key_id}].map.map_id, $MapFactory.getMap("+mapId.to_s+").events[#{key_id}].x, $MapFactory.getMap("+mapId.to_s+").events[#{key_id}].y, $MapFactory.getMap("+mapId.to_s+").events[#{key_id}].pokemon )"
    end
    Compiler::push_script(event.pages[0].list,sprintf(parameter),1)
    #   - set $PokemonGlobal.battlingSpawnedPokemon = false
    Compiler::push_script(event.pages[0].list,sprintf(" $PokemonGlobal.battlingSpawnedPokemon = false"),1) 
    #  - add the end of branch
    Compiler::push_branch_end(event.pages[0].list,1)
    #  - add a method to reset temporary data to previous state, must include
    #    $PokemonGlobal.roamEncounter, $PokemonTemp.roamerIndex, $PokemonGlobal.nextBattleBGM, $PokemonTemp.forceSingleBattle, $PokemonTemp.encounterType
    Compiler::push_script(event.pages[0].list,sprintf(" pbResetTempAfterBattle()"))
    #  - add method to remove this PokeEvent from map
    if !$MapFactory
      parameter = "$game_map.removeThisEventfromMap(#{key_id})"
    else
      mapId = $game_map.map_id
      parameter = "$MapFactory.getMap("+mapId.to_s+").removeThisEventfromMap(#{key_id})"
    end
    Compiler::push_script(event.pages[0].list,sprintf(parameter),1)
    #  - finally push end command
    Compiler::push_end(event.pages[0].list)
    #--- creating and adding the Game_PokeEvent ------------------------------------
    gameEvent = Game_PokeEvent.new(@map_id, event, self)
    gameEvent.id = key_id
    gameEvent.moveto(x,y)
    gameEvent.pokemon = pokemon
    for step in VisibleEncounterSettings::ADD_STEPS_BEFORE_VANISH
      step_method = step[0]
      step_value = step[1]
      step_count = step[2]
      if pokemon.method(step_method).call == step_value
        gameEvent.remaining_steps += step_count
      end
    end
  
    @events[key_id] = gameEvent
    #--- updating the sprites --------------------------------------------------------
    sprite = Sprite_Character.new(Spriteset_Map.viewport,@events[key_id])
    $scene.spritesets[self.map_id]=Spriteset_Map.new(self) if $scene.spritesets[self.map_id]==nil
    $scene.spritesets[self.map_id].character_sprites.push(sprite)
    # alternatively: updating the sprites (old and slow but working):
    #$scene.disposeSpritesets
    #$scene.createSpritesets
  end
end

#-------------------------------------------------------------------------------
# New method for easily get the appropriate Pokemon Graphic (copied from Following Pokemon EX)
#-------------------------------------------------------------------------------
module GameData
  class Species
    def self.ow_sprite_filename(species, form = 0, gender = 0, shiny = false, shadow = false)
      ret = self.check_graphic_file("Graphics/Characters/", species, form, gender, shiny, shadow, "Followers")
      ret = "Graphics/Characters/Followers/000" if nil_or_empty?(ret)
	    return ret
    end
  end
end

class PokemonTemp
  attr_accessor :VOWERoamEncounter
  attr_accessor :VOWERoamerIndex
  attr_accessor :VOWENextBattleBGM
  attr_accessor :VOWEForceSingleBattle
  attr_accessor :VOWEEncounterType
end

#===============================================================================
# adding new Method pbStoreTempForBattle to store temporary data before battling
# overworld pokemon
#===============================================================================
def pbStoreTempForBattle()
  $PokemonTemp.VOWERoamEncounter = $PokemonGlobal.roamEncounter
  $PokemonTemp.VOWERoamerIndex = $PokemonTemp.roamerIndex
  $PokemonTemp.VOWENextBattleBGM = $PokemonGlobal.nextBattleBGM 
  $PokemonTemp.VOWEForceSingleBattle = $PokemonTemp.forceSingleBattle
  $PokemonTemp.VOWEEncounterType = $PokemonTemp.encounterType
end

#===============================================================================
# adding new Method to reset temporary data after battling overworld back to before
#===============================================================================
def pbResetTempAfterBattle()
  $PokemonGlobal.roamEncounter = $PokemonTemp.VOWERoamEncounter
  $PokemonTemp.roamerIndex = $PokemonTemp.VOWERoamerIndex
  $PokemonGlobal.nextBattleBGM = $PokemonTemp.VOWENextBattleBGM 
  $PokemonTemp.forceSingleBattle = $PokemonTemp.VOWEForceSingleBattle
  $PokemonTemp.encounterType = $PokemonTemp.VOWEEncounterType
end

#===============================================================================
# adding new Method pbCheckBattleAllowed to check if battling water pokemon from ground are allowed
#===============================================================================
def pbCheckBattleAllowed()
  encType = GameData::EncounterType.try_get($PokemonTemp.encounterType)
  #the pokemon encounter battle won't happen if it is in the water and the player is not surfing
  return false if !$PokemonGlobal.surfing && encType.type == :water && !VisibleEncounterSettings::BATTLE_WATER_FROM_GROUND
  return true
end

#===============================================================================
# adding new Method pbSingleOrDoubleWildBattle to reduce the code in spawnPokeEvent
#===============================================================================
def pbSingleOrDoubleWildBattle(map_id,x,y,pokemon)
  if $PokemonEncounters.have_double_wild_battle_on_tile?(x,y,map_id)
      encounter2 = $PokemonEncounters.choose_wild_pokemon($PokemonTemp.encounterType)
      encounter2 = EncounterModifier.trigger(encounter2)
      setBattleRule("double")
      decision = pbWildBattleCore(pokemon, encounter2)
  else
    species = pokemon.species
    level = pokemon.level
    # Potentially call a different pbWildBattle-type method instead (for roaming
    # Pokémon, Safari battles, Bug Contest battles)
    handled = [nil]
    Events.onWildBattleOverride.trigger(nil,species,level,handled)
    return handled[0] if handled[0]!=nil
    decision = pbWildBattleCore(pokemon) # Perform the battle
    Events.onWildBattleEnd.trigger(nil,species,level,decision) # Used by the Poké Radar to update/break the chain
  end
  return (decision!=2 && decision!=5) # Return false if the player lost or drew the battle, and true if any other result
end

#===============================================================================
# adding new method pbPlayCryOnOverworld to load/play Pokémon cry files 
# SPECIAL THANKS TO "Ambient Pokémon Cries" - by Vendily
# actually it's not used, but that code helped to include the pkmn cries faster
#===============================================================================
def pbPlayCryOnOverworld(pokemon,form=0,volume=30,pitch=100) # default volume=90
  return if !pokemon || pitch <= 0
  form = 0 if form==nil
  if pokemon.is_a?(Pokemon)
    if !pokemon.egg?
      GameData::Species.play_cry_from_pokemon(pokemon,volume,pitch)
    end
  else
    GameData::Species.play_cry_from_species(pokemon,form,volume,pitch)
  end
end

#===============================================================================
# adding a new method attr_reader to the Class Spriteset_Map in Script
# Spriteset_Map to get access to the variable @character_sprites of a
# Spriteset_Map
#===============================================================================
class Spriteset_Map
  attr_reader :character_sprites
end

#===============================================================================
# adding a new method attr_reader to the Class Scene_Map in Script
# Scene_Map to get access to the Spriteset_Maps listed in the variable 
# @spritesets of a Scene_Map
#===============================================================================
class Scene_Map
  attr_reader :spritesets
end


          #########################################################
          #                                                       #
          #   2. PART: VANISH OVERWORLD ENCOUNTER AFTER BATTLE    #
          #                                                       #
          #########################################################

#-------------------------------------------------------------------
# adding new Method removeThisEventfromMap in Class Game_Map 
# to let an overworld pokemon disappear after battling
#-------------------------------------------------------------------
class Game_Map
  def removeThisEventfromMap(id)
    if @events.has_key?(id)
      if defined?($scene.spritesets)
        for sprite in $scene.spritesets[@map_id].character_sprites
          if sprite.character == @events[id]
            $scene.spritesets[@map_id].character_sprites.delete(sprite)
            sprite.dispose
            break
          end
        end
      end
      @events.delete(id)
    end
  end
end

#===============================================================================
# adding a new variable remaining_steps and replacing the method increase_steps
# in class Game_PokeEvent to count the remaining steps of the PokeEvent of the 
# overworld encounter before vanishing from map and to make them disappear after
# remaining_steps became <= 0 
#===============================================================================
class Game_PokeEvent < Game_Event
  attr_accessor :remaining_steps #counts the remaining steps of an overworld encounter before vanishing 
  
  alias o_initialize initialize
  def initialize(map_id, event, map=nil)
    o_initialize(map_id, event, map)
    @remaining_steps  = VisibleEncounterSettings::DEFAULT_STEPS_BEFORE_VANISH
  end
  
  alias original_increase_steps increase_steps
  def increase_steps
    if @remaining_steps <= 0 # && self.name=="vanishingEncounter"
      removeThisEventfromMap
    else
      @remaining_steps-=1
      original_increase_steps
    end
  end
  
  def removeThisEventfromMap
    if $game_map.events.has_key?(@id) and $game_map.events[@id]==self
      if defined?($scene.spritesets)
        for sprite in $scene.spritesets[$game_map.map_id].character_sprites
          if sprite.character==self
            $scene.spritesets[$game_map.map_id].character_sprites.delete(sprite)
            sprite.dispose
            break
          end
        end
      end
      $game_map.events.delete(@id)
    else
      if $MapFactory
        for map in $MapFactory.maps
          if map.events.has_key?(@id) and map.events[@id]==self
            if defined?($scene.spritesets) && $scene.spritesets[self.map_id] && $scene.spritesets[self.map_id].character_sprites
              for sprite in $scene.spritesets[self.map_id].character_sprites
                if sprite.character==self
                  $scene.spritesets[map.map_id].character_sprites.delete(sprite)
                  sprite.dispose
                  break
                end
              end
            end
            map.events.delete(@id)
            break
          end
        end
      else
        raise ArgumentError.new(_INTL("Actually, this should not be possible"))
      end
    end
  end
end


          #########################################################
          #                                                       #
          #             3. PART: ADDITIONAL FEATURES              #
          #                                                       #
          #########################################################

#===============================================================================
# Adding Event OnWildPokemonCreateForSpawning to Module Events in Script PField_Field.
# This Event is triggered  when a new pokemon spawns. Use this Event instead of OnWildPokemonCreate
# if you want to add a new procedure that modifies a pokemon on spawning 
# but not on creation while going into battle with an already spawned pokemon.
#Note that OnPokemonCreate is also triggered when a pokemon is created for spawning,
#But OnPokemonCreateForSpawning is not triggered when a pokemon is created in other situations than for spawning
#===============================================================================
module Events
  @@OnWildPokemonCreateForSpawning          = Event.new
  # Triggers whenever a wild Pokémon is created for spawning
  # Parameters: 
  # e[0] - Pokémon being created for spawning
  def self.onWildPokemonCreateForSpawning; @@OnWildPokemonCreateForSpawning; end
  def self.onWildPokemonCreateForSpawning=(v); @@OnWildPokemonCreateForSpawning = v; end  
end

#-------------------------------------------------------------------------------
# adding a process to the EncounterModifier TriggerEncounterEnd For roaming
# encounters. We have to set roamed_already to true after one roamer spawned.
# Possible PROBLEM: EncounterEnd has already registered the process that sets
#    $PokemonTemp.roamerIndex = nil
# Thus we define a specific TriggerEncounterEndSpawn for spawned encounters. 
#-------------------------------------------------------------------------------
module EncounterModifier
  @@procsEndSpawn = []

  def self.registerEncounterEndSpawn(p)
    @@procsEndSpawn.push(p)
  end
    
  def self.triggerEncounterEndSpawn()
    for prc in @@procsEndSpawn
      prc.call()
    end
  end
end

#===============================================================================
# adds new parameter battlingSpawnedPokemon to the class PokemonGlobalMetadata.
# Also overrides initialize include that parameter there.
#===============================================================================
class PokemonGlobalMetadata
  attr_accessor :creatingSpawningPokemon
  attr_accessor :battlingSpawnedPokemon

  alias original_initialize initialize
  def initialize
    creatingSpawningPokemon = false
    battlingSpawnedPokemon = false
    original_initialize
  end
end


          #########################################################
          #                                                       #
          #            4. PART: ROAMING POKEMON                   #
          #                                                       #
          #########################################################
#===============================================================================
# This part is about roaming pokemon
#
# By default roaming pokemon can encounter as overworld and as normal encounters
#===============================================================================

#-------------------------------------------------------------------------------
# Overwriting pbRoamingMethodAllowed such that the encounter_type is not computed
# by the position of the player but of the chosen tile near the player
# Returns whether the given category of encounter contains the actual encounter
# method that will not occur in the player's current position.
#-------------------------------------------------------------------------------
def pbRoamingMethodAllowed(roamer_method)
  enc_type = $PokemonTemp.encounterType # $PokemonTemp.encounterType stores the encounter type of the chosen tile
  type = GameData::EncounterType.get(enc_type).type
  case roamer_method
  when 0   # Any step-triggered method (except Bug Contest)
    return [:land, :cave, :water].include?(type)
  when 1   # Walking (except Bug Contest)
    return [:land, :cave].include?(type)
  when 2   # Surfing
    return type == :water
  when 3   # Fishing
    return type == :fishing
  when 4   # Water-based
    return [:water, :fishing].include?(type)
  end
  return false
end

#-------------------------------------------------------------------------------
# adding this process to the Event onWildPokemonCreateForSpawning to for roaming
# pokemon
#-------------------------------------------------------------------------------
Events.onWildPokemonCreateForSpawning += proc { |_sender,_e|
  pokemon = _e[0]
  next if !$PokemonGlobal.roamEncounter || $PokemonTemp.roamerIndex.nil?
  # Get the roaming Pokémon to encounter; generate it based on the species and
  # level if it doesn't already exist
  idxRoamer = $PokemonTemp.roamerIndex
  if !$PokemonGlobal.roamPokemon[idxRoamer] ||
     !$PokemonGlobal.roamPokemon[idxRoamer].is_a?(Pokemon)
    $PokemonGlobal.roamPokemon[idxRoamer] = pokemon
  end
}

#-------------------------------------------------------------------------------
# adding a process to the EncounterModifier TriggerEncounterEnd For roaming
# encounters. We have to set roamed_already to true after one roamer spawned.
# Possible PROBLEM: EncounterEnd has already registered the process that sets
#    $PokemonTemp.roamerIndex = nil
# Thus we define a specific TriggerEncounterEndSpawn for spawned encounters. 
#-------------------------------------------------------------------------------
EncounterModifier.registerEncounterEndSpawn(proc {
  if $PokemonTemp.roamerIndex != nil &&  $PokemonGlobal.roamEncounter != nil
   $PokemonGlobal.roamEncounter = nil
   $PokemonGlobal.roamedAlready = true
  end
})
  
