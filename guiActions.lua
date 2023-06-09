require "utils"

function setPermissionsOnTeamJoin(player)
	if settings.global["tournament-mode"].value == true then
		player.gui.top["ready"].visible = true
		player.gui.top["biter-wars"].visible = false
        if not global["gameStarted"] then
			player.gui.top["ready"].visible = true
			game.permissions.get_group("Default").remove_player(player)
			game.permissions.get_group("Players").add_player(player)
		end
    end
end

function joinNorth(player)
	player.force="north"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,-740}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	setPermissionsOnTeamJoin(player)
end

function joinSouth(player)
	player.force="south"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0, 760}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	setPermissionsOnTeamJoin(player)
end

function spectate(player)
	player.force="spectators"
	pos = game.surfaces[global["surfaceName"]].find_non_colliding_position("character", {0,0}, 5, 0.1)
	player.teleport(pos, global["surfaceName"])
	player.gui.top["biter-wars"].visible = true
	game.permissions.get_group("Players").remove_player(player)
	game.permissions.get_group("Default").add_player(player)
end

function startGame()
	game.forces["north"].technologies["automation"].researched = true
	game.forces["north"].technologies["logistics"].researched = true
	game.forces["north"].technologies["rocket-silo"].researched = true
	game.forces["south"].technologies["automation"].researched = true
	game.forces["south"].technologies["logistics"].researched = true
	game.forces["south"].technologies["rocket-silo"].researched = true
	global["gameStarted"] = true
	global["gameStartedTick"] = game.tick
	convertBlueprints(-750, "north", global["northPackchest"])
	convertBlueprints(750, "south", global["southPackchest"])
	if settings.global["tournament-mode"].value == true then
		game.permissions.get_group("Players").set_allows_action(defines.input_action.open_blueprint_library_gui, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.import_blueprint_string, false)
		game.permissions.get_group("Players").set_allows_action(defines.input_action.start_walking, true)
		clearAllGhosts()
		removeAllBluprints()
		clearQuickBars()
		for i, player in pairs(game.connected_players) do
			if player.force ~= "spectators" then
				player.gui.top["biter-wars"].visible = false
				player.gui.top["ready"].visible = false
			else 
				player.gui.top["biter-wars"].visible = true
			end
		end
    end
end

function startingSequence()
	global["countdown"] = 10
end

function teamReady(player, setReady)
	if player.force.name == "north" then
		global["northSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "north" then
				player.gui.top["ready"]["buttonflow2"]["biter-wars-ready"].state = setReady
			end
		end
	else
		global["southSideReady"] = setReady
		for i, player in pairs(game.connected_players) do
			if player.force.name == "south" then
				player.gui.top["ready"]["buttonflow2"]["biter-wars-ready"].state = setReady
			end
		end
	end
	if global["southSideReady"] and global["northSideReady"] then
		startingSequence()
	end
end


