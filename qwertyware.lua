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
if not isfolder("qwertyware") or not isfolder("qwertyware/games") then
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
	LuckyBlockBattlegrounds = 662417684,
    SlapBattles = 6403373529,
    SlapBattlesKS = 9015014224, -- Killstreak Only
    SlapBattlesNOS = 2380077519 -- No one shots
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
notif("Loading game")
local function loadScript(name)
    if loadDebugMode then
        loadstring(readfile("qwertyware/games/"..name..".lua"))()
    else

    end
end
for i,v in pairs(ids) do
	if game.PlaceId == v then
		wronggame = false
        notif("Detected Game: ".. i)
        task.wait(0.2)
        notif("Getting latest version")
        task.wait(2)
		if i == "TornadoAlleyUltimate" then
            loadScript("TornadoAlleyUltimate")
        elseif i == "SlapBattles" or i == "SlapBattlesKS" or i == "SlapBattlesNOS" then
            loadScript("SlapBattles")
		elseif i == "LuckyBlockBattlegrounds" then
            loadScript("LuckyBlockBattlegrounds")
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
