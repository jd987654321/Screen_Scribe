--potential bug, mainScreen() may not return the entire height or width depending on the os and monitor
--[[bug with screen dimensions and resolution, it only uses one, we can fix this by
refreshing the screen dimensions each time we use the command
]]

local thisScreen
local screenName
local wholeScreen
local canvas

local function updateCanvasSettings()
	thisScreen = hs.screen.mainScreen()
	screenName = thisScreen:name()
	wholeScreen = thisScreen:frame()
	canvas = hs.canvas.new({x = 0, y = 0, w = 5000, h = 5000})

	canvas[1] = {
		type = "rectangle",
		frame = {x = 0, y = 0, w = 0, h = 0},
		fillColor = {red = 1, green = 1 , blue = 1, alpha = 0.5},
		strokeColor = {red = 1, green = 1, blue = 1, alpha = 1},
		strokeWidth = 3
	}
end

updateCanvasSettings()

-- local test = hs.canvas.new({x = 0, y = 0, w = 5000, h = 5000})
-- test[1] = {
-- 	type = "rectangle",
-- 	frame = {x = 0, y = 0, w = 5000, h = 5000},
-- 	fillColor = {red = 1, green = 1 , blue = 1, alpha = 0.2},
-- 	strokeColor = {red = 1, green = 1, blue = 1, alpha = 1},
-- 	strokeWidth = 3
-- }
-- test:show()

-- local handle = io.popen("system_profiler SPDisplaysDataType | grep Resolution")
-- local result = handle:read("*a")
-- local width, height = result:match("(%d+) x (%d+)")

-- handle:close()

--hs.alert.show("width: "  .. width .. " height: " .. height)
--hs.alert.show(result)






local function getTextFromImg(pathToImg)
	local terminalPathToImg = string.gsub(pathToImg, ";", "\\;")
	hs.alert.show("point")
	local status, code, signal = os.execute("/opt/homebrew/bin/tesseract " .. terminalPathToImg .. " ./screen_scribe/imageText -l eng")
	local textFile = io.open("./screen_scribe/imageText.txt", "r")
	local textFromFile = textFile:read("*a")
	hs.pasteboard.writeObjects(textFromFile)
end

local function screenshot(rect)
	local folderPath = os.getenv("HOME") .. "/.hammerspoon/Screen_Scribe/hs_images/"
	local time = os.date("%H;%M;%S")
	local date = os.date("%d;%m;%Y")
	local dateAndTime = date .. "_" .. time
	local imageName = "ss_" .. dateAndTime .. ".png"
	local imagePath = folderPath .. imageName .. ""
	hs.alert.show(imagePath)
	hs.screen.mainScreen():shotAsPNG(imagePath, rect)
	getTextFromImg(imagePath)
end



hs.hotkey.bind({"cmd", "shift"}, "2", 
	function()
		--startSnapscribe = true
		hs.alert.show("lets snap")
		MyEventTap:start()
	end
)

hs.hotkey.bind({"cmd", "shift"} , "1", 
	function()
		--clearPasteboard()
		hs.alert.show("stopping")
		MyEventTap:stop()
	end
)
--local types = hs.eventtap.event:types()

--starting rectangle
--specific command starts entire thing
--[[setup for rectangle
	draw entire screen as canvas, draw rectangle, hide canvas
	]]
--left click moves rectangle there, drag to cover a certain area
--left click let go ends drawing, save rectangle coordinates as rect and then use that as ss

--[[moving on, ss will then be used in python script to run ai model on it, model will spit results
	]]
local types = hs.eventtap.event.types

local function resetRect(rect)
	rect.x = 0
	rect.y = 0
	rect.w = 0
	rect.h = 0
end


local initialX
local initialY

MyEventTap = hs.eventtap.new({
	types.leftMouseDown,
	types.leftMouseDragged,
	types.leftMouseUp
	}, 
	function(event)
		-- if not startSnapscribe then
		-- 	return false
		-- end

		

		local type = event:getType()
		local cursor = event:location()
		local rect = canvas[1].frame
		local theScreen = hs.screen.mainScreen():frame()
		local Cx = cursor.x
		local Cy = cursor.y

		--Cx and Cy being cursor coordinates, 
		if type == types.leftMouseDown or type == types.leftMouseDragged then

			canvas:show()
			if type == types.leftMouseDown then

				hs.alert.show(screenName)
				hs.alert.show(hs.screen.mainScreen():name())

				if screenName ~= hs.screen.mainScreen():name() then
					updateCanvasSettings()
				end
				

				--hs.alert.show("screen name: " .. thisScreen)
				initialX = cursor.x
				initialY = cursor.y

				rect.x = initialX
				rect.y = initialY
			end

			if Cx >= initialX and Cy >= initialY then
				rect.x = initialX
				rect.y = initialY
				rect.w = Cx - initialX
				rect.h = Cy - initialY
			elseif Cx >= initialX and Cy < initialY then
				rect.x = initialX
				rect.y = Cy
				rect.w = Cx - initialX
				rect.h = initialY - Cy
			elseif Cx < initialX and Cy < initialY then
				rect.x = Cx
				rect.y = Cy
				rect.w = initialX - Cx
				rect.h = initialY - Cy
			elseif Cx < initialX and Cy >= initialY then
				rect.x = Cx
				rect.y = initialY
				rect.w = initialX - Cx
				rect.h = Cy - initialY
			end
			return true

		--elseif type == types.leftMouseUp then
		else
			canvas:hide()
			local table = canvas:elementBounds(1)
			--hs.alert.show("x: " .. table.x .. " y: " .. table.y .. " w: " .. table.w .. " h: " .. table.h)
			
			if not (table.x == 0 and table.y == 0 and table.w == 0 and table.h == 0) then
				hs.timer.doAfter(0.05 , 
					function()
						screenshot(table)
					end
				)
			end
			resetRect(rect)
			--startSnapscribe = false
			MyEventTap:stop()
		end
	end
)

--canvas:show()

-- canvas[2] = {
-- 	type = "rectangle",
-- 	frame = {x = 0, y = 0, w = 100, h = 100},
-- 	fillColor = {red = 1, green = 1 , blue = 1, alpha = 1},
-- 	strokeColor = {red = 1, green = 1, blue = 1, alpha = 1},
-- 	strokeWidth = 3
-- }





