require "mapGen"
require "guiActions"

function createGui(player)
	if player.gui.top["biter-wars"] then
		return 
	end
	local frame = player.gui.top.add{
		type = "frame", name = "biter-wars", caption = {"biter-wars.frame-heading"}, direction = "vertical", style = "biter-wars_frame"}
	frame.style.width = 250
	
	local buttoncontainer = frame.add{ type = "flow", name = "buttonflow", direction = "vertical"}
	
	buttoncontainer.add{ type = "button", name = "biter-wars-regenerate-map", style = "rounded_button", caption = {"biter-wars.regenerate-map"} }
	buttoncontainer.style.minimal_width = 100
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-wars-join-north", style = "rounded_button", caption = {"biter-wars.join-north"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-wars-join-south", style = "rounded_button", caption = {"biter-wars.join-south"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-wars-spectate", style = "rounded_button", caption = {"biter-wars.spectate"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	buttoncontainer.add{ type = "button", name = "biter-wars-start-game", style = "rounded_button", caption = {"biter-wars.start-game"} }
	buttoncontainer.style.minimal_width = 50
	buttoncontainer.style.horizontally_stretchable = true
	
	local frame2 = player.gui.top.add{
		type = "frame", name = "ready", caption = {"ready.frame-heading"}, direction = "vertical", style = "biter-wars_frame"}
	frame.style.width = 250
	
	local buttoncontainer2 = frame2.add{ type = "flow", name = "buttonflow2", direction = "vertical"}
	
	buttoncontainer2.add{ type = "checkbox", name = "biter-wars-ready", caption = {"biter-wars.ready"}, state = false }
	buttoncontainer2.style.minimal_width = 100
	buttoncontainer2.style.horizontally_stretchable = true
	
	player.gui.top["ready"].visible = false
	
	buttoncontainer2.add{ type = "button", name = "biter-wars-exit-team", style = "rounded_button", caption = {"biter-wars.exit-team"} }
	buttoncontainer2.style.minimal_width = 100
	buttoncontainer2.style.horizontally_stretchable = true
	
	player.gui.top["ready"].visible = false
	
end

function onGuiClick(event)
	if event.element and event.element.valid then
		local element = event.element
        if element.name == "biter-wars-regenerate-map" then
            reGenerateMap()
            return
        end
        if not global["mapToBeCloned2"] then
	        if element.name == "biter-wars-join-north" then
	            joinNorth(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-wars-join-south" then
	            joinSouth(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-wars-spectate" then
	            spectate(game.players[event.element.player_index])
	            return
	        end
	        if element.name == "biter-wars-start-game" then
	            startGame()
	            return
	        end
	        if element.name == "biter-wars-exit-team" then
	        	player = game.players[event.element.player_index]
	        	player.gui.top["ready"].visible = false
	        	player.gui.top["ready"]["buttonflow2"]["biter-wars-ready"].state = false
	            spectate(player)
	            return
	        end
	    end
	end
end

function onGuiCheckedStateChanged(event)
	if event.element and event.element.valid then
		local element = event.element
		if element.name == "biter-wars-ready" then
			local setReady = false
			if element.state then
				game.print("ready = true")
			else
				game.print("ready = false")
			end
			if element.state == true then
				setReady = true
			end
			teamReady(game.players[event.element.player_index], setReady)
        	return
        end
	end
end