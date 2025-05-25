local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;

local service = 3431; 
local pasta = "951a1259-8c76-43c9-979f-875c1f41f202";
local useNonce = true;  -- use a nonce to prevent replay attacks and request tampering.

--! File Saving Configuration
local keyFileName = "platoboost_saved_key.txt"
local fileFuncsAvailable = isfile and readfile and writefile

--! Forward declare Fluent for onMessage
local Fluent

--! callbacks
local onMessage = function(message)
    -- Use Fluent's notification system if available, otherwise print
    if Fluent and Fluent.Notify then
        Fluent:Notify({
            Title = "Platoboost Status",
            Content = message,
            Duration = 5
        })
    else
        print("Platoboost:", message)
    end
end;

--! wait for game to load
repeat task.wait(1) until game:IsLoaded();

--! functions
local requestSending = false;
-- local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return game:GetService("Players").LocalPlayer.UserId end
local fSetClipboard, fRequest, fStringChar, fToString, fStringSub, fOsTime, fMathRandom, fMathFloor, fGetHwid = setclipboard or toclipboard, request or http_request or syn_request, string.char, tostring, string.sub, os.time, math.random, math.floor, gethwid or function() return tostring(game:GetService("Players").LocalPlayer.UserId) end
local cachedLink, cachedTime = "", 0;

--! pick host
local host = "https://api.platoboost.com";
pcall(function() -- Wrap in pcall in case request fails badly
    local hostResponse = fRequest({
        Url = host .. "/public/connectivity",
        Method = "GET"
    });
    if not hostResponse or (hostResponse.StatusCode ~= 200 or hostResponse.StatusCode == 429) then
        host = "https://api.platoboost.net";
        print("Platoboost: Switched to backup host.")
    end
end)


--!optimize 2
function cacheLink()
    if cachedTime + (10*60) < fOsTime() then
        local success, response = pcall(fRequest, {
            Url = host .. "/public/start",
            Method = "POST",
            Body = lEncode({
                service = service,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        });

        if not success or not response then
             onMessage("Network error while trying to cache link.")
             return false, "Network error"
        end

        if response.StatusCode == 200 then
            local decodeSuccess, decoded = pcall(lDecode, response.Body)
            if not decodeSuccess then
                onMessage("Failed to decode server response (cacheLink).")
                return false, "Decoding error"
            end

            if decoded.success == true then
                cachedLink = decoded.data.url;
                cachedTime = fOsTime();
                return true, cachedLink;
            else
                onMessage(decoded.message or "Unknown error from server (cacheLink).");
                return false, decoded.message or "Unknown error";
            end
        elseif response.StatusCode == 429 then
            local msg = "You are being rate limited, please wait 20 seconds and try again.";
            onMessage(msg);
            return false, msg;
        end

        local msg = "Failed to cache link (Status: " .. (response.StatusCode or "N/A") .. ").";
        onMessage(msg);
        return false, msg;
    else
        return true, cachedLink;
    end
end

-- Initial cache attempt
cacheLink();

--!optimize 2
local generateNonce = function()
    local str = ""
    for _ = 1, 16 do
        str = str .. fStringChar(fMathFloor(fMathRandom() * (122 - 97 + 1)) + 97)
    end
    return str
end

--!optimize 1
-- Nonce check (optional, but good practice)
task.spawn(function()
    for _ = 1, 5 do
        local oNonce = generateNonce();
        task.wait(0.2)
        if generateNonce() == oNonce then
            local msg = "Platoboost nonce generation warning: potential low entropy.";
            -- onMessage(msg); -- Maybe too noisy for users, keep as warn
            warn(msg) -- Use warn for developer visibility
        end
    end
end)

--!optimize 2
local copyLink = function()
    local success, linkOrMsg = cacheLink();

    if success then
        fSetClipboard(linkOrMsg);
        onMessage("Link copied to clipboard!"); -- Provide feedback
        return true -- Indicate success
    else
        -- onMessage already called by cacheLink on failure
        return false -- Indicate failure
    end
end

--!optimize 2
local redeemKey = function(key)
    local nonce = generateNonce();
    local endpoint = host .. "/public/redeem/" .. fToString(service);

    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }

    if useNonce then
        body.nonce = nonce;
    end

    local reqSuccess, response = pcall(fRequest,{
        Url = endpoint,
        Method = "POST",
        Body = lEncode(body),
        Headers = {
            ["Content-Type"] = "application/json"
        }
    });

     if not reqSuccess or not response then
         onMessage("Network error while trying to redeem key.")
         return false
     end

    if response.StatusCode == 200 then
         local decodeSuccess, decoded = pcall(lDecode, response.Body)
         if not decodeSuccess then
            onMessage("Failed to decode server response (redeemKey).")
            return false
         end

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest(tostring(true) .. "-" .. nonce .. "-" .. pasta) then
                        onMessage("Key successfully redeemed!");
                        return true;
                    else
                        onMessage("Failed to verify integrity (redeemKey).");
                        return false;
                    end
                else
                    onMessage("Key successfully redeemed!");
                    return true;
                end
            else
                -- This case might not happen often in redeem, usually success=false covers it
                onMessage("Redemption failed: Key marked invalid by server.");
                return false;
            end
        else
            if decoded.message and fStringSub(decoded.message, 1, 27) == "unique constraint violation" then
                onMessage("You already have an active key, please wait for it to expire before redeeming another.");
                return false;
            else
                onMessage(decoded.message or "Unknown error from server (redeemKey).");
                return false;
            end
        end
    elseif response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        onMessage("Server returned an invalid status code (".. (response.StatusCode or "N/A") .."), please try again later.");
        return false;
    end
end

--!optimize 2
local verifyKey = function(key)
    if not key or key == "" then
        -- Don't show message here, let caller decide (useful for silent check)
        -- onMessage("Please enter a key.")
        return false
    end

    if requestSending == true then
        onMessage("A request is already being sent, please wait.");
        return false;
    end
    requestSending = true;

    local nonce = generateNonce();
    local identifierParam = "identifier=" .. game:GetService("HttpService"):UrlEncode(lDigest(fGetHwid()))
    local keyParam = "key=" .. game:GetService("HttpService"):UrlEncode(key)
    local endpoint = host .. "/public/whitelist/" .. fToString(service) .. "?" .. identifierParam .. "&" .. keyParam

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

    local reqSuccess, response = pcall(fRequest,{
        Url = endpoint,
        Method = "GET",
    });

    requestSending = false; -- Ensure this is always reset

    if not reqSuccess or not response then
         onMessage("Network error while trying to verify key.")
         return false
     end

    if response.StatusCode == 200 then
        local decodeSuccess, decoded = pcall(lDecode, response.Body)
        if not decodeSuccess then
            onMessage("Failed to decode server response (verifyKey).")
            return false
        end

        if decoded.success == true then
            if decoded.data.valid == true then
                if useNonce then
                    if decoded.data.hash == lDigest(tostring(true) .. "-" .. nonce .. "-" .. pasta) then
                        return true;
                    else
                        onMessage("Failed to verify integrity (verifyKey).");
                        return false;
                    end
                else
                    return true;
                end
            else
                -- Key not whitelisted, check if redeemable
                if key and #key > 4 and fStringSub(key, 1, 4) == "KEY_" then
                    onMessage("Key not found on whitelist, attempting to redeem...");
                    return redeemKey(key);
                else
                    -- Don't send "invalid" message here for silent check
                    -- onMessage("Key is invalid.");
                    return false;
                end
            end
        else
            -- Don't send message here for silent check
            -- onMessage(decoded.message or "Unknown error from server (verifyKey).");
            return false;
        end
    elseif response.StatusCode == 429 then
        onMessage("You are being rate limited, please wait 20 seconds and try again.");
        return false;
    else
        -- Don't send message here for silent check
        -- onMessage("Server returned an invalid status code (".. (response.StatusCode or "N/A") .."), please try again later.");
        return false;
    end
end

--!optimize 2
local getFlag = function(name)
    local nonce = generateNonce();
    local endpoint = host .. "/public/flag/" .. fToString(service) .. "?name=" .. game:GetService("HttpService"):UrlEncode(name);

    if useNonce then
        endpoint = endpoint .. "&nonce=" .. nonce;
    end

     local reqSuccess, response = pcall(fRequest,{
        Url = endpoint,
        Method = "GET",
    });

     if not reqSuccess or not response then
         onMessage("Network error while trying to get flag.")
         return nil
     end

    if response.StatusCode == 200 then
        local decodeSuccess, decoded = pcall(lDecode, response.Body)
        if not decodeSuccess then
            onMessage("Failed to decode server response (getFlag).")
            return nil
        end

        if decoded.success == true then
            if useNonce then
                if decoded.data.hash == lDigest(fToString(decoded.data.value) .. "-" .. nonce .. "-" .. pasta) then
                    return decoded.data.value;
                else
                    onMessage("Failed to verify integrity (getFlag).");
                    return nil;
                end
            else
                return decoded.data.value;
            end
        else
            onMessage(decoded.message or "Unknown error from server (getFlag).");
            return nil;
        end
    elseif response.StatusCode == 429 then
         onMessage("You are being rate limited (getFlag), please wait 20 seconds and try again.");
         return nil
    else
        onMessage("Server returned an invalid status code (".. (response.StatusCode or "N/A") ..") while getting flag.");
        return nil;
    end
end

--! Function to save the key
local function saveKeyToFile(keyToSave)
    if not fileFuncsAvailable then
        print("Platoboost: File functions (writefile) not available. Cannot save key.")
        return false
    end
    local success, err = pcall(writefile, keyFileName, keyToSave)
    if not success then
        warn("Platoboost: Failed to save key to file -", err)
        return false
    else
        --print("Platoboost: Key saved successfully.")
        return true
    end
end

--! Function to load the key
local function loadKeyFromFile()
    if not fileFuncsAvailable then
        print("Platoboost: File functions (isfile, readfile) not available. Cannot load key.")
        return nil
    end
    if not isfile(keyFileName) then
        return nil -- No saved key file exists
    end
    local success, keyContent = pcall(readfile, keyFileName)
    if not success or not keyContent then
        --warn("Platoboost: Failed to read saved key file.")
        return nil
    end
    if keyContent == "" then
        --warn("Platoboost: Saved key file is empty.")
        return nil
    end
    return keyContent
end

local function RunMainScript()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Platoboost",
		Text = "Key Validated",
		Duration = 5,
		Icon = "rbxassetid://809467",
		IconColor = Color3.fromRGB(255, 255, 255)
	})
	if not game:IsLoaded() then
		game.Loaded:Wait()
	end
	
	if _G.UILOADED then 
		return 
	end
	
	_G.UILOADED = true
	
	local cloneref = cloneref or function(o) return o end
	
	local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
	
	local Players = cloneref(game:GetService("Players"))
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local RunService = game:GetService("RunService")
	local TweenService = game:GetService("TweenService")
	local VirtualInputManager = game:GetService("VirtualInputManager")
	local player = Players.LocalPlayer
	local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
	local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
	local TeleportCheck = false
	local PlayerGui = player:WaitForChild("PlayerGui")
	
	spawn(function()
		while true do
			VirtualInputManager:SendKeyEvent(true, 101, false, game)
			task.wait(0.1)
			VirtualInputManager:SendKeyEvent(false, 101, false, game)
			task.wait(120)
		end
	end)
	
	
	_G.ActivityPriority = _G.ActivityPriority or "None"
	_G.AriseSettings = _G.AriseSettings or {
		Toggles = {},
		FarmMoveMode = "Teleport",
		FarmTweenSpeed = 150
	}
	_G.CloseAnyOpenMenu = _G.CloseAnyOpenMenu or function()
	end
	
	getgenv().worldList = {"SoloWorld", "NarutoWorld", "OPWorld", "BleachWorld", "BCWorld", "ChainsawWorld", "JojoWorld", "DBWorld", "OPMWorld", "DanWorld", "Solo2World"}
	getgenv().enemyList = {
		SoloWorld = {"Soondoo", "Gonshee", "Daek", "Longln", "Anders", "Largalgan"},
		NarutoWorld = {"Snake Man", "Blossom", "Black Crow"},
		OPWorld = {"Shark Man", "Eminel", "Light Admiral"},
		BleachWorld = {"Luryu", "Fyakuya", "Genji"},
		BCWorld = {"Sortudo", "Michille", "Wind"},
		ChainsawWorld = {"Heaven", "Zere", "Ika"},
		JojoWorld = {"Diablo", "Gosuke", "Golyne"},
		DBWorld = {"Turtle", "Green", "Sky"},
		OPMWorld = {"Rider", "Cyborg", "Hurricane"},
		DanWorld = {"Shrimp", "Baira", "Lomo"},
		Solo2World = {"Wuiri", "Gernnat", "Chris"}
	}
	
	getgenv().worldMap = {
		["SoloWorld"] = "1", ["NarutoWorld"] = "2", ["OPWorld"] = "3",
		["BleachWorld"] = "4", ["BCWorld"] = "5", ["ChainsawWorld"] = "6",
		["JojoWorld"] = "7", ["DBWorld"] = "8", ["OPMWorld"] = "9",
		["DanWorld"] = "10", ["Solo2World"] = "11"
	}
	
	getgenv().enemyIdMap = {
		['JB1'] = 'Diablo',['JB2'] = 'Gosuke',['JB3'] = 'Golyne',['JBB1'] = 'Diablo',['JBB2'] = 'Gosuke',['JBB3'] = 'Golyne',
		['CH1'] = 'Heaven', ['CH2'] = 'Zere', ['CH3'] = 'Ika', ['CHB1'] = 'Heaven', ['CHB2'] = 'Zere', ['CHB3'] = 'Ika',
		['BC1'] = 'Sortudo', ['BC2'] = 'Michille', ['BC3'] = 'Wind', ['BCB1'] = 'Sortudo', ['BCB2'] = 'Michille', ['BCB3'] = 'Wind',
		['BL1'] = 'Luryu', ['BL2'] = 'Fyakuya', ['BL3'] = 'Genji', ['BLB1'] = 'Luryu', ['BLB2'] = 'Fyakuya', ['BLB3'] = 'Genji',
		['OP1'] = 'Shark Man', ['OP2'] = 'Eminel', ['OP3'] = 'Light Admiral', ['OPB1'] = 'Shark Man', ['OPB2'] = 'Eminel', ['OPB3'] = 'Light Admiral',
		['NR1'] = 'Snake Man', ['NR2'] = 'Blossom', ['NR3'] = 'Black Crow', ['NRB1'] = 'Snake Man', ['NRB2'] = 'Blossom', ['NRB3'] = 'Black Crow',
		['SL1'] = 'Soondoo', ['SL2'] = 'Gonshee', ['SL3'] = 'Daek', ['SL4'] = 'LongIn', ['SL5'] = 'Anders', ['SL6'] = 'Largalgan',
		['SLB1'] = 'Soondoo', ['SLB2'] = 'Gonshee', ['SLB3'] = 'Daek', ['SLB4'] = 'LongIn', ['SLB5'] = 'Anders', ['SLB6'] = 'Largalgan',
		['JJ1'] = 'Red Ant', ['JJ2'] = 'Royal Red Ant', ['JJ3'] = 'Ant Queen', 
		['DB1'] = 'Kame', ['DB2'] = 'Piccolo', ['DB3'] = 'Cell', ['DBB1'] = 'Kame', ['DBB2'] = 'Piccolo', ['DBB3'] = 'Cell',
		['OPM1'] = 'Mumem', ['OPM2'] = 'Genos', ['OPM3'] = 'Tornado', ['OPMB1'] = 'Mumem', ['OPMB2'] = 'Genos', ['OPMB3'] = 'Tornado',  
		['DAM1'] = 'Mantis', ['DAM2'] = 'Aira', ['DAM3'] = 'Momo', ['DAMB1'] = 'Mantis', ['DAMB2'] = 'Aira', ['DAMB3'] = 'Momo',
		['NSL1'] = 'Wuiri', ['NSL2'] = 'Gernnat', ['NSL3'] = 'Chris', ['NSLB1'] = 'Wuiri', ['NSLB2'] = 'Gernnat', ['NSLB3'] = 'Chris',
		['WElf1'] = 'Elf Soldier', ['WElf2'] = 'High Frost', ['WBoss'] = 'Laruda', ['WBoss2'] = 'Snow Monarch', ['WIron'] = 'Metal', ['WBear'] = 'Winter Bear',
		-- Bosses
		['JJ4'] = 'Ant King', ['JinWoo'] = 'Monarch', ['Pain'] = 'Dor', ['Mihalk'] = 'Mifalcon', 
		['Ulquiorra'] = 'Murcielago', ['Julius'] = 'Time King', ['Denji'] = 'Chainsaw', ['Pucci'] = 'Gucci', ['Igris'] = 'Vermillion',
		['Freeza'] = 'Frioo', ['Esil'] = 'Wesil', ['Vulcan'] = 'Magma', ['Metus'] = 'Litch', ['Baran'] = 'White Flame', ['Saitama'] = 'Paitama', ['Okarun'] = 'Tuturum',
		['Chae'] = 'Dae In'
	}
	
	getgenv().winterIgnoreMobs = {
		['Elf Soldier'] = {'WElf1'},
		['High Frost'] = {'WElf2'},
		['Laruda'] = {'WBoss'},
		['Snow Monarch'] = {'WBoss2'}, 
		['Metal'] = {'WIron'},
		['Winter Bear'] = {'WBear'}
	}
	
	local dailyQuests = {
		"DailyTime",
		"DailyEnemy",
		"DailyDungeon",
		"DailyBrute",
		"DailyArise",
	}
	
	local weeklyQuests = {
		"WeeklyArise",
		"WeeklyBrute",
		"WeeklyDungeon",
		"WeeklyEnemy",
		"WeeklyTime"
	}
	
	_G.worldSpawns = {
		SoloWorld = CFrame.new(577.96826171875, 24.96237564086914, 261.4522705078125),
		NarutoWorld = CFrame.new(-3380.2373046875, 26.826528549194336, 2257.261962890625), 
		OPWorld = CFrame.new(-2851.106201171875, 46.89878845214844, -2011.395263671875),
		BleachWorld = CFrame.new(2641.795166015625, 42.92652893066406, -2645.07568359375),
		BCWorld = CFrame.new(198.33868408203125, 36.207679748535156, 4296.109375),
		ChainsawWorld = CFrame.new(199.94813537597656, 33.89651107788086, -4899.25537109375),
		JojoWorld = CFrame.new(4816.31640625, 27.442340850830078, -120.22998046875),
		DBWorld = CFrame.new(-6929.5224609375, 124.94865417480469, -76.53571319580078),
		OPMWorld = CFrame.new(6044.72998046875, 25.593618392944336, 4889.79345703125),
		DanWorld = CFrame.new(-4390.06689453125, 21.47457504272461, 5974.93017578125),
		Solo2World = CFrame.new(5739.34228515625, 25.551280975341797, -6356.45751953125)
	}
	
	local uniqueEnemyBaseNamesForDropdown = {}
	local tempNameSetDropdown = {}
	for id, name in pairs(getgenv().enemyIdMap or {}) do
		if not tempNameSetDropdown[name] then
			tempNameSetDropdown[name] = true
			table.insert(uniqueEnemyBaseNamesForDropdown, name)
		end
	end
	table.sort(uniqueEnemyBaseNamesForDropdown)
	getgenv().enemyBaseNamesForDropdown = uniqueEnemyBaseNamesForDropdown
	
	local function getPlayerRoot()
		return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	end
	
	_G.hasFreePet = function()
		local pf = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Pets") and workspace.__Main.__Pets:FindFirstChild(player.UserId)
		if pf then
			for _, p in pairs(pf:GetChildren()) do
				if p and (not p:GetAttribute("Target") or p:GetAttribute("Target") == nil) then
					return true
				end
			end
		end
		return false
	end
	
	_G.AttackEnemy = function(enemyId)
		local args = {
			[1] = {
				[1] = {
					["PetPos"] = {},
					["AttackType"] = "All",
					["Event"] = "Attack",
					["Enemy"] = enemyId
				},
				[2] = ""
			}
		}
		args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\005"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	_G.IsInDungeon = function()
		local world = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__World")
		if not world then
			return false
		end
		for _, child in pairs(world:GetChildren()) do
			if child:IsA("Model") and string.find(child.Name, "Room") then
				return true
			end
		end
		return false
	end
	
	_G.IsInCastle = function()
		local success, result = pcall(function()
			local playerGui = player:FindFirstChild("PlayerGui")
			local Hud = playerGui and playerGui:FindFirstChild("Hud")
			local UpContainer = Hud and Hud:FindFirstChild("UpContanier")
			local roomLabel = UpContainer and UpContainer:FindFirstChild("Room")
	
			if roomLabel then
				return string.find(string.lower(roomLabel.Text), "floor") ~= nil
			end
			return false
		end)
	
		return success and result or false
	end
	
	_G.MoveToEnemy = function(targetPosition, mode, speedOrDuration, addOffset)
		local player = game.Players.LocalPlayer
		local root = getPlayerRoot()
		if not root or not player then return end
	
		local mainFolder = workspace:FindFirstChild("__Main")
		if not mainFolder then return end
	
		local playersFolder = mainFolder:FindFirstChild("__Players")
		local allPetsFolder = mainFolder:FindFirstChild("__Pets")
		if not playersFolder or not allPetsFolder then return end
	
		local playerModel = playersFolder:FindFirstChild(player.Name)
		local petsFolder = allPetsFolder:FindFirstChild(tostring(player.UserId))
	
		local finalPosition = targetPosition
		if addOffset == nil or addOffset == true then
			finalPosition = targetPosition + Vector3.new(4, 2, 0)
		end
		local targetCFrame = CFrame.new(finalPosition)
	
		if mode == "Teleport" or mode == "Fast" then
			if playerModel then playerModel:SetAttribute("InTp", true) end
			root.CFrame = targetCFrame
		elseif mode == "Tween" then
			if playerModel then playerModel:SetAttribute("InTp", true) end
			local duration = tonumber(speedOrDuration) or 150
			duration = math.max(0.1, duration / 1000)
			local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
			local goal = { CFrame = targetCFrame }
			local tween = TweenService:Create(root, tweenInfo, goal)
			root.Anchored = true
			tween:Play()
			tween.Completed:Wait()
			root.Anchored = false
		else
			if playerModel then playerModel:SetAttribute("InTp", true) end
			root.CFrame = targetCFrame
		end
	
		if petsFolder then
			local children = petsFolder:GetChildren()
			local totalPets = #children
			if totalPets == 0 then return end
	
			local playerScale = 1
			if root.Parent then
				 local scaleSuccess, scaleResult = pcall(function() return root.Parent:GetScale() end)
				 if scaleSuccess then
					 playerScale = scaleResult
				 end
			end
	
			for index, pet in ipairs(children) do
				local angleDegrees = index / totalPets * 360 - 180
				local radiusMultiplier = (math.floor(totalPets / 10) + 4) * math.max(playerScale / (1 + (0.3) * (playerScale / 2)), 1)
				local offsetVector = (root.CFrame.RightVector * math.sin(math.rad(angleDegrees)) + root.CFrame.LookVector * -math.cos(math.rad(angleDegrees))) * radiusMultiplier
				local petPosition = root.Position + offsetVector
	
				local targetPetCFrame = CFrame.new(petPosition)
	
				pcall(function()
					local petRoot = pet:FindFirstChild("HumanoidRootPart", true)
					if petRoot and petRoot:IsA("BasePart") then
						petRoot.CFrame = targetPetCFrame
					end
				end)
			end
		end
	end
	
	
	_G.StepTeleport = function(targetPosition)
		-- Get root dynamically
		local humanoidRootPart = getPlayerRoot() -- Use the helper function
		if not humanoidRootPart then
			Rayfield:Notify({ Title = "Error", Content = "StepTeleport: Character not loaded!", Duration = 2, Image="alert-circle" })
			return nil -- Return nil if no root
		end
	
		local playerObject = workspace.__Main.__Players:FindFirstChild(player.Name)
		if not playerObject then
			 Rayfield:Notify({ Title = "Error", Content = "StepTeleport: Player object not found!", Duration = 2, Image="alert-circle" })
			return nil -- Return nil if no player object
		end
	
		local originalInTp = playerObject:GetAttribute("InTp")
		-- Ensure attribute exists before trying to restore it later
		if originalInTp == nil then
			playerObject:SetAttribute("InTp", false)
			originalInTp = false
		end
		playerObject:SetAttribute("InTp", true)
	
		humanoidRootPart.Anchored = true
		local targetCFrame = CFrame.new(targetPosition + Vector3.new(4, 2, 0)) -- Apply offset here if needed for StepTeleport
		humanoidRootPart.CFrame = targetCFrame
	
		local maxWaitTime = 2
		local waitStart = tick()
		local groundLoaded = false
	
		-- Simplified wait logic (Raycast might not be necessary depending on game)
		task.wait(0.2) -- Small delay often helps
	
		humanoidRootPart.Anchored = false
	
		-- Return the restore function
		return function()
			-- Check if playerObject still exists before setting attribute
			if playerObject and playerObject.Parent then
				playerObject:SetAttribute("InTp", originalInTp)
			end
		end
	end
	
	_G.TeleportTo = function(position)
		local root = getPlayerRoot()
		if not root then
			return 
		end
	
		local targetCFrame = (typeof(position) == "CFrame" and position) or CFrame.new(position)
	
		local playerModel = workspace:WaitForChild("__Main"):WaitForChild("__Players"):WaitForChild(player.Name)
		if not playerModel then
			return
		end
	
		local originalInTp = playerModel:GetAttribute("InTp")
		local hadInTp = originalInTp ~= nil
	
		playerModel:SetAttribute("InTp", true)
	
		local restoreInTp = _G.StepTeleport(targetCFrame.Position)
	
		root.CFrame = targetCFrame
	
		if hadInTp then
			playerModel:SetAttribute("InTp", originalInTp)
		else
			playerModel:SetAttribute("InTp", nil)
		end
	
		if restoreInTp then
			pcall(restoreInTp)
		end
	end
	
	_G.FindNearestWorld = function(islandCFrame)
		local nearestWorld = nil
		local minDistance = math.huge
		for worldName, spawnCFrame in pairs(_G.worldSpawns) do
			local distance = (islandCFrame.Position - spawnCFrame.Position).Magnitude
			if distance < minDistance then
				minDistance = distance
				nearestWorld = worldName
			end
		end
		return nearestWorld
	end
	
	local function getCurrentWorld()
		local r = getPlayerRoot()
		if not r then return nil end
		local p = r.Position
		local n = nil
		local m = math.huge
		for w, s in pairs(_G.worldSpawns) do
			local d = (p - s.Position).Magnitude
			if d < m then
				m = d
				n = w
			end
		end
		return n
	end
	
	_G.RedeemDailyQuest = function(quest)
		local args = {
			{
				{
					Id = quest,
					Type = "Daily",
					Event = "ClaimQuest"
				},
				"\010"
			}
		}
		dataRemoteEvent:FireServer(unpack(args))
	end
	
	_G.RedeemWeeklyQuest = function(quest)
		local args = {
			{
				{
					Id = quest,
					Type = "Weekly",
					Event = "ClaimQuest"
				},
				"\010"
			}
		}
		dataRemoteEvent:FireServer(unpack(args))
	end
	
	-- endofdef
	
	local Window = Rayfield:CreateWindow({
		Name = "Arise Crossover - twvz",
		LoadingTitle = "Arise Crossover",
		LoadingSubtitle = "by twvz",
		Theme = "DarkBlue",
		Icon = "loader",
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "AriseRayfieldTest",
			FileName = "AutofarmConfig"
		},
		KeySystem = false
	})
	
	local Tab_Infos = Window:CreateTab("Infos")
	Tab_Infos:CreateSection("Infos")
	
	Tab_Infos:CreateLabel("Important!", "info")
	Tab_Infos:CreateParagraph({Title = "Read me!", Content = "This script has automatic saving of the configs.\nSave your position on Teleport tab."})
	
	local Tab_Main = Window:CreateTab("Main")
	Tab_Main:CreateSection("Farming Options")
	
	_G.Dropdown_World = Tab_Main:CreateDropdown({
		Name = "Select World",
		Options = getgenv().worldList,
		CurrentOption = {getgenv().worldList[1] or "SoloWorld"},
		Flag = "WorldDropdown",
		Callback = function(SelectedWorldTable)
			local SelectedWorld = nil
			if type(SelectedWorldTable) == "table" and #SelectedWorldTable > 0 then
				SelectedWorld = SelectedWorldTable[1]
			else
				warn("[CB] World Error: Invalid data")
				return
			end
			if not _G.Dropdown_Enemy then
				warn("[CB] World Error: Enemy Dropdown nil")
				return
			end
			local newEnemyList = getgenv().enemyList[SelectedWorld] or {}
			local sR, eR = pcall(_G.Dropdown_Enemy.Refresh, _G.Dropdown_Enemy, newEnemyList)
			if not sR then warn("[CB] World Error Refresh:", eR) end
			local sS, eS = pcall(_G.Dropdown_Enemy.Set, _G.Dropdown_Enemy, {})
			if not sS then warn("[CB] World Error Set:", eS) end
		end,
	})
	
	_G.Dropdown_Enemy = Tab_Main:CreateDropdown({
		Name = "Select Enemies",
		Options = getgenv().enemyList[_G.Dropdown_World.CurrentOption[1]] or {},
		CurrentOption = {},
		MultipleOptions = true,
		Flag = "EnemyDropdown",
		Callback = function(_) end
	})
	
	local Dropdown_MobType = Tab_Main:CreateDropdown({
		Name = "Enemy Type",
		Options = {"Normal", "Big"},
		CurrentOption = {"Normal"},
		MultipleOptions = true,
		Flag = "MobTypeDropdown",
		Callback = function(_) end
	})
	
	local Slider_FarmDelay = Tab_Main:CreateSlider({
		Name = "Farm Delay",
		Range = {0, 5},
		Increment = 0.1,
		Suffix = "s",
		CurrentValue = 0.1,
		Flag = "FarmDelaySlider",
		Callback = function(_) end
	})
	
	local Dropdown_MoveMode = Tab_Main:CreateDropdown({
		Name = "Farm Move Mode",
		Options = {"Teleport", "Tween"},
		CurrentOption = {_G.AriseSettings.FarmMoveMode},
		Flag = "FarmMoveModeDropdown",
		Callback = function(Value)
			if type(Value) == "table" and #Value > 0 then
				_G.AriseSettings.FarmMoveMode = Value[1]
			end
		end
	})
	
	local Slider_TweenSpeed = Tab_Main:CreateSlider({
		Name = "Tween Speed/Duration",
		Range = {50, 1000},
		Increment = 10,
		Suffix = " (Higher=Slower)",
		CurrentValue = _G.AriseSettings.FarmTweenSpeed,
		Flag = "FarmTweenSpeedSlider",
		Callback = function(Value)
			_G.AriseSettings.FarmTweenSpeed = Value
		end
	})
	
	Tab_Main:CreateSection("Auto Farm")
	
	_G.Toggle_AutoFarm = Tab_Main:CreateToggle({
		Name = "Auto Farm",
		CurrentValue = false,
		Flag = "AutoFarmToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoFarmToggle = Value
	
			if Value then
				if _G.ActivityPriority == "None" then
					_G.ActivityPriority = "Farming"
				else
					return
				end
	
				spawn(function()
					while _G.Toggle_AutoFarm.CurrentValue do
						local playerRoot = getPlayerRoot()
	
						if not playerRoot then
							task.wait(0.5)
							continue
						end
	
						if _G.ActivityPriority ~= "Farming" then
							task.wait(1)
							continue
						end
	
						local selectedWorldTable = _G.Dropdown_World.CurrentOption
						local selectedWorld = nil
						if type(selectedWorldTable) == "table" and #selectedWorldTable > 0 then
							selectedWorld = selectedWorldTable[1]
						else
							task.wait(2)
							continue
						end
	
						local currentWorld = getCurrentWorld()
						if not currentWorld then
							task.wait(2)
							continue
						end
	
						if currentWorld ~= selectedWorld then
							task.wait(1)
							continue
						end
	
						local selectedEnemiesTable = _G.Dropdown_Enemy.CurrentOption
						local selectedEnemiesLookup = {}
						for _, enemyName in ipairs(selectedEnemiesTable) do selectedEnemiesLookup[enemyName] = true end
	
						local selectedMobTypesTable = Dropdown_MobType.CurrentOption
						local selectedMobTypesLookup = {}
						for _, typeName in ipairs(selectedMobTypesTable) do selectedMobTypesLookup[typeName] = true end
	
						if not next(selectedEnemiesLookup) then
							task.wait(2)
							continue
						end
						 if not next(selectedMobTypesLookup) then
							task.wait(2)
							continue
						end
	
						local worldFolderName = getgenv().worldMap[currentWorld] or "1"
						local mainFolder = workspace:FindFirstChild("__Main")
						local enemiesFolder = mainFolder and mainFolder:FindFirstChild("__Enemies")
						local serverFolder = enemiesFolder and enemiesFolder:FindFirstChild("Server")
						local worldFolder = serverFolder and serverFolder:FindFirstChild(worldFolderName)
	
						if not worldFolder then
							task.wait(1)
							continue
						end
	
						local serverEnemies = worldFolder:GetChildren()
						local nearestEnemyInstance = nil
						local minDistance = math.huge
	
						for _, enemyInstance in ipairs(serverEnemies) do
							if not enemyInstance or not enemyInstance:IsA("BasePart") then continue end
	
							local isDead = enemyInstance:GetAttribute("Dead") or false
							local enemyId = enemyInstance:GetAttribute("Id") or "nil"
	
							if isDead or enemyId == "nil" then continue end
	
							local enemyPosition = enemyInstance.Position
							local distance = (playerRoot.Position - enemyPosition).Magnitude
	
							local enemyIndex = tonumber(string.match(enemyId, "%d+$"))
							local enemyName = "Unknown"
							if enemyIndex and getgenv().enemyList[currentWorld] and getgenv().enemyList[currentWorld][enemyIndex] then
								enemyName = getgenv().enemyList[currentWorld][enemyIndex]
							end
	
							local scale = enemyInstance:GetAttribute("Scale") or 1
							local isBig = scale == 2
							local matchesType = (selectedMobTypesLookup["Normal"] and not isBig) or (selectedMobTypesLookup["Big"] and isBig)
	
							if selectedEnemiesLookup[enemyName] and matchesType then
								if distance < minDistance then
									minDistance = distance
									nearestEnemyInstance = enemyInstance
								end
							end
						end
	
						if nearestEnemyInstance then
							local nearestEnemyPosition = nearestEnemyInstance.Position
							local needsToMove = minDistance > 5
	
							if needsToMove then
								_G.MoveToEnemy(nearestEnemyPosition, _G.AriseSettings.FarmMoveMode, _G.AriseSettings.FarmTweenSpeed, true)
							end
							
							if _G.hasFreePet() then
								_G.AttackEnemy(nearestEnemyInstance.Name)
							end
						end
	
						local delay = Slider_FarmDelay.CurrentValue
						task.wait(delay)
					end
	
					if _G.ActivityPriority == "Farming" then
						_G.ActivityPriority = "None"
					end
					local finalRoot = getPlayerRoot()
					if finalRoot and finalRoot.Anchored then
						finalRoot.Anchored = false
					end
				end)
	
				spawn(function()
					while _G.Toggle_AutoFarm.CurrentValue and _G.ActivityPriority == "Farming" do
					   _G.CloseAnyOpenMenu()
					   task.wait(1)
					end
				end)
	
			else
				if _G.ActivityPriority == "Farming" then
					_G.ActivityPriority = "None"
				end
				local finalRoot = getPlayerRoot()
				if finalRoot and finalRoot.Anchored then
					finalRoot.Anchored = false
				end
			end
		end,
	})
	
	local Slider_AutoClickDelay = Tab_Main:CreateSlider({
		Name = "Auto Click Delay",
		Range = {0, 2},
		Increment = 0.1,
		Suffix = "s",
		CurrentValue = 0,
		Flag = "AutoClickDelaySlider",
		Callback = function(_) end
	})
	
	_G.Toggle_AutoClick = Tab_Main:CreateToggle({
		Name = "Auto Click",
		CurrentValue = false,
		Flag = "AutoClickToggle",
		Callback = function(Value)
			if Value then
				spawn(function()
					while _G.Toggle_AutoClick.CurrentValue do
						local playerRoot = getPlayerRoot()
						local nearestEnemy = nil
						local minDistance = 45
							
							player:SetAttribute("AutoClick", true)
	
							player.leaderstats.Passes:SetAttribute("AutoClicker", true)
							
							if _G.IsInDungeon() then
								local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
								for _, enemy in ipairs(serverEnemies) do
									local isDead = enemy:GetAttribute("Dead") or false
									if not isDead then
										local distance = (playerRoot.Position - enemy.Position).Magnitude
										if distance < minDistance then
											minDistance = distance
											nearestEnemy = enemy
										end
									end
								end
							else
								local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
								for _, enemy in ipairs(serverEnemies) do
									if not enemy:GetAttribute("Dead") and enemy:IsA("BasePart") then
										local distance = (playerRoot.Position - enemy.Position).Magnitude
										if distance < minDistance then
											minDistance = distance
											nearestEnemy = enemy
										end
									end
								end
								
								local currentWorld = getCurrentWorld()
								local worldFolderName = getgenv().worldMap[currentWorld] or "1"
								local worldFolder = workspace.__Main.__Enemies.Server:FindFirstChild(worldFolderName)
								if worldFolder then
									for _, enemy in ipairs(worldFolder:GetChildren()) do
										local isDead = enemy:GetAttribute("Dead") or false
										if not isDead then
											local distance = (playerRoot.Position - enemy.Position).Magnitude
											if distance < minDistance then
												minDistance = distance
												nearestEnemy = enemy
											end
										end
									end
								end
							end
							
							
							if nearestEnemy then
								local args = {
									[1] = {
										[1] = {
											["Event"] = "PunchAttack",
											["Enemy"] = nearestEnemy.Name
										},
										[2] = "\004"
									}
								}
								game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
							end
							
						task.wait(Slider_AutoClickDelay.CurrentValue)
					end
				end)
			end
		end,
	})
	
	Tab_Main:CreateSection("Filtered Action Options")
	
	task.wait()
	
	_G.Dropdown_AriseEnemies = Tab_Main:CreateDropdown({
		Name = "Arise",
		Options = getgenv().enemyBaseNamesForDropdown or {},
		CurrentOption = {},
		MultipleOptions = true,
		Flag = "AriseEnemiesDropdown",
		Callback = function(_) end
	})
	
	task.wait()
	
	_G.Dropdown_AriseEnemyTypes = Tab_Main:CreateDropdown({
		Name = "Arise - Sizes",
		Options = {"Normal", "Big"},
		CurrentOption = {"Normal", "Big"},
		MultipleOptions = true,
		Flag = "AriseEnemyTypesDropdown",
		Callback = function(_) end
	})
	
	task.wait()
	
	_G.Dropdown_DestroyEnemies = Tab_Main:CreateDropdown({
		Name = "Destroy",
		Options = getgenv().enemyBaseNamesForDropdown or {},
		CurrentOption = {},
		MultipleOptions = true,
		Flag = "DestroyEnemiesDropdown",
		Callback = function(_) end
	})
	
	task.wait()
	
	_G.Dropdown_DestroyEnemyTypes = Tab_Main:CreateDropdown({
		Name = "Destroy - Sizes",
		Options = {"Normal", "Big"},
		CurrentOption = {"Normal", "Big"},
		MultipleOptions = true,
		Flag = "DestroyEnemyTypesDropdown",
		Callback = function(_) end
	})
	
	task.wait()
	
	_G.Toggle_Action = Tab_Main:CreateToggle({
		Name = "Activate Filtered Action",
		CurrentValue = false,
		Flag = "ActionToggle",
		Callback = function(Value)
			if Value then
				if _G.Toggle_SimpleAction and _G.Toggle_SimpleAction.CurrentValue then
					_G.Toggle_SimpleAction:Set(false)
					Rayfield:Notify({
						Title = "Warning",
						Content = "Simple Action cannot be used with Filtered Action",
						Duration = 3,
						Image = "alert-triangle"
					})
					return
				end
				spawn(function()
					local deadEnemies = {}
	
					local function updateDeadEnemies()
						deadEnemies = {}
						local clientEnemies = workspace.__Main.__Enemies.Client:GetChildren()
						for _, enemy in ipairs(clientEnemies) do
							local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
							if humanoidRootPart and (humanoidRootPart:FindFirstChild("ArisePrompt") or humanoidRootPart:FindFirstChild("DestroyPrompt")) then
								if enemy.Parent then
									deadEnemies[enemy.Name] = enemy
								end
							end
						end
					end
	
					while _G.Toggle_Action.CurrentValue do    
						updateDeadEnemies()
						local playerRoot = getPlayerRoot()
						if not playerRoot then
							task.wait(0.5)
							continue
						end
	
						if next(deadEnemies) then
							local nearestEnemy = nil
							local minDistance = math.huge
	
							for enemyName, enemyInstance in pairs(deadEnemies) do
								local enemyRoot = enemyInstance:FindFirstChild("HumanoidRootPart")
								if enemyRoot and enemyInstance.Parent then
									local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
									if distance < minDistance then
										minDistance = distance
										nearestEnemy = enemyInstance
									end
								else
									deadEnemies[enemyName] = nil
								end
							end
	
							if nearestEnemy then
								local enemyInstanceName = nearestEnemy.Name
								local enemyId = nearestEnemy:GetAttribute("ID")
								local scale = nearestEnemy:GetAttribute("Scale") or 1
								local isBig = (scale >= 2)
								local enemySizeTypeStr = isBig and "Big" or "Normal"
								local readableEnemyName = getgenv().enemyIdMap and getgenv().enemyIdMap[enemyId]
	
								if readableEnemyName then
									local readableNameLower = string.lower(readableEnemyName)
									local ariseEnemies = {}
									for _, name in ipairs(_G.Dropdown_AriseEnemies.CurrentOption) do
										ariseEnemies[name] = true
									end
									local ariseTypes = {}
									for _, typeName in ipairs(_G.Dropdown_AriseEnemyTypes.CurrentOption) do
										ariseTypes[typeName] = true
									end
									local destroyEnemies = {}
									for _, name in ipairs(_G.Dropdown_DestroyEnemies.CurrentOption) do
										destroyEnemies[name] = true
									end
									local destroyTypes = {}
									for _, typeName in ipairs(_G.Dropdown_DestroyEnemyTypes.CurrentOption) do
										destroyTypes[typeName] = true
									end
	
									local argsToSend = nil
	
									if ariseEnemies[readableEnemyName] and ariseTypes[enemySizeTypeStr] then
										argsToSend = { [1] = { [1] = { ["Event"] = "EnemyCapture", ["Enemy"] = enemyInstanceName }, [2] = "\004" } }
									elseif destroyEnemies[readableEnemyName] and destroyTypes[enemySizeTypeStr] then
										argsToSend = { [1] = { [1] = { ["Event"] = "EnemyDestroy", ["Enemy"] = enemyInstanceName }, [2] = "\004" } }
									end
	
									if argsToSend then
										local success, err = pcall(function()
											dataRemoteEvent:FireServer(unpack(argsToSend))
										end)
									end
	
									deadEnemies[enemyInstanceName] = nil
								else
									warn("Could not find readable name for ID:", enemyId)
									deadEnemies[enemyInstanceName] = nil
								end
							end
						end
						task.wait(0.1)
					end
	
					deadEnemies = nil
				end)
			end
		end
	})
	
	task.wait()
	
	Tab_Main:CreateSection("Simple Action Options")
	
	task.wait()
	
	_G.Dropdown_Action = Tab_Main:CreateDropdown({
		Name = "Action",
		Options = {"Arise", "Destroy"},
		CurrentOption = {"Arise"},
		Flag = "ActionDropdown",
		Callback = function(_) end
	})
	
	task.wait()
	
	_G.Toggle_SimpleAction = Tab_Main:CreateToggle({
		Name = "Activate Simple Action",
		CurrentValue = false,
		Flag = "SimpleActionToggle",
		Callback = function(Value)
			if Value then
				if _G.Toggle_Action and _G.Toggle_Action.CurrentValue then
					_G.Toggle_SimpleAction:Set(false)
					Rayfield:Notify({
						Title = "Warning",
						Content = "Filtered Action cannot be used with Simple Action",
						Duration = 3,
						Image = "alert-triangle"
					})
					return
				end 
				spawn(function()
					local connections = {}
					local deadEnemies = {}
					
					local function setupEnemy(enemy)
						local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
						if not humanoidRootPart then return end
						local connection = humanoidRootPart.ChildAdded:Connect(function(child)
							if (child.Name == "ArisePrompt" or child.Name == "DestroyPrompt") and not deadEnemies[enemy.Name] then
								deadEnemies[enemy.Name] = enemy
							end
						end)
						table.insert(connections, connection)
					end
					
					local function updateDeadEnemies()
						deadEnemies = {}
						for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
							local humanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
							if humanoidRootPart and (humanoidRootPart:FindFirstChild("ArisePrompt") or humanoidRootPart:FindFirstChild("DestroyPrompt")) then
								if enemy.Parent then
									deadEnemies[enemy.Name] = enemy
								end
							end
						end
					end
					
					for _, enemy in ipairs(workspace.__Main.__Enemies.Client:GetChildren()) do
						setupEnemy(enemy)
					end
					local childAddedConnection = workspace.__Main.__Enemies.Client.ChildAdded:Connect(setupEnemy)
					table.insert(connections, childAddedConnection)
					
					while _G.Toggle_SimpleAction.CurrentValue do
						updateDeadEnemies()
						local playerRoot = getPlayerRoot()
						if not playerRoot then
							task.wait(0.5)
							continue
						end
	
						if next(deadEnemies) then
							local nearestEnemy = nil
							local minDistance = math.huge
							for enemyName, enemy in pairs(deadEnemies) do
								local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
								if enemyRoot and enemy.Parent then
									local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
									if distance < minDistance then
										minDistance = distance
										nearestEnemy = enemy
									end
								else
									deadEnemies[enemyName] = nil
								end
							end
							if nearestEnemy then
								local enemyName = nearestEnemy.Name
								local enemyHash = enemyName
								local action = _G.Dropdown_Action.CurrentOption[1]
	
								if action == "Arise" then
									local ariseArgs = {
										[1] = {
											[1] = {
												["Event"] = "EnemyCapture",
												["Enemy"] = enemyHash
											},
											[2] = "\004"
										}
									}
									game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(ariseArgs))
								elseif action == "Destroy" then
									local destroyArgs = {
										[1] = {
											[1] = {
												["Event"] = "EnemyDestroy",
												["Enemy"] = enemyHash
											},
											[2] = "\004"
										}
									}
									game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(destroyArgs))
								end
	
								deadEnemies[enemyName] = nil
								task.wait()
							end
						end
						task.wait(0.1)
					end
					
					for _, conn in ipairs(connections) do
						conn:Disconnect()
					end
				end)
			end
		end
	})
	
	task.wait()
	
	Tab_Dungeon = Window:CreateTab("Dungeon")
	
	Tab_Dungeon:CreateSection("Dungeon Options")
	
	local Dropdown_SearchWorlds = Tab_Dungeon:CreateDropdown({
		Name = "Worlds to Search",
		Options = getgenv().worldList,
		MultipleOptions = true,
		CurrentOption = {"BCWorld"},
		Flag = "SearchWorldsDropdown",
		Callback = function(_) end
	})
	
	local Dropdown_DungeonRank = Tab_Dungeon:CreateDropdown({
		Name = "Ranks to Search",
		Options = {"E", "D", "C", "B", "A", "S", "SS"},
		MultipleOptions = true,
		CurrentOption = {"S"},
		Flag = "DungeonRankDropdown",
		Callback = function(_) end
	})
	
	local Slider_DungeonActionDelay = Tab_Dungeon:CreateSlider({
		Name = "Action Delay",
		Range = {0.1, 5},
		Increment = 0.1,
		Suffix = "s",
		CurrentValue = 1,
		Flag = "DungeonActionDelaySlider",
		Callback = function(Value)
			_G.AriseSettings.DungeonActionDelay = Value
		end
	})
	
	local function createDungeon(dungeonId)
		local args = {
			[1] = {
				[1] = {
					["Event"] = "DungeonAction",
					["Action"] = "Create"
				},
				[2] = ""
			}
		}
		args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	local function addRune(dungeonId)
		local selectedRune = _G.Dropdown_DungeonRune.CurrentOption
		local runeString = (type(selectedRune) == "table" and #selectedRune > 0) and selectedRune[1] or ""
		local args = {
			[1] = {
				[1] = {
					["Dungeon"] = player.UserId,
					["Action"] = "AddItems",
					["Slot"] = 1,
					["Event"] = "DungeonAction",
					["Item"] = tostring(runeString)
				},
				[2] = ""
			}
		}
		args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	local function startDungeon(dungeonId)
		local args = {
			[1] = {
				[1] = {
					["Event"] = "DungeonAction",
					["Action"] = "Start"
				},
				[2] = ""
			}
		}
	
		args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	local dungeonRankMap = {
		[1] = "E", [2] = "D", [3] = "C", [4] = "B",
		[5] = "A", [6] = "S", [7] = "SS"
	}
	
	_G.Toggle_AutoDungeon = Tab_Dungeon:CreateToggle({
		Name = "Auto Dungeon",
		CurrentValue = false,
		Flag = "AutoDungeonToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoDungeon = Value
			local playerRoot = getPlayerRoot()
	
			if Value then
				spawn(function()
					local function createLookupTable(optionsList)
						local lookup = {}
						if type(optionsList) == "table" then
							for _, item in ipairs(optionsList) do
								lookup[item] = true
							end
						end
						return lookup
					end
	
					local function searchForDungeonFast(selectedWorldsLookup, selectedRanksLookup)
						local foundDungeon = false
						local foundDungeonWorld = nil
						local foundDungeonInstance = nil
						local checkedWorlds = {}
	
						local preferredWorld = _G.AriseSettings.PreferredDungeonWorld
	
						if preferredWorld and selectedWorldsLookup[preferredWorld] then
							if _G.ActivityPriority == "Raiding" then
								 checkedWorlds[preferredWorld] = true
							else
								checkedWorlds[preferredWorld] = true
								local restoreInTp = _G.StepTeleport(_G.worldSpawns[preferredWorld].Position)
								task.wait(_G.AriseSettings.DungeonActionDelay or 1)
	
								local dungeonInstance = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
								if dungeonInstance then
									local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
									local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
									local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
	
									if dungeonWorldAttr == preferredWorld and selectedRanksLookup[rankName] then
										foundDungeon = true
										foundDungeonWorld = preferredWorld
										foundDungeonInstance = dungeonInstance
									end
								end
								if restoreInTp then pcall(restoreInTp) end
							end
						end
	
						if not foundDungeon then
							for worldName, isSelected in pairs(selectedWorldsLookup) do
								if not _G.Toggle_AutoDungeon.CurrentValue then break end
								if isSelected and not checkedWorlds[worldName] then
									if _G.ActivityPriority == "Raiding" then
									else
										checkedWorlds[worldName] = true
										local restoreInTp = _G.StepTeleport(_G.worldSpawns[worldName].Position)
										task.wait(_G.AriseSettings.DungeonActionDelay or 1)
	
										local dungeonInstance = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
										if dungeonInstance then
											local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
											local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
											local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
	
											if dungeonWorldAttr == worldName and selectedRanksLookup[rankName] then
												foundDungeon = true
												foundDungeonWorld = worldName
												foundDungeonInstance = dungeonInstance
												_G.AriseSettings.PreferredDungeonWorld = worldName
											end
										end
										if restoreInTp then pcall(restoreInTp) end
										if foundDungeon then break end
									end
								end
							end
						end
						return foundDungeon, foundDungeonWorld, foundDungeonInstance
					end
	
					while _G.Toggle_AutoDungeon.CurrentValue do
						if _G.IsInDungeon() then
							break
						end
	
						playerRoot = getPlayerRoot()
						if not playerRoot then
							Rayfield:Notify({ Title = "Error", Content = "Player character not loaded!", Duration = 3, Image="alert-circle" })
							task.wait(5)
							continue
						end
	
						if _G.ActivityPriority == "Raiding" then
							task.wait(5)
							continue
						end
	
						local currentTime = os.date("*t")
						local minutes = currentTime.min
						local seconds = currentTime.sec
	
						local isActiveWindow = (minutes % 15 < 14) or (minutes % 15 == 14 and seconds < 59)
	
						if isActiveWindow then
							local selectedWorldsLookup = createLookupTable(Dropdown_SearchWorlds.CurrentOption)
							local selectedRanksLookup = createLookupTable(Dropdown_DungeonRank.CurrentOption)
	
							if not next(selectedWorldsLookup) then
								Rayfield:Notify({ Title = "Error", Content = "No worlds selected to search!", Duration = 5, Image="alert-triangle" })
								task.wait(5); continue
							end
							if not next(selectedRanksLookup) then
								Rayfield:Notify({ Title = "Error", Content = "No ranks selected!", Duration = 5, Image="alert-triangle" })
								task.wait(5); continue
							end
	
							local currentWorld = getCurrentWorld()
							local foundAndEntered = false
	
							if currentWorld and selectedWorldsLookup[currentWorld] then
								local dungeon = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Dungeon") and workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
								if dungeon then
									local dungeonWorldAttr = dungeon:GetAttribute("Dungeon")
									local dungeonRankAttr = dungeon:GetAttribute("DungeonRank")
									local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
	
									if dungeonWorldAttr == currentWorld and selectedRanksLookup[rankName] then
										pcall(createDungeon)
										task.wait(0.2)
										if _G.Toggle_DungeonRune.CurrentValue then
											pcall(addRune)
										end
										task.wait(0.2)
										pcall(startDungeon)
										foundAndEntered = true
										break
									end
								end
							end
	
							if not foundAndEntered then
								local foundDungeon, foundDungeonWorld, foundDungeonInstance = searchForDungeonFast(selectedWorldsLookup, selectedRanksLookup)
	
								if foundDungeon and foundDungeonInstance then
									local foundRankName = dungeonRankMap[foundDungeonInstance:GetAttribute("DungeonRank")] or "??"
									if getCurrentWorld() ~= foundDungeonWorld then
										 local restore = _G.StepTeleport(_G.worldSpawns[foundDungeonWorld].Position)
										 task.wait(_G.AriseSettings.DungeonActionDelay or 1)
										 if restore then pcall(restore) end
									end
									pcall(createDungeon)
									task.wait(0.2)
									if _G.Toggle_DungeonRune.CurrentValue then
										pcall(addRune)
									end
									task.wait(0.2)
									pcall(startDungeon)
									foundAndEntered = true
									break
								end
							end
	
							if not foundAndEntered then
								local waitSeconds = 0
								local targetMinute = (math.floor(minutes / 15) * 15 + 14)
								local targetHour = currentTime.hour
	
								waitSeconds = (targetMinute - minutes) * 60 + (59 - seconds)
								if waitSeconds < 0 then
									targetMinute = (math.floor(minutes / 15) + 1) * 15 + 14
									if targetMinute >= 60 then targetMinute = 14; targetHour = (targetHour + 1) % 24 end
									waitSeconds = (targetMinute - minutes + (targetMinute < minutes and 60 or 0)) * 60 + (59 - seconds)
								end
								waitSeconds = math.max(1, waitSeconds)
	
								local targetDisplayMinute = (targetMinute + 1) % 60
								local targetDisplayHour = targetHour
								if targetMinute == 59 then targetDisplayHour = (targetHour + 1) % 24 end
	
								Rayfield:Notify({ Title = "Auto Dungeon", Content = "No suitable dungeon. Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetDisplayHour, targetDisplayMinute) .. "", Duration = 5, Image="timer" })
	
								if _G.Toggle_AutoFarm and _G.Toggle_AutoFarm.CurrentValue then
									if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
									if _G.SavedFarmPosition then
										local currentCheckWorld = getCurrentWorld()
										local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
										if currentCheckWorld ~= targetWorld then
											_G.TeleportTo(_G.SavedFarmPosition)
											task.wait(0.5)
											local currentRoot = getPlayerRoot()
											if currentRoot then currentRoot.Anchored = false end
										end
									end
								end
	
								local waitEndTime = tick() + waitSeconds
								while tick() < waitEndTime and _G.Toggle_AutoDungeon.CurrentValue do
									task.wait(1)
								end
							end
						else
							local waitSeconds = 60 - seconds
							local targetMinute = (minutes + 1) % 60
							local targetHour = currentTime.hour
							if minutes == 59 then targetHour = (targetHour + 1) % 24 end
	
							Rayfield:Notify({ Title = "Auto Dungeon Paused", Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetHour, targetMinute) .. "", Duration = 5, Image="pause-circle" })
	
							if _G.Toggle_AutoFarm and _G.Toggle_AutoFarm.CurrentValue then
								 if _G.ActivityPriority == "None" then _G.ActivityPriority = "Farming" end
								 if _G.SavedFarmPosition then
									 local currentCheckWorld = getCurrentWorld()
									 local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
									 if currentCheckWorld ~= targetWorld then
										 _G.TeleportTo(_G.SavedFarmPosition)
										 task.wait(0.5)
										 local currentRoot = getPlayerRoot()
										 if currentRoot then currentRoot.Anchored = false end
									 end
								 end
							end
	
							local waitEndTime = tick() + waitSeconds
							while tick() < waitEndTime and _G.Toggle_AutoDungeon.CurrentValue do
								task.wait(1)
							end
						end
	
						task.wait(0.1)
					end
	
					playerRoot = getPlayerRoot()
					if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
	
				end)
			else
				playerRoot = getPlayerRoot()
				if playerRoot and playerRoot.Anchored then
					playerRoot.Anchored = false
				end
			end
		end
	})
	
	Tab_Dungeon:CreateSection("Dungeon Rune Options")
	
	local DgRunes = {
		"DgTimeRune",
		"DgRoomRune",
		"DgMoreRoomRune",
		"DgCashRune",
		"DgGemsRune",
		"DgHealthRune",
		"DgRankUpRune",
		"DgURankUpRune",
		"DgRankDownRune",
		"DgSoloRune",
		"DgNarutoRune",
		"DgOPRune",
		"DgBleachRune",
		"DgBCRune",
		"DgChainsawRune",
		"DgJojoRune",
		"DgDbRune",
		"DgOPMRune",
		"DgDanRune",
		"DgSolo2Rune",
		"DgDoubleDungeonRune"
	}
	
	_G.Dropdown_DungeonRune = Tab_Dungeon:CreateDropdown({
		Name = "Choose Dungeon Rune",
		Options = DgRunes,
		MultipleOptions = false,
		CurrentOption = {DgRunes[1] or "None"},
		Flag = "DungeonRuneDropdown",
		Callback = function(_) end
	})
	
	_G.Toggle_DungeonRune = Tab_Dungeon:CreateToggle({
		Name = "Use Rune",
		CurrentValue = false,
		Flag = "DungeonRuneToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.DungeonRune = Value
		end
	})
	
	_G.Toggle_DungeonRuneOnRejoin = Tab_Dungeon:CreateToggle({
		Name = "Use Rune On Auto Rejoin",
		CurrentValue = false,
		Flag = "DungeonRuneOnRejoinToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.DungeonRuneOnRejoin = Value
		end
	})
	
	Tab_Dungeon:CreateSection("Dungeon Settings")
	
	local function resetDungeon()
		local args = {
			[1] = {
				[1] = {
					["Type"] = "Gems",
					["Event"] = "DungeonAction",
					["Action"] = "BuyTicket"
				},
				[2] = ""
			}
		}
		args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	local Toggle_AutoResetDungeon = Tab_Dungeon:CreateToggle({
		Name = "Auto Reset Dungeon",
		CurrentValue = false,
		Flag = "AutoResetDungeonToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoResetDungeon = Value
			if Value then
				pcall(resetDungeon)
			end
		end
	})
	
	_G.Toggle_LeaveFast = Tab_Dungeon:CreateToggle({
		Name = "Leave Fast",
		CurrentValue = false,
		Flag = "LeaveFastToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.LeaveFastToggle = Value
		end
	})
	
	_G.Toggle_AutoRejoinDungeon = Tab_Dungeon:CreateToggle({
		Name = "Auto Rejoin",
		CurrentValue = false,
		Flag = "AutoRejoinDungeonToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoRejoinDungeon = Value
		end
	})
	
	Tab_Dungeon:CreateSection("Dungeon Farm")
	
	local Dropdown_DungeonMoveMode = Tab_Dungeon:CreateDropdown({
		Name = "Move Mode",
		Options = {"Tween", "Teleport"},
		CurrentOption = {"Teleport"},
		Flag = "DungeonMoveModeDropdown",
		Callback = function(Value)
			if type(Value) == "table" and #Value > 0 then
				_G.AriseSettings.DungeonMoveMode = Value[1]
			end
		end
	})
	
	local Slider_DungeonFarmTweenSpeed = Tab_Dungeon:CreateSlider({
		Name = "Tween Speed",
		Range = {100, 1000},
		Increment = 10,
		Suffix = " (Higher=Slower)",
		CurrentValue = 150,
		Flag = "DungeonFarmTweenSpeedSlider",
		Callback = function(Value)
			_G.AriseSettings.DungeonFarmTweenSpeed = Value
		end
	})
	
	local Slider_DungeonFarmDelay = Tab_Dungeon:CreateSlider({
		Name = "Dungeon Farm Delay",
		Range = {0, 5},
		Increment = 0.1,
		Suffix = "s (No kick >= 0.7)",
		CurrentValue = 0.1,
		Flag = "DungeonFarmDelaySlider",
		Callback = function(Value)
			_G.AriseSettings.DungeonFarmDelay = Value
		end
	})
	
	local GuiService = game:GetService("GuiService")
	
	_G.findLeaveButtonRegion = function()
		local topbar = PlayerGui:FindFirstChild("TopbarStandard")
		if not topbar then return nil end
	
		local rightHolder = topbar:FindFirstChild("Holders") and topbar.Holders:FindFirstChild("Right")
		if not rightHolder then return nil end
	
		for _, widget in ipairs(rightHolder:GetChildren()) do
			local iconLabel = widget:FindFirstChild("IconLabel", true)
	
			if iconLabel and iconLabel.Text == "Leave" then
				local iconButton = widget:FindFirstChild("IconButton")
				local menu = iconButton and iconButton:FindFirstChild("Menu")
				local iconSpot = menu and menu:FindFirstChild("IconSpot")
				local clickRegion = iconSpot and iconSpot:FindFirstChild("ClickRegion")
	
				if clickRegion and clickRegion:IsA("GuiButton") and clickRegion.Selectable then
					 return clickRegion
				elseif iconButton and iconButton:IsA("GuiButton") and iconButton.Selectable then
					 return iconButton
				end
			end
		end
		return nil
	end
	
	_G.executeLeaveSequence = function()
		task.wait(0.5)
	
		if _G.Toggle_LeaveFast.CurrentValue then
			local successLeave, errLeave = pcall(function()
				local leaveButton = _G.findLeaveButtonRegion()
	
				if leaveButton then
					local previousSelection = GuiService.SelectedObject
	
					GuiService.SelectedObject = leaveButton
					task.wait(0.1)
	
					if GuiService.SelectedObject == leaveButton then
						local enterKeyCode = Enum.KeyCode.Return
	
						for i = 1, 3 do
							VirtualInputManager:SendKeyEvent(true, enterKeyCode, false, game)
							task.wait(0.05)
							VirtualInputManager:SendKeyEvent(false, enterKeyCode, false, game)
							task.wait(0.15)
						end
					end
	
					task.wait(0.1)
					GuiService.SelectedObject = previousSelection
	
				else
					 warn("Fast Leave: Button not found")
				end
			end)
	
			if not successLeave then
				warn("Fast Leave Error:", errLeave)
			end
		end
	end
	
	_G.HandleDungeonEnd = function()
		if _G.Toggle_AutoRejoinDungeon.CurrentValue then
	
				local function createDungeonLocal(dungeonId)
					local args = {
						[1] = {
							[1] = {
								["Event"] = "DungeonAction",
								["Action"] = "Create"
							},
							[2] = "\v"
						}
					}
					if dungeonId then
						args[1][1]["Dungeon"] = dungeonId
					end
	
					dataRemoteEvent:FireServer(unpack(args))
				end
	
				local function startDungeonLocal(dungeonId)
					if not dungeonId then
						return
					end
	
					local args = {
						[1] = {
							[1] = {
								["Event"] = "DungeonAction",
								["Action"] = "Start",
								["Dungeon"] = dungeonId
							},
							[2] = "\v"
						}
					}
	
					dataRemoteEvent:FireServer(unpack(args))
				end
		
				resetDungeon()
	
				createDungeonLocal()
	
				if _G.Toggle_DungeonRuneOnRejoin.CurrentValue then
					addRune()
				end
	
				task.wait(2)
	
				local testDungeonId = "81654360"
				startDungeonLocal(testDungeonId)
	
		else
			_G.executeLeaveSequence()
		end
	end
	
	local function AreEnemiesAlive()
		local serverFolder = Workspace:FindFirstChild("__Main") and Workspace.__Main:FindFirstChild("__Enemies") and Workspace.__Main.__Enemies:FindFirstChild("Server")
		if not serverFolder then
			return false
		end
	
		local serverEnemies = serverFolder:GetChildren()
		for _, enemySource in ipairs(serverEnemies) do
			if enemySource:IsA("Folder") or enemySource:IsA("Model") then
				for _, enemyInstance in ipairs(enemySource:GetChildren()) do
					if enemyInstance:IsA("BasePart") then
						if not enemyInstance:GetAttribute("Dead") then
							return true
						end
					end
				end
			elseif enemySource:IsA("BasePart") then
				 if not enemySource:GetAttribute("Dead") then
					return true
				end
			end
		end
		return false
	end
	
	_G.Toggle_AutoFarmDungeon = Tab_Dungeon:CreateToggle({
		Name = "Auto Farm Dungeon",
		CurrentValue = false,
		Flag = "AutoFarmDungeonToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoFarmDungeon = Value
			if Value then
				spawn(function()
					local isPotentiallyEnding = false
					local endCheckStartTime = 0
					local hasConfirmedEntry = false
	
					if _G.IsInDungeon() then
						hasConfirmedEntry = true
					else
						return
					end
	
					while _G.Toggle_AutoFarmDungeon.CurrentValue and hasConfirmedEntry do
						if _G.IsInCastle() then
							break
						end
	
						local playerRoot = getPlayerRoot()
						repeat
							task.wait()
						until playerRoot
	
						local enemiesAlive = AreEnemiesAlive()
	
						if enemiesAlive then
							isPotentiallyEnding = false
	
							local serverFolder = Workspace:FindFirstChild("__Main") and Workspace.__Main:FindFirstChild("__Enemies") and Workspace.__Main.__Enemies:FindFirstChild("Server")
							if serverFolder then
								local serverEnemies = serverFolder:GetChildren()
								local nearestEnemyInstance = nil
								local minDistance = math.huge
	
								for _, enemySource in ipairs(serverEnemies) do
									if enemySource:IsA("Folder") or enemySource:IsA("Model") then
										for _, enemyInstance in ipairs(enemySource:GetChildren()) do
											if enemyInstance and enemyInstance:IsA("BasePart") then
												local isDead = enemyInstance:GetAttribute("Dead") or false
												if not isDead then
													local distance = (playerRoot.Position - enemyInstance.Position).Magnitude
													if distance < minDistance then
														minDistance = distance
														nearestEnemyInstance = enemyInstance
													end
												end
											end
										end
									elseif enemySource:IsA("BasePart") then
										local isDead = enemySource:GetAttribute("Dead") or false
										if not isDead then
											local distance = (playerRoot.Position - enemySource.Position).Magnitude
											if distance < minDistance then
												minDistance = distance
												nearestEnemyInstance = enemySource
											end
										end
									end
								end
	
								if nearestEnemyInstance then
									local nearestEnemyPosition = nearestEnemyInstance.Position
									local needsToMove = minDistance > 5
	
									if needsToMove then
										local moveMode = _G.AriseSettings.DungeonMoveMode or "Teleport"
										local tweenSpeed = _G.AriseSettings.DungeonFarmTweenSpeed or 150
										_G.MoveToEnemy(nearestEnemyPosition, moveMode, tweenSpeed, true)
									end
	
									if _G.hasFreePet and _G.hasFreePet() then
										 if _G.AttackEnemy then
											 _G.AttackEnemy(nearestEnemyInstance.Name)
										 end
									end
								end
							else
								 task.wait(0.5)
							end
						else
							if not isPotentiallyEnding then
								 isPotentiallyEnding = true
								 endCheckStartTime = tick()
							end
	
							if tick() - endCheckStartTime >= 3.5 then
								 if not AreEnemiesAlive() then
									 --Rayfield:Notify({ Title = "Dungeon Farm", Content = "Dungeon ended. Handling end...", Duration = 3, Image="arrow-right-circle" })
									 _G.HandleDungeonEnd()
									 if not _G.IsInDungeon() then
										 hasConfirmedEntry = false 
									 end
									 break
								 else
									 --Rayfield:Notify({ Title = "Double Dungeon", Content = "Continuing farm...", Duration = 3, Image="check-circle" })
									 isPotentiallyEnding = false
								 end
							end
						end
	
						local delay = Slider_DungeonFarmDelay.CurrentValue or 0.1
						task.wait(delay)
					end
	
					playerRoot = getPlayerRoot()
					if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
				end)
			else
				playerRoot = getPlayerRoot()
				if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
			end
		end,
	})
	
		Tab_Dungeon:CreateSection("Bypass")
	
		Tab_Dungeon:CreateButton({
			Name = "Bypass",
			Callback = function()
	
					local ReplicatedStorage = game:GetService("ReplicatedStorage")
					local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
		
					local function createDungeonLocal(dungeonId)
						local args = {
							[1] = {
								[1] = {
									["Event"] = "DungeonAction",
									["Action"] = "Create"
								},
								[2] = "\v"
							}
						}
						if dungeonId then
							args[1][1]["Dungeon"] = dungeonId
						end
		
						local success, err = pcall(function()
							dataRemoteEvent:FireServer(unpack(args))
						end)
		
						if not success then
						end
					end
			
						local function startDungeonLocal(dungeonId)
							if not dungeonId then
								return
							end
			
							local args = {
								[1] = {
									[1] = {
										["Event"] = "DungeonAction",
										["Action"] = "Start",
										["Dungeon"] = dungeonId
									},
									[2] = "\v"
								}
							}
			
							local success, err = pcall(function()
								dataRemoteEvent:FireServer(unpack(args))
							end)
			
							if not success then
							end
						end
					
						resetDungeon()
			
						createDungeonLocal()
			
						task.wait(2)
			
						local testDungeonId = "81654360"
						startDungeonLocal(testDungeonId)
			
			end,
		})
	
	
	local Tab_Castle = Window:CreateTab("Castle")
	
	-- == Castle Options Section ==
	Tab_Castle:CreateSection("Castle Options")
	
	_G.Dropdown_CastleCheckpoint = Tab_Castle:CreateDropdown({
		Name = "Choose Checkpoint",
		Options = {"None", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"},
		MultipleOptions = false,
		CurrentOption = {"None"},
		Flag = "CastleCheckpointDropdown",
		Callback = function(_) end
	})
	
	_G.Toggle_AutoCastle = Tab_Castle:CreateToggle({
		Name = "Auto Castle",
		CurrentValue = false,
		Flag = "AutoCastleToggle",
		Callback = function(value)
			_G.AriseSettings.Toggles.AutoCastle = value
			if value then
				spawn(function()
					while _G.Toggle_AutoCastle.CurrentValue do
	
						if _G.IsInCastle() or _G.IsInDungeon() then
							break
						end
	
						if _G.ActivityPriority == "Dungeon" then
							task.wait(5)
							continue
						end
	
						local currentTime = os.date("*t")
						local minutes = currentTime.min
						local seconds = currentTime.sec
						local isActiveWindow = minutes >= 45
	
						if isActiveWindow then
							if _G.ActivityPriority == "Farming" or _G.ActivityPriority == "None" then
								_G.ActivityPriority = "Castle"
							end
	
							if _G.ActivityPriority == "Castle" then
								if _G.Dropdown_CastleCheckpoint.CurrentOption[1] ~= "None" then
									local args = {
										[1] = {
											[1] = {
												["Check"] = true,
												["Floor"] = _G.Dropdown_CastleCheckpoint.CurrentOption[1],
												["Event"] = "CastleAction",
												["Action"] = "Join"
											},
											[2] = "\v"
										}
									}
									dataRemoteEvent:FireServer(unpack(args))
									task.wait(5)
								else
									local args = {
										[1] = {
											[1] = {
												["Check"] = false,
												["Event"] = "CastleAction",
												["Action"] = "Join"
											},
											[2] = "\v"
										}
									}
									dataRemoteEvent:FireServer(unpack(args))
									task.wait(5)
								end
	
							else
								task.wait(1) 
							end
						else
							local waitSeconds = 0
							local targetMinute = 45
							local targetHour = currentTime.hour
	
							waitSeconds = (44 - minutes) * 60 + (60 - seconds)
							if waitSeconds < 0 then 
								 targetHour = (targetHour + 1) % 24
								 waitSeconds = ( (44 + 60) - minutes) * 60 + (60 - seconds)
							end
							waitSeconds = math.max(1, waitSeconds)
	
							local targetTimeString = string.format("%02d:%02d", targetHour, targetMinute)
							Rayfield:Notify({
								Title = "Auto Castle Paused",
								Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. targetTimeString,
								Duration = 5,
								Image = "timer"
							})
	
							if _G.Toggle_AutoFarm.CurrentValue then
								_G.ActivityPriority = "Farming"
							else
								_G.ActivityPriority = "None"
							end
	
							if _G.SavedFarmPosition then
								local currentCheckWorld = getCurrentWorld()
								local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
								if currentCheckWorld ~= targetWorld then
									_G.TeleportTo(_G.SavedFarmPosition)
									task.wait(0.5)
									local currentRoot = getPlayerRoot()
									if currentRoot then currentRoot.Anchored = false end
								end
							end
	
							local waitEndTime = tick() + waitSeconds
							while tick() < waitEndTime and _G.Toggle_AutoCastle.CurrentValue do
								task.wait(1)
							end
						end
						task.wait(0.1)
					end 
	
					if _G.ActivityPriority == "Castle" then
						_G.ActivityPriority = "None"
					end
					local playerRoot = getPlayerRoot()
					if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
				end)
			else
				if _G.ActivityPriority == "Castle" then
					_G.ActivityPriority = "None"
				end
				local playerRoot = getPlayerRoot()
				if playerRoot and playerRoot.Anchored then
					playerRoot.Anchored = false
				end
			end
		end
	})
	
	local function resetCastle()
		local args = {
			[1] = {
				[1] = {
					["Type"] = "Gems",
					["Event"] = "CastleAction",
					["Action"] = "BuyTicket"
				},
				[2] = ""
			}
		}
		args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
	end
	
	local Toggle_AutoResetCastle = Tab_Castle:CreateToggle({
		Name = "Auto Reset Castle (Gems)",
		CurrentValue = false,
		Flag = "AutoResetCastleToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoResetCastle = Value
			if Value then
				pcall(resetCastle)
			end
		end
	})
	
	-- == Castle Settings Section ==
	Tab_Castle:CreateSection("Castle Settings")
	
	local function createFloorList()
		local rooms = {"None"}
		for i = 1, 100 do
			table.insert(rooms, tostring(i))
		end
		return rooms
	end
	
	local Dropdown_CastleFloor = Tab_Castle:CreateDropdown({
		Name = "Choose a Floor",
		Options = createFloorList(),
		MultipleOptions = false,
		CurrentOption = {"None"},
		Flag = "CastleFloorDropdown",
		Callback = function(_) end
	})
	
	local Dropdown_ActionOnFloor = Tab_Castle:CreateDropdown({
		Name = "What to Do",
		Options = {"Leave Castle", "Leave After Boss", "Do Nothing"},
		MultipleOptions = false,
		CurrentOption = {"Do Nothing"},
		Flag = "ActionOnFloorDropdown",
		Callback = function(_) end
	})
	
	-- == Castle Farm Section ==
	Tab_Castle:CreateSection("Castle Farm")
	
	local Dropdown_CastleMoveMode = Tab_Castle:CreateDropdown({
		Name = "Move Mode",
		Options = {"Tween", "Teleport"},
		CurrentOption = {"Tween"},
		Flag = "CastleMoveModeDropdown",
		Callback = function(Value)
			if type(Value) == "table" and #Value > 0 then
				_G.AriseSettings.CastleMoveMode = Value[1]
			end
		end
	})
	
	local Slider_CastleFarmTweenSpeed = Tab_Castle:CreateSlider({
		Name = "Tween Speed",
		Range = {100, 1000},
		Increment = 10,
		Suffix = " (Higher=Slower)",
		CurrentValue = 150,
		Flag = "CastleFarmTweenSpeedSlider",
		Callback = function(Value)
			_G.AriseSettings.CastleTweenSpeed = Value
		end
	})
	
	local Slider_CastleFarmDelay = Tab_Castle:CreateSlider({
		Name = "Castle Farm Delay",
		Range = {0, 5},
		Increment = 0.1,
		Suffix = "s (No kick >= 0.7)",
		CurrentValue = 0.1,
		Flag = "CastleFarmDelaySlider",
		Callback = function(Value)
			_G.AriseSettings.CastleFarmDelay = Value
		end
	})
	
	_G.GetCurrentCastleFloor = function()
		local currentFloor = nil
	
		local playerGui = player:FindFirstChild("PlayerGui")
		local Hud = playerGui and playerGui:FindFirstChild("Hud")
		local UpContainer = Hud and Hud:FindFirstChild("UpContanier")
		local roomLabel = UpContainer and UpContainer:FindFirstChild("Room")
		if roomLabel then
			local floorText = roomLabel.Text
			local floorNumStr = string.match(floorText, "Floor: (%d+)/100")
			if floorNumStr then
				currentFloor = tonumber(floorNumStr)
			end
		end
	
		return currentFloor
	end
	
	_G.leaveCastle = function()
		task.wait(2)
		local successLeave, errLeave = pcall(function()
			local leaveButton = _G.findLeaveButtonRegion()
			if leaveButton then
				local previousSelection = GuiService.SelectedObject
				GuiService.SelectedObject = leaveButton
				task.wait(0.1)
				if GuiService.SelectedObject == leaveButton then
					local enterKeyCode = Enum.KeyCode.Return
					for i = 1, 3 do
						VirtualInputManager:SendKeyEvent(true, enterKeyCode, false, game)
						task.wait(0.05)
						VirtualInputManager:SendKeyEvent(false, enterKeyCode, false, game)
						task.wait(0.15)
					end
				end
				task.wait(0.1)
				GuiService.SelectedObject = previousSelection
			else
				 warn("Fast Leave (Castle): Button not found")
			end
		end)
		if not successLeave then
			warn("Fast Leave Error (Castle):", errLeave)
		end
	end
	
	_G.Toggle_FocusBosses = Tab_Castle:CreateToggle({
		Name = "Focus Bosses",
		CurrentValue = false,
		Flag = "FocusBossesToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.FocusBosses = Value
		end
	})
	
	local teleportedToRoom = false
	_G.Toggle_AutoFarmCastle = Tab_Castle:CreateToggle({
		Name = "Auto Farm Castle",
		CurrentValue = false,
		Flag = "AutoFarmCastleToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoFarmCastle = Value
			if Value then
				task.wait(2)
				spawn(function()
					while _G.Toggle_AutoFarmCastle.CurrentValue do
	
						if not _G.IsInCastle() then
							break
						end
	
						local playerRoot = getPlayerRoot()
						repeat 
							task.wait()
						until playerRoot
	
						local currentFloor = _G.GetCurrentCastleFloor()
						local targetFloorStr = Dropdown_CastleFloor.CurrentOption[1]
						local action = Dropdown_ActionOnFloor.CurrentOption[1]
						local targetFloorNum = tonumber(targetFloorStr)
	
						local mainWorld = workspace.__Main.__World
						local room1 = mainWorld:FindFirstChild("Room_1")
						local firePortal = room1:FindFirstChild("FirePortal")
						if firePortal and not teleportedToRoom then
							task.wait(0.1)
							local room25 = mainWorld:FindFirstChild("Room_25")
							local room50 = mainWorld:FindFirstChild("Room_50")
							if room25 then
								pcall(function()
									_G.MoveToEnemy(room25:GetPivot().Position, "Teleport", Slider_CastleFarmTweenSpeed.CurrentValue, false)
								end)
								task.wait()
								teleportedToRoom = true
								continue
							elseif room50 then
								pcall(function()
									_G.MoveToEnemy(room50:GetPivot().Position, "Teleport", Slider_CastleFarmTweenSpeed.CurrentValue, false)
								end)
								task.wait()
								teleportedToRoom = true
								continue
							end
						end
	
						local serverFolder = workspace:FindFirstChild("__Main") and workspace.__Main:FindFirstChild("__Enemies") and workspace.__Main.__Enemies:FindFirstChild("Server")
						local nearestEnemyInstance = nil
						local minDistance = math.huge
						local nearestBossInstance = nil
						local minBossDistance = math.huge
						local hasAliveServerEnemy = false
						local hasAliveBoss = false
	
						local focusBosses = _G.Toggle_FocusBosses and _G.Toggle_FocusBosses.CurrentValue or false
	
						local function processEnemy(enemyInstance)
							if not enemyInstance or not enemyInstance:IsA("BasePart") then return end
							local isDead = enemyInstance:GetAttribute("Dead") or false
							if not isDead then
								hasAliveServerEnemy = true
								local distance = (playerRoot.Position - enemyInstance.Position).Magnitude
								if distance < minDistance then
									minDistance = distance
									nearestEnemyInstance = enemyInstance
								end
								local scale = enemyInstance:GetAttribute("Scale")
								local isBoss = (type(scale) == "number" and scale >= 2)
								if isBoss then
									hasAliveBoss = true
									if distance < minBossDistance then
										minBossDistance = distance
										nearestBossInstance = enemyInstance
									end
								end
							end
						end
	
						if serverFolder then
							for _, enemySource in ipairs(serverFolder:GetChildren()) do
								if enemySource:IsA("Folder") or enemySource:IsA("Model") then
									for _, enemyInstance in ipairs(enemySource:GetChildren()) do
										processEnemy(enemyInstance)
									end
								elseif enemySource:IsA("BasePart") then
									processEnemy(enemySource)
								end
							end
						end
	
						local finalTargetInstance = nil
						local finalMinDistance = math.huge
						if focusBosses and hasAliveBoss then
							finalTargetInstance = nearestBossInstance
							finalMinDistance = minBossDistance
						elseif hasAliveServerEnemy then
							 finalTargetInstance = nearestEnemyInstance
							 finalMinDistance = minDistance
						end
	
						local performedFloorAction = false
						if targetFloorStr ~= "None" and action ~= "Do Nothing" then
							if currentFloor and targetFloorNum then
								local isOnTargetFloor = (currentFloor == targetFloorNum)
								local canActBasedOnFloor = (currentFloor >= targetFloorNum)
	
								if action == "Leave Castle" and canActBasedOnFloor then
									Rayfield:Notify({ Title = "Auto Farm Castle", Content = "Target floor " .. targetFloorStr .. " reached. Leaving Castle.", Duration = 5, Image="log-out" })
									pcall(_G.leaveCastle)
									task.wait(5)
									performedFloorAction = true
									break
								elseif action == "Leave After Boss" and isOnTargetFloor then
									if targetFloorNum > 0 and targetFloorNum % 5 == 0 then
										local bossIsActuallyAlive = hasAliveBoss
								
										if not bossIsActuallyAlive then
											task.wait(2)
								
											local tempBossFoundOnRescan = false
											if serverFolder and playerRoot then
												for _, enemySource in ipairs(serverFolder:GetChildren()) do
													local enemiesToScan = {}
													if enemySource:IsA("Folder") or enemySource:IsA("Model") then
														enemiesToScan = enemySource:GetChildren()
													elseif enemySource:IsA("BasePart") then
														enemiesToScan = {enemySource}
													end
													for _, enemyInst in ipairs(enemiesToScan) do
														if enemyInst and enemyInst:IsA("BasePart") and not enemyInst:GetAttribute("Dead") then
															local scale = enemyInst:GetAttribute("Scale")
															if type(scale) == "number" and scale >= 2 then
																tempBossFoundOnRescan = true
																break
															end
														end
													end
												end
												if tempBossFoundOnRescan then break end
											end
											bossIsActuallyAlive = tempBossFoundOnRescan
										end
										if not bossIsActuallyAlive then
											Rayfield:Notify({ Title = "Auto Farm Castle", Content = "Boss on floor " .. targetFloorStr .. " defeated or not found. Leaving Castle.", Duration = 5, Image="log-out" })
											pcall(_G.leaveCastle)
											task.wait(5)
											performedFloorAction = true
											break
										end
									end
								end
							end
						end
	
						if not performedFloorAction then
							if not hasAliveServerEnemy and mainWorld then
								local highestRoomNum = 0
								local nextRoom = nil
								for _, room in ipairs(mainWorld:GetChildren()) do
									local roomNum = tonumber(room.Name:match("Room_(%d+)"))
									if roomNum and roomNum > highestRoomNum then
										highestRoomNum = roomNum
										nextRoom = room
									end
								end
								if highestRoomNum > 0 then
									local targetRoomName = "Room_" .. (highestRoomNum + 1)
									local targetRoom = mainWorld:FindFirstChild(targetRoomName)
									if not targetRoom then
										targetRoom = nextRoom
									end
									if targetRoom and targetRoom:GetPivot() then
										pcall(function()
											_G.MoveToEnemy(targetRoom:GetPivot().Position, "Teleport", _G.AriseSettings.CastleTweenSpeed, false)
										end)
										task.wait()
									else
										task.wait(0.5)
									end
								else
									 task.wait(0.5)
								end
							elseif finalTargetInstance then
								local targetPosition = finalTargetInstance.Position
								local needsToMove = finalMinDistance > 10
								if needsToMove then
									local moveMode = Dropdown_CastleMoveMode.CurrentOption[1]
									local tweenSpeed = Slider_CastleFarmTweenSpeed.CurrentValue
									pcall(function()
										_G.MoveToEnemy(targetPosition, moveMode, tweenSpeed, true)
									end)
								end
								if _G.hasFreePet() then
									pcall(function()
										_G.AttackEnemy(finalTargetInstance.Name)
									end)
								end
							else
								task.wait(0.5)
							end
						end
	
						local delay = Slider_CastleFarmDelay.CurrentValue
						task.wait(delay)
	
					end
	
					local playerRootOnExit = getPlayerRoot()
					if playerRootOnExit and playerRootOnExit.Anchored then playerRootOnExit.Anchored = false end
					teleportedToRoom = false
	
				end)
			else
				local playerRootOnDisable = getPlayerRoot()
				if playerRootOnDisable and playerRootOnDisable.Anchored then
					playerRootOnDisable.Anchored = false
				end
			end
		end
	})
	
	getgenv().WINTER_EVENT_POSITION = CFrame.new(4755.9140625, 29.726438522338867, -2026.7510986328125)
	local MIN_DISTANCE_WINTER = 700
	
	-- == Funções Auxiliares ==
	_G.IsInWinterIsland = function()
		local root = getPlayerRoot()
		if not root then return false end
		local playerPosition = root.Position
		local distance = (playerPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude
		-- Usar a constante definida para consistência
		return distance < MIN_DISTANCE_WINTER
	end
	
	-- Helper para obter nome legível (mantido da lógica anterior)
	local function getReadableNameFromInstance(enemyInstance)
		 if not enemyInstance or not enemyInstance:IsA("BasePart") then return nil end
		 local enemyId = enemyInstance:GetAttribute("Id")
		 return getgenv().enemyIdMap and enemyId and getgenv().enemyIdMap[enemyId]
	end
	
	-- Função de ignorar (mantida como no seu script Rayfield, pois usa ipairs corretamente)
	_G.shouldIgnoreWinterMob = function(enemyReadableName)
		if not enemyReadableName then return false end
	
		-- Acessa a lista diretamente das configurações (preenchida pelo callback do dropdown)
		local ignoredMobsList = _G.AriseSettings.WinterIgnoreMobs -- Assume que o callback preenche isso como um array
		if not ignoredMobsList or type(ignoredMobsList) ~= "table" then
			return false
		end
	
		-- Itera sobre o array de nomes ignorados
		for _, ignoredName in ipairs(ignoredMobsList) do
			if ignoredName == enemyReadableName then
				return true -- Encontrou na lista, ignorar
			end
		end
	
		return false -- Não encontrou, não ignorar
	end
	
	
	-- == Configuração da UI Rayfield ==
	local Tab_Winter = Window:CreateTab("Winter")
	
	-- == Seção de Opções ==
	Tab_Winter:CreateSection("Winter Options")
	
	-- Dropdown Move Mode (como no seu script)
	_G.Dropdown_WinterMoveMode = Tab_Winter:CreateDropdown({
		Name = "Winter Move Mode",
		Options = {"Slow", "Fast"},
		CurrentOption = {"Slow"}, -- Mantido default
		Flag = "WinterMoveModeDropdown",
		Callback = function(Value)
			-- Rayfield retorna tabela mesmo para opção única
			if type(Value) == "table" and #Value > 0 then
				_G.AriseSettings.WinterMoveMode = Value[1]
			else
				 _G.AriseSettings.WinterMoveMode = "Slow" -- Fallback
			end
		end
	})
	
	-- Slider Tween Speed (como no seu script)
	_G.Slider_WinterTweenSpeed = Tab_Winter:CreateSlider({
		Name = "Tween Speed",
		Range = {100, 1000},
		Increment = 10,
		Suffix = " (Higher=Slower)",
		CurrentValue = 150,
		Flag = "WinterTweenSpeedSlider",
		Callback = function(Value)
			_G.AriseSettings.WinterTweenSpeed = Value
		end
	})
	
	-- Slider Farm Delay (como no seu script)
	_G.Slider_WinterFarmDelay = Tab_Winter:CreateSlider({
		Name = "Winter Farm Delay",
		Range = {0, 5},
		Increment = 0.1,
		Suffix = "s (No kick >= 0.7)",
		CurrentValue = 0.1,
		Flag = "WinterFarmDelaySlider",
		Callback = function(Value)
			_G.AriseSettings.WinterFarmDelay = Value
		end
	})
	
	-- == Seção de Mobs ==
	Tab_Winter:CreateSection("Winter Mobs")
	
	-- Preparar lista de nomes (como no seu script)
	local winterMobNames = {}
	for mobName, _ in pairs(getgenv().winterIgnoreMobs or {}) do
		table.insert(winterMobNames, mobName)
	end
	table.sort(winterMobNames)
	
	-- Dropdown Ignore Mobs (como no seu script, callback ajustado para garantir tabela)
	_G.Dropdown_WinterIgnoreMobs = Tab_Winter:CreateDropdown({
		Name = "Winter Ignore Mobs",
		Options = winterMobNames,
		CurrentOption = {}, -- Default vazio para multi-seleção
		MultipleOptions = true,
		Flag = "WinterIgnoreMobsDropdown",
		Callback = function(Value)
			-- Value é uma tabela com os selecionados: {"Mob1", "Mob2"}
			if type(Value) == "table" then
				 _G.AriseSettings.WinterIgnoreMobs = Value -- Armazena o array
			else
				 _G.AriseSettings.WinterIgnoreMobs = {} -- Garante que seja sempre uma tabela
			end
		end
	})
	
	_G.HopToServer = function(preferredServerType, maxPlayersAllowed)
		local TPS = game:GetService("TeleportService")
		local Http = game:GetService("HttpService")
		local Api = "https://games.roblox.com/v1/games/"
		local _place = game.PlaceId
		local MAX_PLAYERS = maxPlayersAllowed or 16
		local visitedServers = {}
		local RETRY_DELAY = 5
	
		preferredServerType = preferredServerType or "Empty"
		if preferredServerType ~= "Full" and preferredServerType ~= "Empty" then
			warn("Invalid server type: " .. tostring(preferredServerType) .. ". Defaulting to Empty.")
			preferredServerType = "Empty"
		end
	
		local foundAnything = ""
		local sortOrder = preferredServerType == "Full" and "Desc" or "Asc"
		local _servers = Api .. _place .. "/servers/Public?sortOrder=" .. sortOrder .. "&limit=100"
	
		local function FetchServers()
			local success, response
			if foundAnything == "" then
				success, response = pcall(function()
					return Http:JSONDecode(game:HttpGet(_servers))
				end)
			else
				success, response = pcall(function()
					return Http:JSONDecode(game:HttpGet(_servers .. "&cursor=" .. foundAnything))
				end)
			end
	
			if not success then
				warn("Failed to fetch servers: " .. tostring(response))
				Rayfield:Notify({
					Title = "Server Fetch Error",
					Content = "Failed to get server list: " .. tostring(response) .. ". Retrying in " .. RETRY_DELAY .. "s...",
					Duration = 5
				})
				return nil
			end
	
			local Site = response
			if not Site or type(Site) ~= "table" or not Site.data then
				warn("Invalid or empty API response: " .. tostring(Http:JSONEncode(Site)))
				Rayfield:Notify({
					Title = "Server Fetch Error",
					Content = "Invalid server response. Retrying in " .. RETRY_DELAY .. "s...",
					Duration = 5
				})
				return nil
			end
	
			if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
				foundAnything = Site.nextPageCursor
			end
	
			for _, v in pairs(Site.data) do
				local serverId = tostring(v.id)
				if v.maxPlayers == MAX_PLAYERS and v.playing <= (MAX_PLAYERS - 1) and not visitedServers[serverId] then
					visitedServers[serverId] = true
					Rayfield:Notify({
						Title = "Teleporting to Server",
						Content = "Joining server with " .. v.playing .. "/" .. MAX_PLAYERS .. " players (" .. preferredServerType .. ")...",
						Duration = 3
					})
					local success, err = pcall(function()
						TPS:TeleportToPlaceInstance(_place, serverId, player)
					end)
					if not success then
						warn("Teleport failed - Server: " .. serverId .. ", Error: " .. err)
						Rayfield:Notify({
							Title = "Teleport Failed",
							Content = "Error: " .. err .. ". Trying next server...",
							Duration = 5
						})
					end
					task.wait(4)
					return true
				end
			end
			return false
		end
	
		local attempt = 1
		local maxAttempts = 7
		while attempt <= maxAttempts do
			local success = FetchServers()
			if success then return true end
			if foundAnything == "" then
				Rayfield:Notify({
					Title = "No Suitable Servers",
					Content = "No servers found with < " .. (MAX_PLAYERS - 2) .. " players (" .. preferredServerType .. "). Stopping after " .. attempt .. " attempts.",
					Duration = 5
				})
				break
			end
			attempt = attempt + 1
			task.wait(RETRY_DELAY)
		end
	
		return false
	end
	
	local NOTIFICATION_DEBOUNCE_SECONDS = 8 -- Time between similar notifications
	local HIGH_FROST_APPROX_SPAWN_SECONDS = 85
	local MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW = 8
	local POST_LARUDA_MONARCH_WAIT_SECONDS = 30 -- Specific wait time after Laruda kill
	local TELEPORT_WAIT_TIME = 2.5
	local SERVER_HOP_WAIT_TIME = 20
	
	Tab_Winter:CreateSection("Winter Event Settings")
	
	_G.Toggle_ServerHop = Tab_Winter:CreateToggle({
		Name = "Server Hop",
		CurrentValue = _G.AriseSettings.Toggles.ServerHop or false, -- Load saved value
		Flag = "ServerHopToggleWinter", -- Unique flag
		Callback = function(Value)
			_G.AriseSettings.Toggles.ServerHop = Value
		end
	})
	
	_G.Slider_MonarchWaitTime = Tab_Winter:CreateSlider({
		Name = "Server Hop Delay", -- Corrected Name
		Range = {10, 30}, -- Example range (0 to 90 seconds)
		Increment = 1,
		Suffix = "s",
		CurrentValue = 30, -- Load saved value, default 30s
		Flag = "MonarchWaitTimeSlider", -- Consistent Flag
		Callback = function(Value)
			_G.AriseSettings.MonarchWaitTime = Value
		end
	})
	
	_G.Toggle_AutoWinter = Tab_Winter:CreateToggle({
		Name = "Auto Winter Farm",
		CurrentValue = false,
		Flag = "AutoWinterToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.AutoWinter = Value
			if Value then
				spawn(function()
					local state = {
						previousPriority = _G.ActivityPriority,
						inEventWindow = false,
						bosses = {
							snowMonarchKilled = false,
							larudaKilled = false
						},
						monarchWaitAttempted = false,
						lastMonarchInstance = nil,
						notifications = {
							lastTime = 0,
							history = {}
						},
						cycleCompleted = false
					}
	
					local function notify(title, content, duration, image)
						local currentTime = tick()
						if currentTime - state.notifications.lastTime >= NOTIFICATION_DEBOUNCE_SECONDS or 
						   not table.find(state.notifications.history, content) then
							
							Rayfield:Notify({ 
								Title = title or "Auto Winter", 
								Content = content or "", 
								Duration = duration or 5, 
								Image = image or "info" 
							})
							
							state.notifications.lastTime = currentTime
							table.insert(state.notifications.history, 1, content)
							
							if #state.notifications.history > 3 then 
								table.remove(state.notifications.history) 
							end
						end
					end
	
					local function handleOutsideEventWindow(playerRoot, currentTime)
						if _G.ActivityPriority == "Winter" then
							--notify("Auto Winter", "Event window ended.", 4, "info")
							
							if _G.Toggle_AutoFarm.CurrentValue then
								_G.ActivityPriority = "Farming"
							else
								_G.ActivityPriority = "None"
							end
							
							if _G.SavedFarmPosition then
								_G.TeleportTo(_G.SavedFarmPosition)
								task.wait(TELEPORT_WAIT_TIME)
								playerRoot = getPlayerRoot()
								if playerRoot then playerRoot.Anchored = false end
							end
						end
	
						local minutes, seconds = currentTime.min, currentTime.sec
						local targetMinute, targetHour = 30, currentTime.hour -- Changed 10 to 30
						local waitSeconds = 0
						
						if minutes < 30 then -- Changed 10 to 30
							waitSeconds = (targetMinute - minutes - 1) * 60 + (60 - seconds)
						else
							targetHour = (targetHour + 1) % 24
							waitSeconds = ((targetMinute + 60) - minutes - 1) * 60 + (60 - seconds)
						end
						
						waitSeconds = math.max(1, waitSeconds)
						notify("Auto Winter Paused", 
							  "Waiting " .. math.ceil(waitSeconds) .. "s until " .. 
							  string.format("%02d:%02d", targetHour, targetMinute), 5, "timer")
	
						-- Wait until next window starts
						local waitEndTime = tick() + waitSeconds
						while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
							local now = os.date("*t")
							if (now.min >= 30 and now.min < 45) then break end -- Changed 10 and 25 to 30 and 45
							task.wait(1)
						end
						
						return true -- Handled outside window
					end
	
					-- Handle completed event cycle
					local function handleCompletedCycle(playerRoot, currentTime)
						notify("Auto Winter", "Event cycle completed this window. Waiting.", 5, "info")
						
						if _G.Toggle_AutoFarm.CurrentValue then
							_G.ActivityPriority = "Farming"
						else
							_G.ActivityPriority = "None"
						end
						
						if _G.SavedFarmPosition then
							local distanceToSaved = playerRoot and 
												  (playerRoot.Position - _G.SavedFarmPosition.Position).Magnitude or math.huge
							if distanceToSaved > 1000 then
								_G.TeleportTo(_G.SavedFarmPosition)
								task.wait(TELEPORT_WAIT_TIME)
								playerRoot = getPlayerRoot()
								if playerRoot then playerRoot.Anchored = false end
							end
						end
	
						-- Calculate wait time until window ends
						local minutes, seconds = currentTime.min, currentTime.sec
						local waitSeconds = (45 - minutes - 1) * 60 + (60 - seconds) -- Changed 25 to 45
						waitSeconds = math.max(1, waitSeconds)
						
						notify("Auto Winter", 
							  "Waiting " .. math.ceil(waitSeconds) .. "s until event window ends (xx:45).", 5, "timer") -- Changed xx:25 to xx:45
	
						-- Wait until window ends
						local waitEndTime = tick() + waitSeconds
						while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
							local now = os.date("*t")
							if not (now.min >= 30 and now.min < 45) then break end -- Changed 10 and 25 to 30 and 45
							task.wait(1)
						end
						
						return true -- Handled completed cycle
					end
	
					-- Check and update Monarch status
					local function checkMonarchStatus()
						if not state.lastMonarchInstance or state.bosses.snowMonarchKilled then return end
						
						local monarchStillExists, isDead = false, true
						pcall(function()
							if state.lastMonarchInstance and state.lastMonarchInstance.Parent ~= nil then
								monarchStillExists = true
								isDead = state.lastMonarchInstance:GetAttribute("Dead") or false
							end
						end)
						
						if not monarchStillExists or isDead then
							notify("Auto Winter", "Snow Monarch defeated/despawned.", 4, "success")
							state.bosses.snowMonarchKilled = true
							state.lastMonarchInstance = nil
							state.monarchWaitAttempted = true
						end
					end
	
					-- Find winter enemies and process them
					local function processWinterEnemies(playerRoot)
						local serverFolder = workspace:FindFirstChild("__Main") and 
										   workspace.__Main:FindFirstChild("__Enemies") and 
										   workspace.__Main.__Enemies:FindFirstChild("Server")
										   
						if not serverFolder then 
							notify("Auto Winter Error", "Enemy folder not found.", 5, "error")
							return nil 
						end
	
						local results = {
							nearestEnemy = nil,
							minDistance = MIN_DISTANCE_WINTER + 1,
							aliveCount = 0,
							bosses = {
								highFrost = nil,
								laruda = nil,
								snowMonarch = nil
							}
						}
	
						for _, enemyInstance in ipairs(serverFolder:GetChildren()) do
							if enemyInstance and enemyInstance:IsA("BasePart") and 
							   enemyInstance.Parent == serverFolder then
								
								local isDead = enemyInstance:GetAttribute("Dead") or false
								if not isDead then
									local enemyPosition = enemyInstance.Position
									if (enemyPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude < MIN_DISTANCE_WINTER then
										
										local readableName = getReadableNameFromInstance(enemyInstance)
										local isIgnored = _G.shouldIgnoreWinterMob(readableName)
										
										if not isIgnored then
											results.aliveCount = results.aliveCount + 1
											local distance = (playerRoot.Position - enemyPosition).Magnitude
											
											if readableName == "Snow Monarch" then 
												results.bosses.snowMonarch = enemyInstance
											elseif readableName == "Laruda" then 
												results.bosses.laruda = enemyInstance
											elseif readableName == "High Frost" then 
												results.bosses.highFrost = enemyInstance
											else 
												if distance < results.minDistance then 
													results.minDistance = distance
													results.nearestEnemy = enemyInstance 
												end
											end
										end
									end
								end
							end
						end
						
						return results
					end
	
					-- Determine best target from available enemies
					local function determineTarget(enemies)
						if not enemies then return nil end
						
						-- Priority order: Snow Monarch > Laruda > High Frost > Regular enemies
						if enemies.bosses.snowMonarch and 
						   not _G.shouldIgnoreWinterMob("Snow Monarch") and 
						   not state.bosses.snowMonarchKilled then
							return enemies.bosses.snowMonarch
						elseif enemies.bosses.laruda and 
							   not _G.shouldIgnoreWinterMob("Laruda") and 
							   not state.bosses.larudaKilled then
							return enemies.bosses.laruda
						elseif enemies.bosses.highFrost and 
							   not _G.shouldIgnoreWinterMob("High Frost") then
							return enemies.bosses.highFrost
						elseif enemies.nearestEnemy then
							return enemies.nearestEnemy
						end
						
						return nil
					end
	
					-- Attack target enemy
					local function attackTarget(targetEnemy, playerRoot)
						if not targetEnemy then return false end
						
						local targetName = getReadableNameFromInstance(targetEnemy)
						local targetPosition = targetEnemy.Position
						local distanceToTarget = (playerRoot.Position - targetPosition).Magnitude
						
						-- Move to target if needed
						if distanceToTarget > 15 then
							local moveMode = (_G.Dropdown_WinterMoveMode and 
										   _G.Dropdown_WinterMoveMode.CurrentOption and 
										   _G.Dropdown_WinterMoveMode.CurrentOption[1]) or "Slow"
							local tweenSpeed = (_G.Slider_WinterTweenSpeed and 
											 _G.Slider_WinterTweenSpeed.CurrentValue) or 150
							
							_G.MoveToEnemy(
								targetPosition, 
								moveMode == "Fast" and "Teleport" or "Tween", 
								tweenSpeed, 
								false
							)
							task.wait(0.1)
						end
						
						-- Attack with pet if available
						if _G.hasFreePet() then
							_G.AttackEnemy(targetEnemy.Name)
							
							-- Track boss instances
							if targetName == "Snow Monarch" then 
								state.lastMonarchInstance = targetEnemy
							elseif targetName == "Laruda" then
								-- Check laruda status after a short delay instead of immediate marking
								task.spawn(function()
									task.wait(0.5)
									if targetEnemy and targetEnemy:GetAttribute("Dead") then
										state.bosses.larudaKilled = true
									end
								end)
							end
							
							return true
						else
							task.wait(0.5)
							return false
						end
					end
	
					-- Wait for Monarch to spawn
					local function waitForMonarch(windowStartTime, minutesIntoEvent)
						local monarchWaitSliderValue = _G.Slider_MonarchWaitTime.CurrentValue or 30
						local canWaitForMonarch = not _G.shouldIgnoreWinterMob("Snow Monarch")
						
						if not (state.monarchWaitAttempted or state.bosses.snowMonarchKilled) and 
						   minutesIntoEvent <= MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW and
						   canWaitForMonarch and monarchWaitSliderValue > 0 then
							
							local maxWaitTime, waitReason
							
							if state.bosses.larudaKilled then
								maxWaitTime = POST_LARUDA_MONARCH_WAIT_SECONDS
								waitReason = "post-Laruda"
							else
								maxWaitTime = monarchWaitSliderValue
								waitReason = "slider setting"
							end
							
							notify("Auto Winter", 
								  "Island clear. Waiting up to " .. string.format("%.0f", maxWaitTime) .. 
								  "s for Monarch ("..waitReason..")...", 
								  math.max(5, maxWaitTime), "timer")
								  
							state.monarchWaitAttempted = true
							local waitStart = tick()
							local foundMonarch = false
							
							while tick() - waitStart < maxWaitTime and 
								  _G.Toggle_AutoWinter.CurrentValue and 
								  not state.bosses.snowMonarchKilled do
								
								-- Check for monarch appearance
								local monarchCheckFolder = workspace:FindFirstChild("__Main") and
														workspace.__Main:FindFirstChild("__Enemies") and
														workspace.__Main.__Enemies:FindFirstChild("Server")
														
								if monarchCheckFolder then
									for _, enemy in ipairs(monarchCheckFolder:GetChildren()) do
										if enemy and enemy:IsA("BasePart") and 
										   getReadableNameFromInstance(enemy) == "Snow Monarch" and 
										   not (enemy:GetAttribute("Dead") or false) then
											
											foundMonarch = true
											break
										end
									end
								end
								
								if foundMonarch then
									notify("Auto Winter", "Snow Monarch detected during wait!", 3, "success")
									break
								end
								
								task.wait(1)
							end
							
							return true -- Waited for monarch (regardless of if it appeared)
						end
						
						return false -- Did not wait
					end
	
					-- Handle server hop or wait when done
					local function finishEventCycle(playerRoot)
						state.cycleCompleted = true
						
						if _G.AriseSettings.Toggles.ServerHop then
							notify("Auto Winter", "Event cycle complete. Hopping server...", 5, "loading")
							task.wait(1.5)
							
							-- Attempt hop multiple times
							for i = 1, 3 do
								_G.HopToServer()
								task.wait(15)
							end
							
							notify("Auto Winter", "Server hop initiated. Waiting...", SERVER_HOP_WAIT_TIME, "timer")
							task.wait(SERVER_HOP_WAIT_TIME)
							
							-- Reset state for new server
							state.bosses.snowMonarchKilled = false
							state.bosses.larudaKilled = false
							state.monarchWaitAttempted = false
							state.lastMonarchInstance = nil
							state.cycleCompleted = false
							state.notifications.history = {}
						else
							-- No server hop, wait for window end
							if _G.Toggle_AutoFarm.CurrentValue then
								_G.ActivityPriority = "Farming"
							else
								_G.ActivityPriority = "None"
							end
							
							if _G.SavedFarmPosition then
								local distanceToSaved = playerRoot and 
													 (playerRoot.Position - _G.SavedFarmPosition.Position).Magnitude or math.huge
								if distanceToSaved > 10 then
									_G.TeleportTo(_G.SavedFarmPosition)
									task.wait(TELEPORT_WAIT_TIME)
									playerRoot = getPlayerRoot()
									if playerRoot then playerRoot.Anchored = false end
								end
							end
							
							-- Calculate wait until window end
							local currentTime = os.date("*t")
							local minutes, seconds = currentTime.min, currentTime.sec
							local waitSeconds = (45 - minutes - 1) * 60 + (60 - seconds) -- Changed 25 to 45
							waitSeconds = math.max(1, waitSeconds)
							
							local waitEndTime = tick() + waitSeconds
							while tick() < waitEndTime and _G.Toggle_AutoWinter.CurrentValue do
								local now = os.date("*t")
								if not (now.min >= 30 and now.min < 45) then break end -- Changed 10 and 25 to 30 and 45
								task.wait(1)
							end
						end
						
						return true -- Finished event cycle
					end
	
					-- Handle empty island
					local function handleEmptyIsland(enemies, windowStartTime, minutesIntoEvent)
						if enemies.aliveCount > 0 then return false end
						
						-- Check High Frost early spawn
						if not enemies.bosses.highFrost and 
						   not enemies.bosses.laruda and 
						   not enemies.bosses.snowMonarch and 
						   windowStartTime < HIGH_FROST_APPROX_SPAWN_SECONDS and 
						   not _G.shouldIgnoreWinterMob("High Frost") then
							
							local waitTime = math.max(1, HIGH_FROST_APPROX_SPAWN_SECONDS - windowStartTime)
							notify("Auto Winter", 
								  "Waiting for High Frost (" .. string.format("%.0f", waitTime) .. "s left)...", 
								  math.min(5, waitTime), "timer")
								  
							task.wait(waitTime)
							return true -- Waited for High Frost
						end
						
						-- Try waiting for Monarch if conditions are right
						if waitForMonarch(windowStartTime, minutesIntoEvent) then
							return true -- Waited for Monarch
						end
						
						-- Island clear message
						if state.bosses.snowMonarchKilled then 
							notify("Auto Winter", "Island clear. Monarch already dealt with.", 4, "info")
						elseif state.monarchWaitAttempted then 
							notify("Auto Winter", "Island clear after waiting.", 4, "info")
						elseif (_G.Slider_MonarchWaitTime.CurrentValue or 0) <= 0 then 
							notify("Auto Winter", "Island clear. Monarch wait disabled (slider=0).", 4, "info")
						elseif _G.shouldIgnoreWinterMob("Snow Monarch") then 
							notify("Auto Winter Warning", "Island clear. Cannot wait: Snow Monarch is ignored.", 5, "warning")
						elseif minutesIntoEvent > MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW then 
							notify("Auto Winter", "Island clear. Too late for Monarch spawn.", 4, "info")
						end
						
						finishEventCycle(getPlayerRoot())
						return true
					end
	
					-- Main loop
					while _G.Toggle_AutoWinter.CurrentValue do
						local loopStartTime = tick()
						local playerRoot = getPlayerRoot()
						
						if not playerRoot then 
							task.wait(5)
							continue
						end
						
						if not _G.Toggle_AutoWinter.CurrentValue then break end
						
						local currentTime = os.date("*t")
						local minutes, seconds = currentTime.min, currentTime.sec
						local isEventWindow = (minutes >= 30 and minutes < 45) -- Changed 10 and 25 to 30 and 45
						
						-- Reset state on new window
						if isEventWindow and not state.inEventWindow then
							--notify("Auto Winter", "Event window (30-45) started. Status reset.", 4, "info") -- Changed 10-25 to 30-45
							state.bosses.snowMonarchKilled = false
							state.bosses.larudaKilled = false
							state.monarchWaitAttempted = false
							state.lastMonarchInstance = nil
							state.cycleCompleted = false
							state.notifications.history = {}
						end
						state.inEventWindow = isEventWindow
						
						-- Skip if in dungeon/castle
						if _G.IsInDungeon() or _G.IsInCastle() then
							notify("Auto Winter Paused", "Inside Dungeon/Castle.", 5, "warning")
							if _G.ActivityPriority == "Winter" then 
								_G.ActivityPriority = state.previousPriority or "None" 
							end
							task.wait(5)
							continue
						end
						
						-- Different logic based on event window status
						if not isEventWindow then
							handleOutsideEventWindow(playerRoot, currentTime)
							continue
						end
						
						-- Skip event logic if cycle completed
						if state.cycleCompleted then
							handleCompletedCycle(playerRoot, currentTime)
							continue
						end
						
						-- Set Winter priority
						if _G.ActivityPriority ~= "Winter" then
							state.previousPriority = _G.ActivityPriority
							_G.ActivityPriority = "Winter"
							task.wait(0.1)
						end
						
						-- Teleport to winter island if needed
						if not _G.IsInWinterIsland() then
							notify("Auto Winter", "Teleporting to Winter Island...", 4, "loading")
							_G.TeleportTo(getgenv().WINTER_EVENT_POSITION)
							task.wait(TELEPORT_WAIT_TIME)
							
							playerRoot = getPlayerRoot()
							if not playerRoot then 
								notify("Auto Winter Error", "Player lost after TP.", 5, "error")
								task.wait(5)
								continue
							end
							
							if playerRoot then playerRoot.Anchored = false end
							
							if not _G.IsInWinterIsland() then 
								notify("Auto Winter Error", "Failed TP to Winter Island.", 5, "error")
								task.wait(3)
								continue
							end
						end
						
						-- Winter farm logic
						checkMonarchStatus()
						
						-- Process enemies
						local enemies = processWinterEnemies(playerRoot)
						if not enemies then 
							task.wait(5)
							continue 
						end
						
						-- Calculate event timing info
						local windowStartMinute = 30 -- Changed 10 to 30
						local secondsSinceWindowStart = (minutes - windowStartMinute) * 60 + seconds
						local minutesIntoEvent = secondsSinceWindowStart / 60
						
						-- Try to attack target or handle empty island
						local targetEnemy = determineTarget(enemies)
						
						if targetEnemy then
							state.monarchWaitAttempted = false
							attackTarget(targetEnemy, playerRoot)
						else
							if handleEmptyIsland(enemies, secondsSinceWindowStart, minutesIntoEvent) then
								continue
							end
						end
						
						-- Loop delay
						local delay = (_G.Slider_WinterFarmDelay and _G.Slider_WinterFarmDelay.CurrentValue) or 0.5
						local elapsedTime = tick() - loopStartTime
						if elapsedTime < delay then 
							task.wait(delay - elapsedTime) 
						else 
							task.wait() 
						end
					end
					
					-- Cleanup
					if _G.ActivityPriority == "Winter" then
						if _G.Toggle_AutoFarm.CurrentValue then
							_G.ActivityPriority = "Farming"
						else
							_G.ActivityPriority = "None"
						end
					end
					
					local finalRoot = getPlayerRoot()
					if finalRoot and finalRoot.Anchored then 
						finalRoot.Anchored = false 
					end
				end)
			else
				-- Toggle turned off
				if _G.ActivityPriority == "Winter" then
					if _G.Toggle_AutoFarm.CurrentValue then 
						_G.ActivityPriority = "Farming" 
					else 
						_G.ActivityPriority = "None" 
					end
				end
				
				local finalRoot = getPlayerRoot()
				if finalRoot and finalRoot.Anchored then 
					finalRoot.Anchored = false 
				end
			end
		end
	})
	
	Tab_Teleport = Window:CreateTab("Teleport")
	
	Tab_Teleport:CreateSection("World Teleport")
	
	task.wait()
	
	_G.Toggle_TeleportMode = Tab_Teleport:CreateToggle({
		Name = "Teleport Mode",
		Description = "Off: Sets spawn and resets\nOn: Teleport",
		CurrentValue = true,
		Flag = "TeleportModeToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.TeleportMode = Value
		end
	})
	
	task.wait()
	
	_G.ChangeWorld = function(worldName)
		local args = {
			[1] = {
				[1] = {
					["Event"] = "ChangeSpawn",
					["Spawn"] = worldName
				},
				[2] = ""
			}
		}
		args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
		args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = 0
			player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
		end
	end
	
	local function teleportToWorld(worldName)
		if _G.Toggle_TeleportMode.CurrentValue then
			local targetCFrame = _G.worldSpawns[worldName]
			if targetCFrame then
				_G.TeleportTo(targetCFrame)
			end
		else
			_G.ChangeWorld(worldName)
		end
	end
	
	Tab_Teleport:CreateButton({
		Name = "Solo",
		Callback = function() teleportToWorld("SoloWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Naruto",
		Callback = function() teleportToWorld("NarutoWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "One Piece",
		Callback = function() teleportToWorld("OPWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Bleach",
		Callback = function() teleportToWorld("BleachWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Black Clover",
		Callback = function() teleportToWorld("BCWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Chainsaw Man",
		Callback = function() teleportToWorld("ChainsawWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Jojo",
		Callback = function() teleportToWorld("JojoWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Dragon Ball",
		Callback = function() teleportToWorld("DBWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "One Punch Man",
		Callback = function() teleportToWorld("OPMWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Dan Dan Dan Dan Dan Dan Dan Dan Dan",
		Callback = function() teleportToWorld("DanWorld") end
	})
	Tab_Teleport:CreateButton({
		Name = "Solo2",
		Callback = function() teleportToWorld("Solo2World") end
	})
	
	-- Funções para Salvar/Carregar Posição
	function SavePlayerPosition()
		local root = getPlayerRoot()
		if not root then
			Rayfield:Notify({ Title = "Error", Content = "Cannot save position: Player character not loaded!", Duration = 3, Image="alert-circle" })
			return
		end
	
		local currentCFrame = root.CFrame
		local pos = currentCFrame.Position
		local look = currentCFrame.LookVector -- Salva LookVector para orientação
	
		-- Formato: pos.X,pos.Y,pos.Z,look.X,look.Y,look.Z
		local cframeString = string.format("%.2f,%.2f,%.2f,%.2f,%.2f,%.2f",
										   pos.X, pos.Y, pos.Z,
										   look.X, look.Y, look.Z)
	
		_G.SavedFarmPosition = CFrame.new(pos, look)
	
		local success, err = pcall(function()
			writefile("position_arise.txt", cframeString)
		end)
	
		if success then
			Rayfield:Notify({ Title = "Success", Content = "Position saved!", Duration = 3, Image="check-circle" })
		else
			Rayfield:Notify({ Title = "Error", Content = "Failed to save position: " .. tostring(err), Duration = 5, Image="alert-circle" })
		end
	end
	
	_G.LoadPlayerPosition = function()
		if not isfile("position_arise.txt") then
			Rayfield:Notify({ Title = "Error", Content = "No saved position found.", Duration = 3, Image="alert-circle" })
			return nil
		end
	
		local cframeString = nil
		local successRead, resultRead = pcall(function()
			cframeString = readfile("position_arise.txt")
		end)
	
		if not successRead or not cframeString then
			Rayfield:Notify({ Title = "Error", Content = "Failed to read position_arise.txt: " .. tostring(resultRead), Duration = 5, Image="alert-circle" })
			return nil
		end
	
		local components = {}
		for numStr in string.gmatch(cframeString, "[^,]+") do
			local num = tonumber(numStr)
			if not num then
				Rayfield:Notify({ Title = "Error", Content = "Invalid data format in position_arise.txt.", Duration = 5, Image="alert-circle" })
				return nil -- Número inválido encontrado
			end
			table.insert(components, num)
		end
	
		if #components ~= 6 then
			Rayfield:Notify({ Title = "Error", Content = "Incorrect data format in position_arise.txt (Expected 6 values).", Duration = 5, Image="alert-circle" })
			return nil -- Esperado 6 componentes (Pos X,Y,Z, Look X,Y,Z)
		end
	
		local pos = Vector3.new(components[1], components[2], components[3])
		local look = Vector3.new(components[4], components[5], components[6])
		local lookAtPos = pos + look -- Calcula o ponto para onde olhar
	
		_G.SavedFarmPosition = CFrame.new(pos, lookAtPos)
		return CFrame.new(pos, lookAtPos)
	end
	
	function TeleportToSavedPosition()
		local loadedCFrame = _G.LoadPlayerPosition()
		if loadedCFrame then
			_G.TeleportTo(loadedCFrame) -- Usa a função TeleportTo existente
			Rayfield:Notify({ Title = "Teleport", Content = "Teleported to saved position.", Duration = 3, Image="map-pin" })
		end
	end
	
	Tab_Teleport:CreateSection("Server Hop")
	
	Tab_Teleport:CreateButton({
		Name = "Server Hop",
		Callback = function()
			_G.HopToServer()
		end
	})
	
	-- Adiciona botões na UI
	Tab_Teleport:CreateSection("Saved Position")
	
	Tab_Teleport:CreateButton({
		Name = "Save Current Position",
		Callback = SavePlayerPosition
	})
	
	Tab_Teleport:CreateButton({
		Name = "Teleport to Position",
		Callback = TeleportToSavedPosition
	})
	
	local Tab_Misc = Window:CreateTab("Misc")
	
	Tab_Misc:CreateSection("Misc")
	
	_G.Toggle_RedeemDailyQuest = Tab_Misc:CreateToggle({
		Name = "Redeem Daily Quest",
		CurrentValue = false,
		Flag = "RedeemDailyQuestToggle",
		Callback = function(Value)
			if Value then
				while _G.Toggle_RedeemDailyQuest.CurrentValue do
					for _, quest in ipairs(dailyQuests) do
						_G.RedeemDailyQuest(quest)
						task.wait(1)
					end
					task.wait(15)
				end
			end
		end
	})
	
	_G.Toggle_RedeemWeeklyQuest = Tab_Misc:CreateToggle({
		Name = "Redeem Weekly Quest",
		CurrentValue = false,
		Flag = "RedeemWeeklyQuestToggle",
		Callback = function(Value)
			if Value then
				while _G.Toggle_RedeemWeeklyQuest.CurrentValue do
					for _, quest in ipairs(weeklyQuests) do
						_G.RedeemWeeklyQuest(quest)
						task.wait(1)
					end
					task.wait(15)
				end
			end
		end
	})
	
	local Tab_Settings = Window:CreateTab("Settings")
	
	Tab_Settings:CreateSection("Settings")
	
	_G.Toggle_AutoExecute = Tab_Settings:CreateToggle({
		Name = "Auto Execute",
		Description = "Auto Execute the script when you teleport",
		CurrentValue = false,
		Flag = "AutoExecuteToggle",
		Callback = function(Value)
			if Value then
				if not queueteleport then
					Rayfield:Notify({
						Title = "Error",
						Content = "Your exploit does not support this feature.",
						Duration = 5
					})
					_G.Toggle_AutoExecute:SetValue(false)
					return
				end
				Rayfield:Notify({
					Title = "Auto Execute",
					Content = "Script will execute in the new server.",
					Duration = 3
				})
			end
		end
	})
	
	local themeNames = {
	"Default",
	"Ocean",
	"AmberGlow",
	"Light",
	"Amethyst",
	"Green",
	"Bloom",
	"DarkBlue",
	"Serenity"
	}
	
	Tab_Settings:CreateDropdown({
		Name = "Theme",
		Options = themeNames, 
		CurrentOption = {"Default"}, 
		MultipleOptions = false, 
		Flag = "SelectedTheme", 
		Callback = function(selectedOptions)
			
			if selectedOptions and #selectedOptions > 0 then
				local selectedThemeName = selectedOptions[1]      
				Window.ModifyTheme(selectedThemeName)
				
			end
		end,
	})
	
	local generateRandomName = function()
		local randomName = ""
		for i = 1, 10 do
			randomName = randomName .. string.char(math.random(97, 122))
		end
		return randomName
	end
	
	_G.Toggle_HideName = Tab_Settings:CreateToggle({
		Name = "Hide Name (Clientside)",
		CurrentValue = false,
		Flag = "HideNameToggle",
		Callback = function(Value)
			_G.AriseSettings.Toggles.HideNameToggle = Value
			local playerMain = workspace.__Main.__Players
			local playerObj = playerMain:FindFirstChild(player.Name)
			
			if playerObj and playerObj:FindFirstChild("HumanoidRootPart") then
				local title = playerObj.HumanoidRootPart.PlayerTag.Main.Title
				if title then
					if Value then
						title.Text = "@" .. generateRandomName()
					else
						title.Text = "@" .. player.Name
					end
				end
			end
		end
	})
	
	task.wait(0.1)
	Rayfield:LoadConfiguration()
	
	local loadedWorldTable = _G.Dropdown_World.CurrentOption
	local loadedWorld = nil
	if type(loadedWorldTable) == "table" and #loadedWorldTable > 0 then
		loadedWorld = loadedWorldTable[1]
	end
	
	if loadedWorld and _G.Dropdown_Enemy then
		local loadedEnemyList = getgenv().enemyList[loadedWorld] or {}
		local sR, eR = pcall(_G.Dropdown_Enemy.Refresh, _G.Dropdown_Enemy, loadedEnemyList)
		if not sR then warn("[Config] Error Refresh:", eR) end
	else
		warn("[Config] Could not refresh enemy list on load (World or Enemy Dropdown invalid).")
	end
	
	if _G.LoadPlayerPosition() == nil then
		Rayfield:Notify({
			Title = "Save Position",
			Content = "No saved position found, saving current position.",
			Duration = 3,
			Image = "alert-circle"
		})
		SavePlayerPosition()
	end
	
	player.OnTeleport:Connect(function(State)
		if _G.Toggle_AutoExecute.CurrentValue and not TeleportCheck and queueteleport then
			TeleportCheck = true
			queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ErisvaldoBalbino/w/refs/heads/main/arework.lua'))()")
			Rayfield:Notify({
				Title = "Execute Queued",
				Content = "Script will execute in the new server.",
				Duration = 3
			})
		end
	end)
	
	local framePosition = UDim2.new(0, 100, 0, 100)
	
	local dragConnection = nil
	
	local function createMinimizeFrame()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "MinimizeGui"
		screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	
		local frame = Instance.new("TextButton")
		frame.Name = "MinimizeButton"
		frame.Size = UDim2.new(0, 50, 0, 50)
		frame.Position = framePosition
		frame.BackgroundColor3 = Color3.new(0, 0, 0)
		frame.Text = "twvz"
		frame.TextColor3 = Color3.new(1, 1, 1)
		frame.TextSize = 14
		frame.Font = Enum.Font.SourceSansBold
		frame.TextScaled = false
		frame.Parent = screenGui
	
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 8)
		uiCorner.Parent = frame
	
		local function minimizeWindow() 
			if Rayfield:IsVisible() then
				Rayfield:SetVisibility(false)
			else
				Rayfield:SetVisibility(true)
			end
		end
	
		frame.MouseButton1Click:Connect(minimizeWindow)
	
		local dragging = false
		local dragInput = nil
		local dragStart = nil
		local startPos = nil
		local currentTween = nil
	
		local RunService = game:GetService("RunService")
	
		if dragConnection then
			dragConnection:Disconnect()
			dragConnection = nil
		end
	
		frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragging = true
				dragStart = input.Position
				startPos = frame.Position
				
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
	
		frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
	
		frame.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	
		dragConnection = RunService.RenderStepped:Connect(function()
			if dragging and dragInput then
				local delta = dragInput.Position - dragStart
				
				local newPosition = UDim2.new(
					startPos.X.Scale, 
					startPos.X.Offset + delta.X, 
					startPos.Y.Scale, 
					startPos.Y.Offset + delta.Y
				)
				
				if currentTween then
					currentTween:Cancel()
				end
				
				local tweenInfo = TweenInfo.new(0.05, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				currentTween = TweenService:Create(frame, tweenInfo, {Position = newPosition})
				currentTween:Play()
				
				framePosition = newPosition
			end
		end)
		
		frame.AncestryChanged:Connect(function()
			if not frame:IsDescendantOf(game) and dragConnection then
				dragConnection:Disconnect()
				dragConnection = nil
			end
		end)
	end
	
	createMinimizeFrame()
	
	game.Players.LocalPlayer.CharacterAdded:Connect(createMinimizeFrame)
	
end

-------------------------------------------------------------------------------
--! Main Execution Logic
-------------------------------------------------------------------------------

local showUI = true -- Default to showing the UI
local Window = nil -- Declare Window here to make it accessible later if created

if fileFuncsAvailable then
    print("Platoboost: Checking for saved key...")
    local savedKey = loadKeyFromFile()
    if savedKey then
        print("Platoboost: Found saved key.")
        local isValid = verifyKey(savedKey) -- Verify silently
        if isValid then
            print("Platoboost: Saved key is valid.")
            onMessage("Auto-verified with saved key.") -- Notify user
            showUI = false -- Don't show the UI
            RunMainScript() -- Run the main logic directly
        else
            print("Platoboost: Saved key is no longer valid or verification failed.")
            -- Proceed to show UI
        end
    else
        print("Platoboost: No valid saved key found.")
        -- Proceed to show UI
    end
else
    print("Platoboost: File saving/loading not supported by this executor.")
end

if showUI then
    --print("Platoboost: Loading UI...")
    Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local key = ""

    Window = Fluent:CreateWindow({
            Title = "twvz",
            TabWidth = 20,
            Size = UDim2.fromOffset(280, 280),
            Acrylic = false,
            Theme = "Amethyst",
            MinimizeKey = Enum.KeyCode.LeftControl
    })

    local Tabs = {
            KeySys = Window:AddTab({ Title = "Key System", Icon = "spinner" }),
    }

    local Entkey = Tabs.KeySys:AddInput("Input", {
            Title = "Key",
            Default = "",
            Placeholder = "Enter key here...",
            Numeric = false,
            Finished = false,
            Callback = function(Value)
                    key = Value
            end
    })

    local Checkkey = Tabs.KeySys:AddButton({
            Title = "Check Key",
            Callback = function()
                if key == "" then
                    onMessage("Please enter a key first.")
                    return
                end
                local success = verifyKey(key) -- Use the key from the input box
                if success then
                    saveKeyToFile(key) -- Save the successfully verified key

					-- Destruir a janela do sistema de chaves AGORA
					if Fluent and Window then
						pcall(function() Window:Destroy() end)
						Window = nil 
					end

                    RunMainScript() -- Run main logic
                    -- Window:Destroy() -- Already handled in RunMainScript
                else
                    -- Specific error message already shown by verifyKey/redeemKey via onMessage
                    Fluent:Notify({Title = "Error", Content = "Key is invalid or failed. Check notifications.", Duration = 5})
                end
            end
    })

    local Getkey = Tabs.KeySys:AddButton({
            Title = "Get Key Link",
            Callback = function()
                local copied = copyLink()
                if copied then
                     Fluent:Notify({Title = "Link Copied", Content = "Paste the link into your browser.", Duration = 5})
                else
                     Fluent:Notify({Title = "Error", Content = "Failed to get link. Check notifications.", Duration = 5})
                end
            end
    })

    Window:SelectTab(1)
    print("Platoboost UI Loaded.")

else
    --print("Platoboost: UI Skipped due to valid saved key.")
end
