--[[
Server Module

Tasks:
- Coordinating the robots (on a separate thread)
- Receiving requests from remote terminals (on the main thread)
- Sending items when minecarts are ready

Structure of a robot order:

type: GET|INSERT|CHECK
item: <item_ID>
quantity: <quantity>
cachePosition: NULL|<position>
flags: {
	isInCache: 1|0
	requiresMultipleRobots: 1|0
}

Storage structure:

Storage
	|
	|- Storage Blocks (x 53) [BlockID]
			|
			|- Storage Crates (x 10) [CrateID]
			
Crates are numbered as follows:

-----------
|0|1|2|3|4|
|9|8|7|6|5|
-----------

Facing towards the main corridor

Currently using the following ports:
- 41926 for listening to item queries
- 41927 for broadcasting messages
- 41928 for listening to handshakes
--]]

local data = require("data")
local modem = require("modem")

numberOfBlocks = 53

--Ports

listenQueryPort = 41926
broadcastMsgPort = 41927
listenMsgPort = 41928

function getPosition(itemName)
	-- Gets the blockID that contains the item
	hash = data.md5(itemName)
	return hash%numberOfBlocks

function handshake(message, numberOfRobots)
	-- Broadcasts a request message to every robot. Accepts handshakes for a set numberOfRobots
	open(broadcastMsgPort)
	open(listenMsgPort)
	setStrength(100)
	

	

