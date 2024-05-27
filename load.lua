--[[
#
Main Developer: qwertyui#4134
Developer: hax#2530
#
]]--
local identity = 1
local c_closures = {
	assert,
	error,
	ipairs,
	loadstring,
	loadstring,
	next,
	pairs,
	pcall,
	print,
	rawequal,
	rawget,
	rawlen,
	rawset,
	select,
	setmetatable,
	tonumber,
	tostring,
	type,
	unpack,
	xpcall,
	typeof
}

local man_made_closures = {

}
local files = {}
local crypt = {}
local UserInputService = game:GetService("UserInputService")
UserInputService.WindowFocused:Connect(function()
	isgameactive = true
end)

UserInputService.WindowFocusReleased:Connect(function()
	isgameactive = false
end)

local function printidentity()
    print('Current identity is ' .. identity)
end

local function identifyexecutor()
    return executor_name, executor_ver
end

local function getexecutorname()
    return executor_name, executor_ver
end

local function setthreadidentity(cidentity)
    if cidentity <= 8 then
        identity = cidentity
    else
        warn("[ERROR]: :" .. identifyexecutor() .. ": Unexpected Thread Identity")
    end
end

local function getthreadidentity()
    return identity
end

local function gethui()
    return game:GetService("CoreGui")
end

local function base64encode(data)
    local letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return letters:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local function base64decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if x == '=' then return '' end
        local r, f = '', (b:find(x) - 1)
        for i = 6, 1, -1 do
            r = r .. (f % 2^i - f % 2^(i - 1) > 0 and '1' or '0')
        end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if #x ~= 8 then return '' end
        local c = 0
        for i = 1, 8 do
            c = c + (x:sub(i, i) == '1' and 2^(8 - i) or 0)
        end
        return string.char(c)
    end))
end

function crypt.generatebytes(size)
    if type(size) ~= 'number' then
        warn("missing argument #1 to 'generatebytes' (number expected)")
    end
    return crypt.generatekey(size)
end

function crypt.generatekey(optionalSize)
    local key = ""
    local a = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    for i = 1, (optionalSize or 32) do
        local n = math.random(1, #a)
        key = key .. a:sub(n, n)
    end
    return base64encode(key)
end

local function isrbxactive()
    return isgameactive
end

local files = {
	Name = "_LocalFileSystem",
	Classes = {"Clipboard","Local Files"}
}

_G[files.Name] = {}
for i,v in pairs(files.Classes) do
	_G[files.Name][v] = {}
end

local function setclipboard(content)
	_G[files.Name][files.Classes[1]][#_G[files.Name][files.Classes[1]]+1] = content
end

local function clearclipboard(idx)
	if idx then
		_G[files.Name][files.Classes[1]][idx] = nil
	else
		_G[files.Name][files.Classes[1]] = {}
	end
end

local function isgameactive()
    return isgameactive
end

local function setvirtualclipboard(text)
	table.insert(virtual_clipboard, text)
end

local function protect_gui(gui)
    names[gui] = {name=gui.Name,parent=gui.Parent}
    if getgenv().gethui() == game:GetService("Players").LocalPlayer.PlayerGui then
        gui.Name = "Chat"
    else
       gui.Name = "RobloxGui"
    end
    gui.Parent = getgenv().gethui()
end

local function unprotect_gui(gui)
    if names[gui] then
        gui.Name = names[gui].name gui.Parent = names[gui].parent
    end
end

local function secure_call(func)
    return pcall(func)
end 

local function isexecutorclosure(input)
	if find(c_closures, input) then
		return false
	end
	for _, item in pairs(env) do
		if input == item then return true end
		if typeof(item) == "table" and item == env.Drawing or item == env.crypt then
			for _, table_item in pairs(item) do
				if input == table_item then return true end
			end
		end
	end
	for _, man_made in pairs(man_made_closures) do
		if man_made == coroutine.wrap(input) or input then
			return true
		end
	end
	return false
end

local function checkclosure(input)
	if find(c_closures, input) then
		return false
	end
	for _, item in pairs(env) do
		if input == item then return true end
		if typeof(item) == "table" and item == env.Drawing or item == env.crypt then
			for _, table_item in pairs(item) do
				if input == table_item then return true end
			end
		end
	end
	for _, man_made in pairs(man_made_closures) do
		if man_made == coroutine.wrap(input) or input then
			return true
		end
	end
	return false
end

local function cloneref(...)
	local objs = table.pack(...)
	local res = {}
	for i,v in pairs(objs) do
		res[#res+1] = clone(v)
	end
	return unpack(res)
end

local function find(haystack, item)
	return (table.find(haystack, item) or haystack[item]) ~= nil
end

local function setclipboard(content)
	_G[files.Name][files.Classes[1]][#_G[files.Name][files.Classes[1]]+1] = content
end

local function toclipboard(content)
	_G[files.Name][files.Classes[1]][#_G[files.Name][files.Classes[1]]+1] = content
end

local function clearclipboard(idx)
	if idx then
		_G[files.Name][files.Classes[1]][idx] = nil
	else
		_G[files.Name][files.Classes[1]] = {}
	end
end

local function isourclosure(input)
	if find(c_closures, input) then
		return false
	end
	for _, item in pairs(env) do
		if input == item then return true end
		if typeof(item) == "table" and item == env.Drawing or item == env.crypt then
			for _, table_item in pairs(item) do
				if input == table_item then return true end
			end
		end
	end
	for _, man_made in pairs(man_made_closures) do
		if man_made == coroutine.wrap(input) or input then
			return true
		end
	end
	return false
end

local function getrunningscripts()
	local all_scripts = {}
	for _, item in pairs(game:GetDescendants()) do
		if item:IsA("ModuleScript") then 
			table.insert(all_scripts, item)
		end
		if item:IsA("LocalScript") then
			if item.Enabled then
				table.insert(all_scripts, item)
			end
		end
	end
	return all_scripts
end

local function setfpscap(fps)
    return true
end

local function isscriptable(object, property)
	if not object then
		return nil
	end
	local success, value = pcall(function()
		return object[property]
	end)
	if success then
		if value ~= nil then
			return true
		else
			return false
		end
	else
		return false
	end
end

local function getallinstances()
	local instances = {}
	for _, obj in pairs(game:GetDescendants()) do
		if obj:IsA("Instance") then
			table.insert(instances, obj)
		end
	end
	return instances
end

function iscclosure(func)
	if find(man_made_closures, func) then
		return true
	end
	if find(c_closures, func) then
		return true
	end
	if typeof(func) == "function" then
		return false
	else
		return false
	end
end

function islclosure(func)
	if typeof(func) == "function" then
		if find(c_closures, func) then
			return false
		end
		if find(man_made_closures, func) then
			return true
		end
		return true 
	else
		return false
	end
end

local function newcclosure(func)
	if typeof(func) == "function" then
		local itm = coroutine.wrap(func)
		table.insert(man_made_closures, itm)
		return itm
	else
		return nil
	end
end

local function steprender(times)
	for i = 1, tonumber(times) or 1 do
		game["Run Service"].RenderStepped:Wait()
	end
end

local function getloadedmodules(filler_arg)
	local modules = {}

	for _, item in pairs(game:GetDescendants()) do
		if item:IsA("ModuleScript") then 
			table.insert(modules, item)
		end
	end

	return modules
end

local function getscripts()
	local all_scripts = get_all_modules(nil)

	for _, item in pairs(game:GetDescendants()) do
		if item:IsA("LocalScript") then
			table.insert(all_scripts, item)
		end
	end

	return all_scripts
end

local function str2hexa(a)
    return (string.gsub(a, ".", function(b)
        return string.format("%02x", string.byte(b))
    end))
end

local function num2s(c, d)
    local a = ""
    for e = 1, d do
        local f = c % 256
        a = string.char(f) .. a
        c = (c - f) / 256
    end
    return a
end

local function s232num(a, e)
    local d = 0
    for g = e, e + 3 do
        d = d * 256 + string.byte(a, g)
    end
    return d
end

local function preproc(h, i)
    local j = 64 - (i + 9) % 64
    i = num2s(8 * i, 8)
    h = h .. "\128" .. string.rep("\0", j) .. i
    assert(#h % 64 == 0)
    return h
end

local function k(h, e, l)
    local m = {}
    local n = {
        0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,
        0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
        0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,
        0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
        0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,
        0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
        0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,
        0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
        0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,
        0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
        0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,
        0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
        0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,
        0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
        0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,
        0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
    }
    for g = 1, 16 do
        m[g] = s232num(h, e + (g - 1) * 4)
    end
    for g = 17, 64 do
        local o = m[g - 15]
        local p = bit.bxor(bit.rrotate(o, 7), bit.rrotate(o, 18), bit.rshift(o, 3))
        o = m[g - 2]
        local q = bit.bxor(bit.rrotate(o, 17), bit.rrotate(o, 19), bit.rshift(o, 10))
        m[g] = (m[g - 16] + p + m[g - 7] + q) % 2 ^ 32
    end
    local r, s, b, t, u, v, w, x = l[1], l[2], l[3], l[4], l[5], l[6], l[7], l[8]
    for e = 1, 64 do
        local p = bit.bxor(bit.rrotate(r, 2), bit.rrotate(r, 13), bit.rrotate(r, 22))
        local y = bit.bxor(bit.band(r, s), bit.band(r, b), bit.band(s, b))
        local z = (p + y) % 2 ^ 32
        local q = bit.bxor(bit.rrotate(u, 6), bit.rrotate(u, 11), bit.rrotate(u, 25))
        local A = bit.bxor(bit.band(u, v), bit.band(bit.bnot(u), w))
        local B = (x + q + A + n[e] + m[e]) % 2 ^ 32
        x = w
        w = v
        v = u
        u = (t + B) % 2 ^ 32
        t = b
        b = s
        s = r
        r = (B + z) % 2 ^ 32
    end
    l[1] = (l[1] + r) % 2 ^ 32
    l[2] = (l[2] + s) % 2 ^ 32
    l[3] = (l[3] + b) % 2 ^ 32
    l[4] = (l[4] + t) % 2 ^ 32
    l[5] = (l[5] + u) % 2 ^ 32
    l[6] = (l[6] + v) % 2 ^ 32
    l[7] = (l[7] + w) % 2 ^ 32
    l[8] = (l[8] + x) % 2 ^ 32
end

local function crypt_hash(h)
    h = preproc(h, #h)
    local l = {0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19}
    for e = 1, #h, 64 do
        k(h, e, l)
    end
    return str2hexa(
        num2s(l[1], 4) ..
        num2s(l[2], 4) ..
        num2s(l[3], 4) ..
        num2s(l[4], 4) ..
        num2s(l[5], 4) ..
        num2s(l[6], 4) ..
        num2s(l[7], 4) ..
        num2s(l[8], 4)
    )
end

if shared.debug then
    loadDebugMode = true
    loadWorkspace = true
else
    loadDebugMode = false
    loadWorkspace = true
end
if not isfolder("qwertyware") or not isfolder("qwertyware/games") or not isfolder("qwertyware/custom") or not isfile("qwertyware/version.txt") then
    print("LOAD")
    warn("We are currently creating files needed for running qwertyware. Please be patient.")
    loadstring(readfile("setup.txt"))()
    return
end
local function notif(text)
	game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = text})
end
local lplr = game.Players.LocalPlayer
local plrs = game.Players
local Run = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
local ids = {
	TornadoAlleyUltimate = 2313058949,
	DoorsLobby = 6516141723,
	Doors = 6839171747,
	TheUndergroundWar = 3829055572,
	LuckyBlockBattlegrounds = 662417684,
    SlapBattles = 6403373529,
    SlapBattlesKS = 9015014224,
    SlapBattlesNOS = 2380077519
}
notif("Loading gui")
do --// Credits to 7GrandDad/VapeV4ForRoblox
	function Run:BindToStepped(name, num, func)
		if Run.StepTable[name] == nil then
			Run.StepTable[name] = game:GetService("RunService").Stepped:connect(func)
		end
	end

	function Run:UnbindFromStepped(name)
		if Run.StepTable[name] then
			Run.StepTable[name]:Disconnect()
			Run.StepTable[name] = nil
		end
	end
end --// Credits to 7GrandDad/VapeV4ForRoblox
local colors = {
    SchemeColor = Color3.fromRGB(255,75,255),
    Background = Color3.fromRGB(255,175,255),
    Header = Color3.fromRGB(255,145,255),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(235,165,245)
}
local wronggame = true
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("qwertyware - 1.1", colors)
notif("Loading game")
for i,v in pairs(ids) do
	if game.PlaceId == v then
		wronggame = false
		local MainTab = Window:NewTab("Main")
		local Main = MainTab:NewSection("Main")
		local AutoTab = Window:NewTab("Automated")
		local Auto = AutoTab:NewSection("Automated")
        notif("Detected Game: ".. i)
        task.wait(0.2)
		if i == "TornadoAlleyUltimate" then
			Main:NewButton("ShelterTP","does what it says",function()
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(75494, 31957, -142) -- nvm
			end)
			Auto:NewToggle("AutoWin","does what it says",function(callback)
				if callback then
					Run:BindToStepped("AutoWin",1,function()
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(75492, 31957, -63) -- nvm
					end)
				else
					Run:UnbindFromStepped("AutoWin")
				end
			end)
        elseif i == "SlapBattles" or i == "SlapBattlesKS" or i == "SlapBattlesNOS" then
            local byp
            byp = hookmetamethod(game, "__namecall", function(method, ...) 
            if getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Ban then
                return
                elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.AdminGUI then
                    return
                elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.WalkSpeedChanged then
                    return
                end
                return byp(method, ...)
            end)
            local functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheesynob39/R20-EXPLOITER/main/Files/Functions.lua"))()
            local hit = {
                ["Default"] = game.ReplicatedStorage.b,
                ["Extended"] = game.ReplicatedStorage.b,
                -----------// Glove Hit General Or New Glove \\-----------
                ["T H I C K"] = game.ReplicatedStorage.GeneralHit,
                ["Squid"] = game.ReplicatedStorage.GeneralHit,
                ["Gummy"] = game.ReplicatedStorage.GeneralHit,
                ["RNG"] = game.ReplicatedStorage.GeneralHit,
                ["Tycoon"] = game.ReplicatedStorage.GeneralHit,
                ["Charge"] = game.ReplicatedStorage.GeneralHit,
                ["Baller"] = game.ReplicatedStorage.GeneralHit,
                ["Tableflip"] = game.ReplicatedStorage.GeneralHit,
                ["Booster"] = game.ReplicatedStorage.GeneralHit,
                ["Shield"] = game.ReplicatedStorage.GeneralHit,
                ["Track"] = game.ReplicatedStorage.GeneralHit,
                ["Goofy"] = game.ReplicatedStorage.GeneralHit,
                ["Confusion"] = game.ReplicatedStorage.GeneralHit,
                ["Elude"] = game.ReplicatedStorage.GeneralHit,
                ["Glitch"] = game.ReplicatedStorage.GeneralHit,
                ["Snowball"] = game.ReplicatedStorage.GeneralHit,
                ["fish"] = game.ReplicatedStorage.GeneralHit,
                ["Killerfish"] = game.ReplicatedStorage.GeneralHit,
                ["🗿"] = game.ReplicatedStorage.GeneralHit,
                ["Obby"] = game.ReplicatedStorage.GeneralHit,
                ["Voodoo"] = game.ReplicatedStorage.GeneralHit,
                ["Leash"] = game.ReplicatedStorage.GeneralHit,
                ["Flamarang"] = game.ReplicatedStorage.GeneralHit,
                ["Berserk"] = game.ReplicatedStorage.GeneralHit,
                ["Quake"] = game.ReplicatedStorage.GeneralHit,
                ["Rattlebones"] = game.ReplicatedStorage.GeneralHit,
                ["Chain"] = game.ReplicatedStorage.GeneralHit,
                ["Ping Pong"] = game.ReplicatedStorage.GeneralHit,
                ["Whirlwind"] = game.ReplicatedStorage.GeneralHit,
                ["Slicer"] = game.ReplicatedStorage.GeneralHit,
                ["Counter"] = game.ReplicatedStorage.GeneralHit,
                ["Hammer"] = game.ReplicatedStorage.GeneralHit,
                ["Excavator"] = game.ReplicatedStorage.GeneralHit,
                ["Home Run"] = game.ReplicatedStorage.GeneralHit,
                ["Psycho"] = game.ReplicatedStorage.GeneralHit,
                ["Kraken"] = game.ReplicatedStorage.GeneralHit,
                ["Gravity"] = game.ReplicatedStorage.GeneralHit,
                ["Lure"] = game.ReplicatedStorage.GeneralHit,
                ["Jebaited"] = game.ReplicatedStorage.GeneralHit,
                ["Meteor"] = game.ReplicatedStorage.GeneralHit,
                ["Tinkerer"] = game.ReplicatedStorage.GeneralHit,    
                ["Guardian Angel"] = game.ReplicatedStorage.GeneralHit,
                ["Sun"] = game.ReplicatedStorage.GeneralHit,
                ["Necromancer"] = game.ReplicatedStorage.GeneralHit,
                ["Zombie"] = game.ReplicatedStorage.GeneralHit,
                ["Dual"] = game.ReplicatedStorage.GeneralHit,
                ["Alchemist"] = game.ReplicatedStorage.GeneralHit,
                ["Parry"] = game.ReplicatedStorage.GeneralHit,
                ["Druid"] = game.ReplicatedStorage.GeneralHit,
                ["Oven"] = game.ReplicatedStorage.GeneralHit,
                ["Jester"] = game.ReplicatedStorage.GeneralHit,
                ["Ferryman"] = game.ReplicatedStorage.GeneralHit,
                ["Scythe"] = game.ReplicatedStorage.GeneralHit,
                ["Blackhole"] = game.ReplicatedStorage.GeneralHit,
                ["Santa"] = game.ReplicatedStorage.GeneralHit,
                ["Grapple"] = game.ReplicatedStorage.GeneralHit,
                ["Iceskate"] = game.ReplicatedStorage.GeneralHit,
                ["Pan"] = game.ReplicatedStorage.GeneralHit,
                ["Blasphemy"] = game.ReplicatedStorage.GeneralHit,
                ["Blink"] = game.ReplicatedStorage.GeneralHit,
                ["Ultra Instinct"] = game.ReplicatedStorage.GeneralHit,
                ["Admin"] = game.ReplicatedStorage.GeneralHit,
                ["Prop"] = game.ReplicatedStorage.GeneralHit,
                ["Joust"] = game.ReplicatedStorage.GeneralHit,
                ["Slapstick"] = game.ReplicatedStorage.GeneralHit,
                ["Firework"] = game.ReplicatedStorage.GeneralHit,
                ["Run"] = game.ReplicatedStorage.GeneralHit,
                ["Beatdown"] = game.ReplicatedStorage.GeneralHit,
                ["L.O.L.B.O.M.B"] = game.ReplicatedStorage.GeneralHit,
                ["Glovel"] = game.ReplicatedStorage.GeneralHit,
                ["Chicken"] = game.ReplicatedStorage.GeneralHit,
                ["Divebomb"] = game.ReplicatedStorage.GeneralHit,
                ["Lamp"] = game.ReplicatedStorage.GeneralHit,
                ["Pocket"] = game.ReplicatedStorage.GeneralHit,
                ["BONK"] = game.ReplicatedStorage.GeneralHit,
                ["Knockoff"] = game.ReplicatedStorage.GeneralHit,
                ["Divert"] = game.ReplicatedStorage.GeneralHit,
                ["Frostbite"] = game.ReplicatedStorage.GeneralHit,
                ["Sbeve"] = game.ReplicatedStorage.GeneralHit,
                ["Plank"] = game.ReplicatedStorage.GeneralHit,
                ["Golem"] = game.ReplicatedStorage.GeneralHit,
                ["Spoonful"] = game.ReplicatedStorage.GeneralHit,
                -----------// Glove Hit Normal Or New Glove \\-----------
                ["ZZZZZZZ"] = game.ReplicatedStorage.ZZZZZZZHit,
                ["Brick"] = game.ReplicatedStorage.BrickHit,
                ["Snow"] = game.ReplicatedStorage.SnowHit,
                ["Pull"] = game.ReplicatedStorage.PullHit,
                ["Flash"] = game.ReplicatedStorage.FlashHit,
                ["Spring"] = game.ReplicatedStorage.springhit,
                ["Swapper"] = game.ReplicatedStorage.HitSwapper,
                ["Bull"] = game.ReplicatedStorage.BullHit,
                ["Dice"] = game.ReplicatedStorage.DiceHit,
                ["Ghost"] = game.ReplicatedStorage.GhostHit,
                ["Thanos"] = game.ReplicatedStorage.ThanosHit,
                ["Stun"] = game.ReplicatedStorage.HtStun,
                ["Za Hando"] = game.ReplicatedStorage.zhramt,
                ["Fort"] = game.ReplicatedStorage.Fort,
                ["Magnet"] = game.ReplicatedStorage.MagnetHIT,
                ["Pusher"] = game.ReplicatedStorage.PusherHit,
                ["Anchor"] = game.ReplicatedStorage.hitAnchor,
                ["Space"] = game.ReplicatedStorage.HtSpace,
                ["Boomerang"] = game.ReplicatedStorage.BoomerangH,
                ["Speedrun"] = game.ReplicatedStorage.Speedrunhit,
                ["Mail"] = game.ReplicatedStorage.MailHit,
                ["Golden"] = game.ReplicatedStorage.GoldenHit,
                ["MR"] = game.ReplicatedStorage.MisterHit,
                ["Reaper"] = game.ReplicatedStorage.ReaperHit,
                ["Replica"] = game.ReplicatedStorage.ReplicaHit,
                ["Defense"] = game.ReplicatedStorage.DefenseHit,
                ["Killstreak"] = game.ReplicatedStorage.KSHit,
                ["Reverse"] = game.ReplicatedStorage.ReverseHit,
                ["Shukuchi"] = game.ReplicatedStorage.ShukuchiHit,
                ["Duelist"] = game.ReplicatedStorage.DuelistHit,
                ["woah"] = game.ReplicatedStorage.woahHit,
                ["Ice"] = game.ReplicatedStorage.IceHit,
                ["Adios"] = game.ReplicatedStorage.hitAdios,
                ["Blocked"] = game.ReplicatedStorage.BlockedHit,
                ["Engineer"] = game.ReplicatedStorage.engiehit,
                ["Rocky"] = game.ReplicatedStorage.RockyHit,
                ["Conveyor"] = game.ReplicatedStorage.ConvHit,
                ["STOP"] = game.ReplicatedStorage.STOP,
                ["Phantom"] = game.ReplicatedStorage.PhantomHit,
                ["Wormhole"] = game.ReplicatedStorage.WormHit,
                ["Acrobat"] = game.ReplicatedStorage.AcHit,
                ["Plague"] = game.ReplicatedStorage.PlagueHit,
                ["[REDACTED]"] = game.ReplicatedStorage.ReHit,
                ["bus"] = game.ReplicatedStorage.hitbus,
                ["Phase"] = game.ReplicatedStorage.PhaseH,
                ["Warp"] = game.ReplicatedStorage.WarpHt,
                ["Bomb"] = game.ReplicatedStorage.BombHit,
                ["Bubble"] = game.ReplicatedStorage.BubbleHit,
                ["Jet"] = game.ReplicatedStorage.JetHit,
                ["Shard"] = game.ReplicatedStorage.ShardHIT,
                ["potato"] = game.ReplicatedStorage.potatohit,
                ["CULT"] = game.ReplicatedStorage.CULTHit,
                ["bob"] = game.ReplicatedStorage.bobhit,
                ["Buddies"] = game.ReplicatedStorage.buddiesHIT,
                ["Spy"] = game.ReplicatedStorage.SpyHit,
                ["Detonator"] = game.ReplicatedStorage.DetonatorHit,
                ["Rage"] = game.ReplicatedStorage.GRRRR,
                ["Trap"] = game.ReplicatedStorage.traphi,
                ["Orbit"] = game.ReplicatedStorage.Orbihit,
                ["Hybrid"] = game.ReplicatedStorage.HybridCLAP,
                ["Slapple"] = game.ReplicatedStorage.SlappleHit,
                ["Disarm"] = game.ReplicatedStorage.DisarmH,
                ["Dominance"] = game.ReplicatedStorage.DominanceHit,
                ["Link"] = game.ReplicatedStorage.LinkHit,
                ["Rojo"] = game.ReplicatedStorage.RojoHit,
                ["rob"] = game.ReplicatedStorage.robhit,
                ["Rhythm"] = game.ReplicatedStorage.rhythmhit,
                ["Nightmare"] = game.ReplicatedStorage.nightmarehit,
                ["Hitman"] = game.ReplicatedStorage.HitmanHit,
                ["Thor"] = game.ReplicatedStorage.ThorHit,
                ["Retro"] = game.ReplicatedStorage.RetroHit,
                ["Cloud"] = game.ReplicatedStorage.CloudHit,
                ["Null"] = game.ReplicatedStorage.NullHit,
                ["spin"] = game.ReplicatedStorage.spinhit,
                -----------// Glove Hit Stun \\-----------
                ["Kinetic"] = game.ReplicatedStorage.HtStun,
                ["Recall"] = game.ReplicatedStorage.HtStun,
                ["Balloony"] = game.ReplicatedStorage.HtStun,
                ["Sparky"] = game.ReplicatedStorage.HtStun,
                ["Boogie"] = game.ReplicatedStorage.HtStun,
                ["Stun"] = game.ReplicatedStorage.HtStun,
                ["Coil"] = game.ReplicatedStorage.HtStun,
                -----------// Glove Hit Diamond \\-----------
                ["Diamond"] = game.ReplicatedStorage.DiamondHit,
                ["Megarock"] = game.ReplicatedStorage.DiamondHit,
                -----------// Glove Hit Celestial \\-----------
                ["Moon"] = game.ReplicatedStorage.CelestialHit,
                ["Jupiter"] = game.ReplicatedStorage.CelestialHit,
                -----------// Glove Hard \\-----------
                ["Mitten"] = game.ReplicatedStorage.MittenHit,
                ["Hallow Jack"] = game.ReplicatedStorage.HallowHIT,
                -----------// Glove Hit Power \\-----------
                ["OVERKILL"] = game.ReplicatedStorage.Overkillhit,
                ["The Flex"] = game.ReplicatedStorage.FlexHit,
                ["Custom"] = game.ReplicatedStorage.CustomHit,
                ["God's Hand"] = game.ReplicatedStorage.Godshand,
                ["Error"] = game.ReplicatedStorage.Errorhit
            }
            local looptable = {}
            local function doLoop(name,func)
                if looptable[name] == nil then
                    looptable[name] = game:GetService("RunService").Stepped:Connect(func)
                end
            end
            local function endLoop(name)
                if looptable[name] then
                    looptable[name]:Disconnect()
                    looptable[name] = nil
                end
            end
            local CombatTab = Window:NewTab("Combat")
            local Combat = CombatTab:NewSection("Combat")
            local PlayerTab = Window:NewTab("Player")
            local Player = PlayerTab:NewSection("Player")
            local WorldTab = Window:NewTab("World")
            local World = WorldTab:NewSection("World")
            local function glove()
                return game.Players.LocalPlayer.leaderstats.Glove.Value
            end
            local gl = nil
            Main:NewButton("Death Godmode","",function()
                local name = "Killstreak"
                local gear = lplr.Backpack[tostring(glove())]
                local fakegear = gear:Clone()
                fakegear.Parent = workspace
                fakegear.Handle.Anchored = true
                local oldpos = lplr.Character.HumanoidRootPart.CFrame
                lplr.Character.Humanoid.Health = 0
                task.wait(3.95)
                fakegear.Handle.Anchored = false
                lplr.Character.HumanoidRootPart.CFrame = oldpos
                fakegear.Parent = lplr.Backpack
                lplr.Character.entered = true
                lplr.Character.isInArena = true
            end)
            local aurticks = 0
            local afon = false
            local afticks = 0
            local annoying = false
            Auto:NewToggle("Annoying (AutoFarm)","",function(cb)
                if cb then
                    amnoying = true
                else
                    annoying = false
                end
            end)
            local aftarget = plrs:GetPlayers()[math.random(1,#plrs:GetPlayers())]
            Auto:NewToggle("AutoFarm","",function(cb)
                if cb then
                    afon = true
                    doLoop("autofarm",function()
                        if annoying == true then game:GetService("ReplicatedStorage").rhythmevent:FireServer("AoeExplosion",0) end
                        afticks += 1
                        if afticks == 65 then
                            aftarget = plrs:GetPlayers()[math.random(1,#plrs:GetPlayers())]
                            afticks = 0
                        end
                        if aftarget.Character == nil or aftarget.Character.Humanoid.Health <= 1 or aftarget.Character.HumanoidRootPart.CFrame.Y <= -20 or aftarget.Character.HumanoidRootPart.CFrame.Y >= 65 or aftarget.leaderstats.Glove.Value == "Spectator" or not aftarget.Character.Head:FindFirstChild("UnoReverseCard") == nil then
                            aftarget = plrs:GetPlayers()[math.random(1,#plrs:GetPlayers())]
                            lplr.Character.HumanoidRootPart.CFrame = CFrame.new(0,-5,0)
                        else
                            lplr.Character.HumanoidRootPart.CFrame = aftarget.Character.HumanoidRootPart.CFrame
                        end
                    end)
                else
                    endLoop("autofarm")
                    afon = false
                end
            end)
            local auramode = "Blatant"
            Combat:NewDropdown("Mode","", {"Blatant","Sync","Legit","Semi-Legit"},function(cb)
                auramode = cb
            end)
            local doSlapAnim = false
            local waittime = 0.25
            local setvalue = 0.25
            Combat:NewSlider("Delay", "", 100, 25, function(s) -- 500 (MaxValue) | 0 (MinValue)
                setvalue = s/100
                waitime = s/100
            end)
            local ticks = 0
            local dodge = false
            Combat:NewToggle("Aura","",function(cb)
                if cb then
                    warn("on")
                    doLoop("aura",function(delta)
                        aurticks = aurticks + 1
                        print("looping")
                        for i,plr in next, plrs:GetPlayers() do
                            --warn("players done")
                            --print("went through players")
                            if plr ~= lplr and plr ~= nil and plr.Character:FindFirstChild("Head"):FindFirstChild("UnoReverseCard") == nil and plr.Character.Head ~= nil and plr.Character.Ragdolled ~= nil and not plr.Character.Ragdolled.Value then
                                local dist = (lplr.Character:FindFirstChild("HumanoidRootPart").Position - plr.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
                                --print("checks passed")
                                waittime = setvalue
                                if (auramode == "Blatant" and dist <= 25 or auramode == "Sync" and dist <= 25 or auramode == "Legit" and dist <= 9.25 or auramode == "Semi-Legit" and dist <= 12.45) then
                                    
                                    local targ = game.Players[plr.Name]
                                    if afon then
                                        targ = game.Players[aftarget.Name]
                                    end
                                    if targ.leaderstats.Glove.Value == "OVERKILL" then
                                        waittime = 0.085
                                    end
                                    if auramode == "Sync" or auramode == "Legit" or auramode == "Semi-Legit" then
                                        if doSlapAnim then
                                            hit[glove()]:FireServer(targ.Character:FindFirstChild("Torso"))
                                            lplr.Character.Humanoid.Animator:LoadAnimation(game:GetService("ReplicatedStorage").Slap):Play()
                                            doSlapAnim = false
                                        end
                                    else
                                        local args = {
                                            [1] = targ
                                        }
                                        game:GetService("ReplicatedStorage"):WaitForChild("SM"):FireServer(unpack(args))
                                        hit[glove()]:FireServer(targ.Character:FindFirstChild("Head"))
                                        if doSlapAnim then
                                            lplr.Character.Humanoid.Animator:LoadAnimation(game:GetService("ReplicatedStorage").Slap):Play()
                                            doSlapAnim = false
                                        end
                                    end
                                end
                            end
                        end
                        --print("waiting")
                    end)
                    repeat
                        task.wait(waittime)
                        doSlapAnim = true
                    until not cb
                    warn("loop started")
                else
                    endLoop("aura")
                end
            end)
            local donerag = true
            local pos
            doLoop("getpos",function()
                if not lplr.Character.Ragdolled.Value and donerag then
                    pos = lplr.Character.HumanoidRootPart.CFrame
                end
            end)
            local velomode = "TP"
            local veloci
            lplr.CharacterAdded:Connect(function()
                task.wait(1)
                local ragdoll = lplr.Character.Ragdolled
                lplr.Character.Ragdolled.Changed:Connect(function()
                    if ragdoll.Value and veloci then
                        if velomode == "TP" then
                            donerag = false
                            task.wait(1)
                            repeat task.wait() until not ragdoll.Value
                            lplr.Character.HumanoidRootPart.CFrame = pos
                            donerag = true
                        elseif velomode == "Anchor" then
                            lplr.Character.Torso.Anchored = true
                            task.wait(1)
                            repeat task.wait() until not ragdoll.Value or lplr.Character.Torso == nil
                            lplr.Character.Torso.Anchored = false
                            donerag = true
                        elseif velomode == "Legit" then
                            task.wait(1)
                            repeat task.wait() until not ragdoll.Value
                            lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,4,-2)
                            donerag = true
                        end
                    end
                end)
            end)
            Player:NewDropdown("Mode","", {"TP","Anchor","Legit"},function(cb)
                velomode = cb
            end)
            Player:NewToggle("Velocity","",function(cb)
                if cb then
                    lplr.Character.Humanoid.Health = 0
                    veloci = true
                else
                    veloci = false
                end
            end)
            local part
            local part2
            World:NewToggle("AntiVoid","",function(cb)
                if cb then
                    part = Instance.new("Part",workspace)
                    part.Anchored = true
                    part.CFrame = CFrame.new(0,-15,0)
                    part.Size = Vector3.new(2048,1,2048)
                    part.CanCollide = true
                    part.Transparency = 0.5
                    part2 = Instance.new("Part",workspace)
                    part2.Anchored = true
                    part2.CFrame = CFrame.new(0,-77.5,0)
                    part2.Size = Vector3.new(2048,1,2048)
                    part2.CanCollide = true
                    part2.Transparency = 0.5
                else
                    part:Destroy()
                    part2:Destroy()
                end
            end)
            World:NewToggle("AutoSlapple","",function(cb)
                if cb then
                    doLoop("slapple",function()
                        for i,v in next, workspace.Arena.island5.Slapples:GetDescendants() do
                            if v.ClassName == "TouchTransmitter" then
                                firetouchinterest(lplr.Character.Head, v.Parent, 1)
                                firetouchinterest(lplr.Character.Head, v.Parent, 0)
                            end
                        end
                    end)
                else
                    endLoop("slapple")
                end
            end)
            -- gloves
            Auto:NewToggle("Tycoon","",function(cb)
                if cb then
                    doLoop("tycoon",function()
                        lplr.Character.HumanoidRootPart.Anchored = false
                        lplr.Character.HumanoidRootPart.CFrame = game.Workspace.Arena:WaitForChild("Plate").CFrame * CFrame.new(0,-0.75,0)
                    end)
                else
                    endLoop("tycoon")
                end
            end)
		elseif i == "LuckyBlockBattlegrounds" then
            
			local lucky = game:GetService("ReplicatedStorage").SpawnLuckyBlock
			local superblock = game:GetService("ReplicatedStorage").SpawnSuperBlock
			local diamond = game:GetService("ReplicatedStorage").SpawnDiamondBlock
			local rainbow = game:GetService("ReplicatedStorage").SpawnRainbowBlock
			local galaxy = game:GetService("ReplicatedStorage").SpawnGalaxyBlock
			local function SpawnRandomBlock()
				local amm = tonumber(math.random(1,5))
                if amm == 1 then
					lucky:FireServer()
				end
				if amm == 2 then
					superblock:FireServer()
				end
				if amm == 3 then
					diamond:FireServer()
				end
				if amm == 4 then
					rainbow:FireServer()
				end
				if amm == 5 then
					galaxy:FireServer()
				end
			end
			Main:NewButton("Random Block","opens a random lucky block",function()
				SpawnRandomBlock()
			end)
            local toOpen = "Lucky Block" -- prevents errors for using the feature without selecting a block first
            Main:NewButton("Block Opener","does what it says",function()
				if toOpen == "Lucky Block" then
					lucky:FireServer()
				end
				if toOpen == "Super Lucky Block" then
					superblock:FireServer()
				end
				if toOpen == "Diamond Block" then
					diamond:FireServer()
				end
				if toOpen == "Rainbow Block" then
					rainbow:FireServer()
				end
				if toOpen == "Galaxy Block" then
					galaxy:FireServer()
				end
			end)
            Main:NewDropdown("Select Block", "does what it says", {"Lucky Block", "Super Lucky Block", "Diamond Block", "Rainbow Block", "Galaxy Block"}, function(currentOption)
                toOpen = currentOption
            end)
            local aob = false
            Auto:NewToggle("AutoOpenBlock","does what it says",function(callback)
            	if callback then
            		aob = true
            		repeat
						SpawnRandomBlock()
						task.wait(5)
            		until not aob
            	else
					aob = false
				end
            end)
		elseif i == "TheUndergroundWar" then
			local farm = false
			Main:NewButton("Grab Flag","does what it says",function()
				lplr.Character.Humanoid.HipHeight = -25
				workspace.Gravity = 0
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,182)
				task.wait(5)
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,-182)
				task.wait(4)
				lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,10,10)
				task.wait(0.5)
				lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,10)
				task.wait(0.5)
				workspace.Gravity = 196.2
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(6,17,-75)
				task.wait(0.63)
				workspace.Gravity = 0
				lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,-12,-10)
				task.wait(3.4)
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,182)
				task.wait(1)
				lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,11,-15)
				task.wait(1)
				lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-8,17,75)
				lplr.Character.Humanoid.HipHeight = 0
				workspace.Gravity = 196.2
			end)
			Auto:NewToggle("AutoFlag","does what it says",function(callback)
				if callback then
					farm = true
					repeat
						lplr.Character.Humanoid.HipHeight = -25
						workspace.Gravity = 0
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,182)
						task.wait(5)
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,-182)
						task.wait(4)
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,10,10)
						task.wait(0.5)
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,10)
						task.wait(0.5)
						workspace.Gravity = 196.2
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(6,19,-75)
						task.wait(0.63)
						workspace.Gravity = 0
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,-12,-10)
						task.wait(3.4)
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-25,6,182)
						task.wait(1)
						lplr.Character.HumanoidRootPart.CFrame = lplr.Character.HumanoidRootPart.CFrame * CFrame.new(0,11,-15)
						task.wait(1)
						lplr.Character.HumanoidRootPart.CFrame = CFrame.new(-8,17,75)
						lplr.Character.Humanoid.HipHeight = 0
						workspace.Gravity = 196.2
						task.wait(2.5)
					until not farm
				else
					farm = false
				end
			end)
		elseif i == "DoorsLobby" or i == "Doors" then
			local speed
			Main:NewToggle("Speed","does what it says",function(callback)
				if callback then
					speed = lplr.Character.Humanoid.WalkSpeed
					Run:BindToStepped("Speed",1,function(delta)
						if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
									lplr.Character:TranslateBy(game.Players.LocalPlayer.Character.Humanoid.MoveDirection * 20/75)
							end
					end)
				else
					Run:UnbindFromStepped("Speed")
					lplr.Character.Humanoid.WalkSpeed = speed
				end
			end)
			Main:NewToggle("AntiGate","does what it says",function(callback)
				if callback then
					Run:BindToStepped("AntiGate",1,function()
						local rooms = workspace.CurrentRooms
						for i,v in pairs(rooms:GetChildren()) do
							if rooms[tostring(v)]:FindFirstChild("Gate") then
								novoline["Utility"]["CreateNotification"]("AntiGate","Removed a gate!",5)
								rooms[tostring(v)].Gate:Destroy()
							end
						end
					end)
				else
					Run:UnbindFromStepped("AntiGate")
				end
			end)
			Auto:NewToggle("AutoDoor","does what it says",function(callback)
				if callback then
					Run:BindToStepped("AutoDoor",1,function()
						local rooms = workspace.CurrentRooms
						for i,v in pairs(rooms:GetChildren()) do
							if rooms[tostring(v)]:FindFirstChild("Door") then
								rooms[tostring(v)].Door.ClientOpen:FireServer()
							end
						end
					end)
				else
					Run:UnbindFromStepped("AutoDoor")
				end
			end)
			local key = false
			Auto:NewToggle("AutoKey","does what it says",function(callback)
				if callback then
					key = true
					for i,v in ipairs(workspace.CurrentRooms:GetDescendants()) do
						if v.Name == "KeyObtain" then
							game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Found a key!\nTeleporting.."})
							lplr.Character:PivotTo(CFrame.new(v.Hitbox.Position))
							fireproximityprompt(v.ModulePrompt,0)
						end
					end
				else
					key = false
				end
			end)
			workspace.CurrentRooms.DescendantAdded:Connect(function(v)
				if v.Name == "KeyObtain" and key then
					game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Found a key!\nTeleporting.."})
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(v.Hitbox.Position))
					fireproximityprompt(v.ModulePrompt,0)
				end
			end)
			Main:NewToggle("NoDark","does what it says",function(callback)
				if callback then
					local light = Instance.new("SpotLight")
					light.Brightness = 1
					light.Face = Enum.NormalId.Front
					light.Range = 90000
					light.Parent = lplr.Character.Head
					light.Enabled = true
					light.Name = "NoDark"
				else
					local light = lplr.Character.Head:WaitForChild("NoDark")
					light:Destroy()
				end
			end)
			local ash = false
			Main:NewToggle("AntiSeekHall","does what it says",function(callback)
				if callback then
					ash = true
				else
					ash = false
				end
			end)
			workspace.CurrentRooms.DescendantAdded:Connect(function(thing)
				if ash then
					if thing.Name == ("Seek_Arm" or "ChandelierObstruction") then
						task.spawn(function()
							wait()
							thing:Destroy()
						end)
					end
				end
			end)
			local ealert = false
			Main:NewToggle("SpawnAlert","does what it says",function(callback)
				if callback then
					ealert = true
				else
					ealert = false
				end
			end)
			workspace.ChildAdded:Connect(function(thing)
				if ealert then
					if thing.Name == "RushMoving" then
						game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Rush has spawned!"})
					elseif thing.Name == "AmbushMoving" then
						game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Ambush has spawned!"})
					end
				end
			end)
			local screech = false
			Main:NewToggle("AntiScreech","does what it says",function(callback)
				if callback then
					screech = true
				else
					screech = false
				end
			end)
			workspace.CurrentCamera.ChildAdded:Connect(function(thing)
				if thing.Name == "Screech" then
					if screech then
						game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Killed Screech!"})
						thing:Destroy()
					end
				end
			end)
		end
	end
end
local DiscordTab = Window:NewTab("Discord")
local Discord = DiscordTab:NewSection("Discord")
Discord:NewButton("Copy Discord Invite", "Copies the Qwertyware Discord invite", function()
    setclipboard("https://discord.gg/AeXGDZZB")
    game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Copied Qwertyware Discord Invite"})
end)
if wronggame then
	game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Unsupported Game!"})
end
if loadDebugMode then
    local d1 = Window:NewTab("DEBUG")
    local d2 = d1:NewSection("DEBUG")
    d2:NewButton("Reload","",function(callback)
        Library:ToggleUI()
        notif("Reloading")
        Combat = nil
        gloves = nil
        doLoop = nil
        endLoop = nil
        task.wait(0.1)
        shared.debug = true
        loadstring(readfile("qwertyware.txt"))()
    end)
    d2:NewLabel("Make sure to disable everything!")
end
