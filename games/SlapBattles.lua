if shared.debug then
    loadDebugMode = true
    loadWorkspace = true
else
    loadDebugMode = false
    loadWorkspace = true
end
local lplr = game.Players.LocalPlayer
local plrs = game.Players
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
local function notif(text)
	game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = text})
end
local colors = {
    SchemeColor = Color3.fromRGB(255,75,255),
    Background = Color3.fromRGB(255,175,255),
    Header = Color3.fromRGB(255,145,255),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(235,165,245)
}
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("qwertyware - 1.1", colors)
local MainTab = Window:NewTab("Main")
local Main = MainTab:NewSection("Main")
local AutoTab = Window:NewTab("Automated")
local Auto = AutoTab:NewSection("Automated")
local CombatTab = Window:NewTab("Combat")
local Combat = CombatTab:NewSection("Combat")
local PlayerTab = Window:NewTab("Player")
local Player = PlayerTab:NewSection("Player")
local WorldTab = Window:NewTab("World")
local World = WorldTab:NewSection("World")
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
local auramode = "Normal"
Combat:NewDropdown("Mode","", {"Normal","Legit","Semi-Legit"},function(cb)
    auramode = cb
end)
local doSlapAnim = false
local waittime = 0.25
local setvalue = 0.25
Combat:NewSlider("Delay", "Doesn't apply to killstreak.", 100, 25, function(s) -- 500 (MaxValue) | 0 (MinValue)
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
                    if (auramode == "Normal" and dist <= 25 or auramode == "Legit" and dist <= 9.25 or auramode == "Semi-Legit" and dist <= 12.45) then
                        
                        local targ = game.Players[plr.Name]
                        if afon then
                            targ = game.Players[aftarget.Name]
                        end
                        if targ.leaderstats.Glove.Value == "OVERKILL" then
                            waittime = 0.085
                        end
                        if doSlapAnim then
                            hit[glove()]:FireServer(targ.Character:FindFirstChild("Torso"))
                            lplr.Character.Humanoid.Animator:LoadAnimation(game:GetService("ReplicatedStorage").Slap):Play()
                            doSlapAnim = false
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
local DiscordTab = Window:NewTab("Discord")
local Discord = DiscordTab:NewSection("Discord")
Discord:NewButton("Copy Discord Invite", "Copies the Qwertyware Discord invite", function()
    setclipboard("https://discord.gg/AeXGDZZB")
    game.StarterGui:SetCore("SendNotification", {Title = "qwertyware", Text = "Copied Qwertyware Discord Invite"})
end)
notif("Loaded!")
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