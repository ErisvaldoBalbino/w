local a=2^32;local b=a-1;local function c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%a end;local function k(d,e,l,...)local m;if e then d=d%a;e=e%a;m=c(d,e)if l then m=k(m,l,...)end;return m elseif d then return d%a else return 0 end end;local function n(d,e,l,...)local m;if e then d=d%a;e=e%a;m=(d+e-c(d,e))/2;if l then m=n(m,l,...)end;return m elseif d then return d%a else return b end end;local function o(p)return b-p end;local function q(d,r)if r<0 then return lshift(d,-r)end;return math.floor(d%2^32/2^r)end;local function s(p,r)if r>31 or r<-31 then return 0 end;return q(p%a,r)end;local function lshift(d,r)if r<0 then return s(d,-r)end;return d*2^r%2^32 end;local function t(p,r)p=p%a;r=r%32;local u=n(p,2^r-1)return s(p,r)+lshift(u,32-r)end;local v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function E(F,G)local H=64-(G+9)%64;G=y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function K(F,B,J)local L={}for M=1,16 do L[M]=D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=k(t(N,7),t(N,18),s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+k(t(N,17),t(N,19),s(N,10)))%a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=k(t(d,2),t(d,13),t(d,22))local U=k(n(d,e),n(d,l),n(e,l))local V=(O+U)%a;local W=k(t(Q,6),t(Q,11),t(Q,25))local X=k(n(Q,R),n(o(Q),S))local Y=(T+W+X+v[B]+L[B])%a;T=S;S=R;R=Q;Q=(P+Y)%a;P=l;l=e;e=d;d=(Y+V)%a end;J[1]=(J[1]+d)%a;J[2]=(J[2]+e)%a;J[3]=(J[3]+l)%a;J[4]=(J[4]+P)%a;J[5]=(J[5]+Q)%a;J[6]=(J[6]+R)%a;J[7]=(J[7]+S)%a;J[8]=(J[8]+T)%a end;local function Z(F)F=E(F,#F)local J=I({})for B=1,#F,64 do K(F,B,J)end;return w(y(J[1],4)..y(J[2],4)..y(J[3],4)..y(J[4],4)..y(J[5],4)..y(J[6],4)..y(J[7],4)..y(J[8],4))end;local e;local l={["\\"]="\\",["\""]="\"",["\b"]="b",["\f"]="f",["\n"]="n",["\r"]="r",["\t"]="t"}local P={["/"]="/"}for Q,R in pairs(l)do P[R]=Q end;local S=function(T)return"\\"..(l[T]or string.format("u%04x",T:byte()))end;local B=function(M)return"null"end;local v=function(M,z)local _={}z=z or{}if z[M]then error("circular reference")end;z[M]=true;if rawget(M,1)~=nil or next(M)==nil then local A=0;for Q in pairs(M)do if type(Q)~="number"then error("invalid table: mixed or invalid key types")end;A=A+1 end;if A~=#M then error("invalid table: sparse array")end;for a0,R in ipairs(M)do table.insert(_,e(R,z))end;z[M]=nil;return"["..table.concat(_,",").."]"else for Q,R in pairs(M)do if type(Q)~="string"then error("invalid table: mixed or invalid key types")end;table.insert(_,e(Q,z)..":"..e(R,z))end;z[M]=nil;return"{"..table.concat(_,",").."}"end end;local g=function(M)return'"'..M:gsub('[%z\1-\31\\"]',S)..'"'end;local a1=function(M)if M~=M or M<=-math.huge or M>=math.huge then error("unexpected number value '"..tostring(M).."'")end;return string.format("%.14g",M)end;local j={["nil"]=B,["table"]=v,["string"]=g,["number"]=a1,["boolean"]=tostring}e=function(M,z)local x=type(M)local a2=j[x]if a2 then return a2(M,z)end;error("unexpected type '"..x.."'")end;local a3=function(M)return e(M)end;local a4;local N=function(...)local _={}for a0=1,select("#",...)do _[select(a0,...)]=true end;return _ end;local L=N(" ","\t","\r","\n")local p=N(" ","\t","\r","\n","]","}",",")local a5=N("\\","/",'"',"b","f","n","r","t","u")local m=N("true","false","null")local a6={["true"]=true,["false"]=false,["null"]=nil}local a7=function(a8,a9,aa,ab)for a0=a9,#a8 do if aa[a8:sub(a0,a0)]~=ab then return a0 end end;return#a8+1 end;local ac=function(a8,a9,J)local ad=1;local ae=1;for a0=1,a9-1 do ae=ae+1;if a8:sub(a0,a0)=="\n"then ad=ad+1;ae=1 end end;error(string.format("%s at line %d col %d",J,ad,ae))end;local af=function(A)local a2=math.floor;if A<=0x7f then return string.char(A)elseif A<=0x7ff then return string.char(a2(A/64)+192,A%64+128)elseif A<=0xffff then return string.char(a2(A/4096)+224,a2(A%4096/64)+128,A%64+128)elseif A<=0x10ffff then return string.char(a2(A/262144)+240,a2(A%262144/4096)+128,a2(A%4096/64)+128,A%64+128)end;error(string.format("invalid unicode codepoint '%x'",A))end;local ag=function(ah)local ai=tonumber(ah:sub(1,4),16)local aj=tonumber(ah:sub(7,10),16)if aj then return af((ai-0xd800)*0x400+aj-0xdc00+0x10000)else return af(ai)end end;local ak=function(a8,a0)local _=""local al=a0+1;local Q=al;while al<=#a8 do local am=a8:byte(al)if am<32 then ac(a8,al,"control character in string")elseif am==92 then _=_..a8:sub(Q,al-1)al=al+1;local T=a8:sub(al,al)if T=="u"then local an=a8:match("^[dD][89aAbB]%x%x\\u%x%x%x%x",al+1)or a8:match("^%x%x%x%x",al+1)or ac(a8,al-1,"invalid unicode escape in string")_=_..ag(an)al=al+#an else if not a5[T]then ac(a8,al-1,"invalid escape char '"..T.."' in string")end;_=_..P[T]end;Q=al+1 elseif am==34 then _=_..a8:sub(Q,al-1)return _,al+1 end;al=al+1 end;ac(a8,a0,"expected closing quote for string")end;local ao=function(a8,a0)local am=a7(a8,a0,p)local ah=a8:sub(a0,am-1)local A=tonumber(ah)if not A then ac(a8,a0,"invalid number '"..ah.."'")end;return A,am end;local ap=function(a8,a0)local am=a7(a8,a0,p)local aq=a8:sub(a0,am-1)if not m[aq]then ac(a8,a0,"invalid literal '"..aq.."'")end;return a6[aq],am end;local ar=function(a8,a0)local _={}local A=1;a0=a0+1;while 1 do local am;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="]"then a0=a0+1;break end;am,a0=a4(a8,a0)_[A]=am;A=A+1;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="]"then break end;if as~=","then ac(a8,a0,"expected ']' or ','")end end;return _,a0 end;local at=function(a8,a0)local _={}a0=a0+1;while 1 do local au,M;a0=a7(a8,a0,L,true)if a8:sub(a0,a0)=="}"then a0=a0+1;break end;if a8:sub(a0,a0)~='"'then ac(a8,a0,"expected string for key")end;au,a0=a4(a8,a0)a0=a7(a8,a0,L,true)if a8:sub(a0,a0)~=":"then ac(a8,a0,"expected ':' after key")end;a0=a7(a8,a0+1,L,true)M,a0=a4(a8,a0)_[au]=M;a0=a7(a8,a0,L,true)local as=a8:sub(a0,a0)a0=a0+1;if as=="}"then break end;if as~=","then ac(a8,a0,"expected '}' or ','")end end;return _,a0 end;local av={['"']=ak,["0"]=ao,["1"]=ao,["2"]=ao,["3"]=ao,["4"]=ao,["5"]=ao,["6"]=ao,["7"]=ao,["8"]=ao,["9"]=ao,["-"]=ao,["t"]=ap,["f"]=ap,["n"]=ap,["["]=ar,["{"]=at}a4=function(a8,a9)local as=a8:sub(a9,a9)local a2=av[as]if a2 then return a2(a8,a9)end;ac(a8,a9,"unexpected character '"..as.."'")end;local aw=function(a8)if type(a8)~="string"then error("expected argument of type string, got "..type(a8))end;local _,a9=a4(a8,a7(a8,1,L,true))a9=a7(a8,a9,L,true)if a9<=#a8 then ac(a8,a9,"trailing garbage")end;return _ end;
local lEncode, lDecode, lDigest = a3, aw, Z;

--! configuration
local service = 3431;
local pasta = "951a1259-8c76-43c9-979f-875c1f41f202";
local useNonce = true;

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

    task.wait(2)

    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    if _G.UILOADED then 
        return 
    end
    
    _G.UILOADED = true
    
    local cloneref = cloneref or function(o) return o end
    
    local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
    local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZhangJunZ84/Fluent/refs/heads/master/Addons/SaveManager.lua"))()
    local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
    
    local Players = cloneref(game:GetService("Players"))
    
    local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
    local TeleportCheck = false
    
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local player = game.Players.LocalPlayer
    local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local GuiService = game:GetService("GuiService")
    local Terrain = workspace:FindFirstChildOfClass('Terrain')
    Lighting = cloneref(game:GetService("Lighting"))
    local isFpsBoostActive = false
    local originalTerrainValues = nil
    local originalLightingValues = nil
    local originalQualityLevel = nil
    local fpsBoostConnection = nil
    local blackScreenGui = nil
    local whiteScreenGui = nil
    
    local dpsLabel
    repeat
        task.wait(0.1)
        pcall(function()
            dpsLabel = player.PlayerGui:WaitForChild("Hud").Hud.Dps
        end)
    until dpsLabel
    
    local customDpsValue = dpsLabel.Text:match("DPS: (.+)") or "0"
    
    spawn(function()
        while true do
            VirtualInputManager:SendKeyEvent(true, 101, false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, 101, false, game)
            task.wait(120)
        end
    end)
    
    task.wait()
    local Window = Fluent:CreateWindow({
        Title = "Arise Crossover",
        SubTitle = "twvz",
        TabWidth = 100,
        Size = UDim2.fromOffset(480, 360),
        Acrylic = false,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.LeftControl
    })
    
    task.wait()
    local Tabs = {
        Infos = Window:AddTab({ Title = "Infos", Icon = "info" }),
        Main = Window:AddTab({ Title = "Main", Icon = "loader" }),
        Winter = Window:AddTab({ Title = "Winter", Icon = "snowflake" }),
        Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "sword" }),
        Castle = Window:AddTab({ Title = "Castle", Icon = "flame" }),
        Rank = Window:AddTab({ Title = "Rank", Icon = "swords" }),
        Raid = Window:AddTab({ Title = "Raid", Icon = "shield" }),
        Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
        Quests = Window:AddTab({ Title = "Quests", Icon = "archive" }),
        Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
        Mount = Window:AddTab({ Title = "Mount", Icon = "car" }),
        Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
        Exchange = Window:AddTab({ Title = "Exchange", Icon = "coins" }),
        Upgrader = Window:AddTab({ Title = "Upgrader", Icon = "hammer" }),
        Boosts = Window:AddTab({ Title = "Boosts", Icon = "activity" }),
        Gamepasses = Window:AddTab({ Title = "Gamepasses", Icon = "award" }),
        Experimental = Window:AddTab({ Title = "Experimental", Icon = "banana" }),
        Webhook = Window:AddTab({ Title = "Webhook", Icon = "link" }),
        Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
    }
    
    local Options = Fluent.Options
    
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local dataRemoteEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
    local function getPlayerRoot()
        return player.Character and player.Character:FindFirstChild("HumanoidRootPart")
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
    
    getgenv().pets = {
        "Dongsoo",
        "Gunhee",
        "Baek",
        "JongIn",
        "Andre",
        "Kargalgan",
        "Igris",
        "JinWoo",
        "RedAnt",
        "AntQueen",
        "Beru",
        "Orochimaru",
        "Sakura",
        "Itachi",
        "Pain",
        "Arlong",
        "Enel",
        "Kizaru",
        "Mihalk",
        "Uryu",
        "Byakuya",
        "Renji",
        "Ulquiorra",
        "Luck",
        "Noelle",
        "Yuno",
        "Julius",
        "Angel",
        "Reze",
        "Aki",
        "Denji",
        "Diavolo",
        "Josuke",
        "Jolyne",
        "Pucci",
        "Kame",
        "Piccolo",
        "Cell",
        "Freeza",
        "Esil",
        "Vulcan",
        "Metus",
        "Baran",
        "Mumem",
        "Genos",
        "Tornado",
        "Saitama",
        "Elf1",
        "Elf2",
        "Baraka",
        "Sillad",
        "Tank",
        "Mantis",
        "Aira",
        "Momo",
        "Okarun",
        "Yuri",
        "Lennart",
        "Christopher",
        "Chae"
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
    
    local rankMap = {
        ["E"] = 1,
        ["D"] = 2,
        ["C"] = 3,
        ["B"] = 4,
        ["A"] = 5,
        ["S"] = 6,
        ["SS"] = 7,
        ["G"] = 8
    }
    
    local dungeonRankMap = {
    [1] = "E", [2] = "D", [3] = "C", [4] = "B",
    [5] = "A", [6] = "S", [7] = "SS"
    }
    
    local rankList = {"E", "D", "C", "B", "A", "S", "SS", "G", "N"}
    
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
    
    _G.FormatNumber = function(num)
        if not num then return "0" end
        if num < 1000 then
            return string.format("%.2f", num)
        elseif num < 1000000 then
            return string.format("%.2fK", num/1000)
        elseif num < 1000000000 then
            return string.format("%.2fM", num/1000000)
        elseif num < 1000000000000 then
            return string.format("%.2fB", num/1000000000)
        elseif num < 1000000000000000 then
            return string.format("%.2fT", num/1000000000000)
        elseif num < 1000000000000000000 then
            return string.format("%.2fQa", num/1000000000000000)
        elseif num < 1000000000000000000000 then
            return string.format("%.2fQi", num/1000000000000000000)
        elseif num < 1000000000000000000000000 then
            return string.format("%.2fSx", num/1000000000000000000000)
        elseif num < 1000000000000000000000000000 then
            return string.format("%.2fSp", num/1000000000000000000000000)
        elseif num < 1000000000000000000000000000000 then
            return string.format("%.2fSx", num/1000000000000000000000000000)
        elseif num < 1000000000000000000000000000000000 then
            return string.format("%.2fN", num/1000000000000000000000000000000)
        end
    end
    
    _G.getPetsToSell = function(selectedRanks)
        local petsToSell = {}
    
        if not selectedRanks or type(selectedRanks) ~= "table" then
            return petsToSell
        end
    
        local ignoredPetKeysTable = Options.IgnorePetsDropdown and Options.IgnorePetsDropdown.Value or {}
        if type(ignoredPetKeysTable) ~= "table" then
             warn("getPetsToSell: CRITICAL - IgnorePetsDropdown value is NOT a table!")
             ignoredPetKeysTable = {}
        end
    
        local inventory = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats")
        if not inventory then
            warn("getPetsToSell: leaderstats not found.")
            return petsToSell
        end
    
        local petFolder = inventory:FindFirstChild("Inventory") and inventory.Inventory:FindFirstChild("Pets")
        if not petFolder then
            warn("getPetsToSell: Pet inventory folder not found.")
            return petsToSell
        end
    
        for i, pet in ipairs(petFolder:GetChildren()) do
            local petInstanceName = pet.Name
            local isLocked = pet:GetAttribute("Locked") or false
            local rankNum = pet:GetAttribute("Rank") or 0
    
            local shouldIgnoreThisPet = false
            for keyToIgnore, isSelected in pairs(ignoredPetKeysTable) do
                if isSelected then
                    if type(keyToIgnore) == "string" and #keyToIgnore > 0 and #petInstanceName >= #keyToIgnore then
                        if string.sub(string.lower(petInstanceName), 1, #keyToIgnore) == string.lower(keyToIgnore) then
                            shouldIgnoreThisPet = true
                            break
                        end
                    end
                end
            end
    
            if not shouldIgnoreThisPet then
                local petShouldBeSold = false
    
                for rankLetter, isSelectedRank in pairs(selectedRanks) do
                    if isSelectedRank then
                        local targetRankNum = rankMap[rankLetter]
                        if targetRankNum and rankNum == targetRankNum then
                            petShouldBeSold = true
                            break
                        end
                    end
                end
    
                if petShouldBeSold and not isLocked then
                    table.insert(petsToSell, petInstanceName)
                end
            end
        end
    
        return petsToSell
    end
    
    
    _G.AriseSettings = {
        Toggles = {},
        ActionLog = {},
        PreferredDungeonWorld = nil,
        PreferredServerType = nil
    }
    
    _G.ActivityPriority = "None"
    
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
        args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\005"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
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
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 0
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
        end
    end
    
    _G.SellPets = function(petIds)
        if not petIds or type(petIds) ~= "table" or #petIds == 0 then
            warn("SellPets: error")
            return
        end
            
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "SellPet",
                    ["Pets"] = petIds
                },
                [2] = ""
            }
        }
        args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
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
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
    local function addRune(dungeonId)
        local args = {
            [1] = {
                [1] = {
                    ["Dungeon"] = player.UserId,
                    ["Action"] = "AddItems",
                    ["Slot"] = 1,
                    ["Event"] = "DungeonAction",
                    ["Item"] = tostring(Options.DungeonRuneDropdown.Value)
                },
                [2] = ""
            }
        }
        args[1][2] = "\v"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
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
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
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
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
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
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
    local function showPetsRemote()
        local args = {
            [1] = {
                [1] = {
                    ["Event"] = "ShowPets"
                },
                [2] = ""
            }
        }
    
        args[1][2] = "\n"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\t"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\7"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\8"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\5"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\6"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\11"  dataRemoteEvent:FireServer(unpack(args))
        args[1][2] = "\010"  dataRemoteEvent:FireServer(unpack(args))
    end
    
    _G.IsEnemyAlive = function(enemy)
        local healthBar = enemy:FindFirstChild("HealthBar")
        if healthBar and healthBar.Main:FindFirstChild("Bar") and healthBar.Main.Bar:FindFirstChild("Amount") then
            local hpText = healthBar.Main.Bar.Amount.Text
            return hpText ~= "0 HP"
        end
        return false
    end
    
    _G.TeleportTo = function(position)    
        local playerRoot = getPlayerRoot()
        local targetCFrame = (typeof(position) == "CFrame" and position) or CFrame.new(position)
        
        local playerModel = workspace:WaitForChild("__Main"):WaitForChild("__Players"):WaitForChild(player.Name)
        if not playerModel then
            warn("Player model not found in workspace.__Main.__Players!")
            return
        end
    
        local originalInTp = playerModel:GetAttribute("InTp")
        local hadInTp = originalInTp ~= nil
        
        if not hadInTp then
            playerModel:SetAttribute("InTp", true)
        else
            playerModel:SetAttribute("InTp", true)
        end
    
        local restoreInTp = _G.StepTeleport(targetCFrame.Position)
        playerRoot.CFrame = targetCFrame
        
        if hadInTp then
            playerModel:SetAttribute("InTp", originalInTp)
        else
            playerModel:SetAttribute("InTp", nil)
        end
    
        if restoreInTp then
            restoreInTp()
        end
    end
    
    local function updateDpsText(newText)
        dpsLabel.Text = "DPS: " .. newText
    end
    
    local isCustomizing = false
    RunService.Heartbeat:Connect(function()
        if isCustomizing then
            updateDpsText(customDpsValue)
        end
    end)
    
    local JEJU_ISLAND_POSITION = CFrame.new(3838.418701171875, 60.106929779052734, 3056.931884765625)
    local MIN_DISTANCE_JEJU = 400
    
    local function teleportToJejuIsland(mode)    
        local currentPosition = playerRoot.Position
        local distance = (currentPosition - JEJU_ISLAND_POSITION.Position).Magnitude
        local adjustedPosition = JEJU_ISLAND_POSITION
    
        if distance > MIN_DISTANCE_JEJU then
            if mode == "Slow" then
                local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(playerRoot, tweenInfo, {CFrame = adjustedPosition})
                tween:Play()
                tween.Completed:Wait()
            elseif mode == "Fast" then
                local restoreInTp = _G.StepTeleport(adjustedPosition.Position)
                if restoreInTp then
                    restoreInTp()
                end
            end
    
            playerRoot.Anchored = true
            playerRoot.CFrame = adjustedPosition
    
            local maxWaitTime = 10
            local waitStart = tick()
            local groundLoaded = false
            
            while not groundLoaded and (tick() - waitStart < maxWaitTime) do
                local raycastResult = workspace:Raycast(adjustedPosition.Position, Vector3.new(0, -10, 0), RaycastParams.new())
                if raycastResult and raycastResult.Instance then
                    groundLoaded = true
                end
                task.wait(0.1)
            end
            
            playerRoot.Anchored = false
        end
    end
    
    local function hasFreePet()
        local petFolder = workspace.__Main.__Pets:FindFirstChild(player.UserId)
        if petFolder then
            for _, pet in pairs(petFolder:GetChildren()) do
                if pet:GetAttribute("Target") == nil then
                    return true
                end
            end
        end
        return false
    end
    
    local function getCurrentWorld()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        if not humanoidRootPart then return nil end
    
        local playerPosition = humanoidRootPart.Position
        local nearestWorld = nil
        local minDistance = math.huge
    
        for worldName, spawnCFrame in pairs(_G.worldSpawns) do
            local distance = (playerPosition - spawnCFrame.Position).Magnitude
            if distance < minDistance then
                minDistance = distance
                nearestWorld = worldName
            end
        end
    
        return nearestWorld
    end
    
    local function getNearestEnemyGlobal()
        if not playerRoot then return nil end
        local nearestEnemy = nil
        local minDistance = math.huge
        local clientEnemies = workspace.__Main.__Enemies.Client:GetChildren()
        for _, enemy in pairs(clientEnemies) do
            local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
            if enemyRoot and _G.IsEnemyAlive(enemy) then
                local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
                if distance < minDistance then
                    minDistance = distance
                    nearestEnemy = enemy
                end
            end
        end
        return nearestEnemy, minDistance
    end
    
    _G.islandPositions = {
        CFrame.new(3296.55859375, 83.05657196044922, 20.8635311126709),
        CFrame.new(-609.7685546875, 107.75768280029297, -3556.037353515625),
        CFrame.new(-5854.2119140625, 81.3797836303711, 398.00885009765625),
        CFrame.new(-5341.015625, 60.71369171142578, -5439.9521484375),
        CFrame.new(-6151.5224609375, 77.56470489501953, 5435.3037109375),
        CFrame.new(408.9056091308594, 57.346885681152344, 3350.184326171875),
        CFrame.new(4334.06103515625, 139.27662658691406, -4829.015625)
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
    
    getgenv().guildPositions = {
        GuildHall = CFrame.new(248.142181, 31.8532162, 157.246201, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
    
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
    
    _G.MoveWithTween = function(targetCFrame, maxSpeed)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local startPos = humanoidRootPart.Position
        local distance = (startPos - targetCFrame.Position).Magnitude
        local time = math.max(distance / maxSpeed, 0.2)
    
        local playerModel = workspace:WaitForChild("__Main"):WaitForChild("__Players"):WaitForChild(player.Name)
        if not playerModel then
            warn("Player model not found in workspace.__Main.__Players!")
            return
        end
    
        local originalInTp = playerModel:GetAttribute("InTp")
        local hadInTp = originalInTp ~= nil
        if not hadInTp then
            playerModel:SetAttribute("InTp", false)
        end
        playerModel:SetAttribute("InTp", true)
    
        humanoidRootPart.Anchored = true
    
        local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
    
        humanoidRootPart.Anchored = false
    
        if hadInTp then
            playerModel:SetAttribute("InTp", originalInTp)
        else
            playerModel:SetAttribute("InTp", nil)
        end
    end
    
    _G.TryMount = function(speed)
        local appearFolder = workspace:WaitForChild("__Extra"):WaitForChild("__Appear")
    
        speed = speed or 20
    
        for _, model in pairs(appearFolder:GetChildren()) do
            local mountPrompt = model:FindFirstChild("MountPrompt")
            if mountPrompt and mountPrompt:IsA("ProximityPrompt") then
                local character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
                local mountPosition = model.PrimaryPart and model.PrimaryPart.Position or model:GetPivot().Position
                local distance = (humanoidRootPart.Position - mountPosition).Magnitude
                
                if distance > 5 then
                    local targetCFrame = CFrame.new(mountPosition + Vector3.new(0, 3, 0))
                    _G.MoveWithTween(targetCFrame, speed)
                    distance = (humanoidRootPart.Position - mountPosition).Magnitude
                end
                
                if distance < 5 then
                    Fluent:Notify({
                        Title = "Mount Found",
                        Content = "Trying to mount " .. model.Name .. "...",
                        Duration = 2
                    })
                    VirtualInputManager:SendKeyEvent(true, 101, false, game)
                    task.wait(4)
                    VirtualInputManager:SendKeyEvent(false, 101, false, game)
                    task.wait(2)
                    return true
                end
            end
        end
        return false
    end
    
    _G.MoveToEnemy = function(targetPosition, moveType, speed, keepAnchored, showPets)
        local player = Players.LocalPlayer
        local character = player.Character
        local playerRoot = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChild("Humanoid")
    
        if not playerRoot or not humanoid then
            warn("MoveToEnemy: Could not find PlayerRoot or Humanoid at the time of call.")
            return
        end
    
        moveType = moveType or "Tween"
        local MIN_DISTANCE = 5
        speed = speed or 500
        keepAnchored = keepAnchored or false
        showPets = showPets or false
    
        local mainFolder = Workspace:FindFirstChild("__Main")
        local playerModel = mainFolder and mainFolder:FindFirstChild("__Players") and mainFolder.__Players:FindFirstChild(player.Name)
        local petsFolder = mainFolder and mainFolder:FindFirstChild("__Pets") and mainFolder.__Pets:FindFirstChild(tostring(player.UserId))
    
        if showPets then
            pcall(function()
                if type(showPetsRemote) == "function" then
                    showPetsRemote()
                elseif typeof(showPetsRemote) == "Instance" and showPetsRemote:IsA("RemoteEvent") then
                     showPetsRemote:FireServer()
                elseif showPetsRemote ~= nil then
                     warn("MoveToEnemy: showPetsRemote is not a function or RemoteEvent")
                end
            end)
        end
    
        local distance = (playerRoot.Position - targetPosition).Magnitude
    
        local referenceCFrameForPets = playerRoot.CFrame
    
        if distance <= MIN_DISTANCE then
            playerRoot.Anchored = keepAnchored
        else
            if not keepAnchored then
                playerRoot.Anchored = false
            end
    
            if moveType == "Tween" then
                if playerModel then playerModel:SetAttribute("InTp", true) end
    
                local time = math.clamp(distance / speed, 0.1, 0.5)
                local offset = Vector3.new(4, 2, 0)
                local targetCFrame = CFrame.new(targetPosition + offset)
                local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(playerRoot, tweenInfo, {CFrame = targetCFrame})
    
                playerRoot.Anchored = true
                tween:Play()
                tween.Completed:Wait()
                playerRoot.Anchored = false
                referenceCFrameForPets = targetCFrame
    
            elseif moveType == "Walk" then
                local originalWalkSpeed = humanoid.WalkSpeed
                humanoid.WalkSpeed = 45
                local walkTargetPosition = targetPosition + Vector3.new(5, 0, 0)
    
                humanoid:MoveTo(walkTargetPosition)
    
                local moveTimeout = math.clamp(distance / humanoid.WalkSpeed, 1, 5)
                local connection = nil
                local timeoutCoroutine = nil
    
                local function cleanupWalk(reason)
                    if connection then connection:Disconnect(); connection = nil end
                    if timeoutCoroutine then task.cancel(timeoutCoroutine); timeoutCoroutine = nil end
                    local currentHumanoid = player.Character and player.Character:FindFirstChild("Humanoid")
                    local currentPlayerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if currentHumanoid then currentHumanoid.WalkSpeed = originalWalkSpeed end
                    if currentPlayerRoot then currentPlayerRoot.Anchored = keepAnchored end
                end
    
                connection = humanoid.MoveToFinished:Connect(function(reached)
                    cleanupWalk(reached and "Reached" or "Interrupted")
                end)
    
                timeoutCoroutine = task.delay(moveTimeout, function()
                    if connection then cleanupWalk("Timeout") end
                end)
    
            elseif moveType == "Teleport" then
                if playerModel then playerModel:SetAttribute("InTp", true) end
    
                local offset = Vector3.new(4, 2, 0)
                local targetCFrame = CFrame.new(targetPosition + offset)
    
                playerRoot.CFrame = targetCFrame
                playerRoot.Anchored = keepAnchored
    
                referenceCFrameForPets = targetCFrame
            else
                warn("MoveToEnemy: Unknown moveType:", moveType)
            end
        end
    
        if petsFolder then
            local children = petsFolder:GetChildren()
            local totalPets = #children
    
            if totalPets > 0 then
                local playerScale = 1
                if playerRoot.Parent then
                     local scaleSuccess, scaleResult = pcall(function() return playerRoot.Parent:GetScale() end)
                     if scaleSuccess then playerScale = scaleResult end
                end
    
                for index, pet in ipairs(children) do
                    local angleDegrees = index / totalPets * 360 - 180
                    local radiusMultiplier = (math.floor(totalPets / 10) + 4) * math.max(playerScale / (1 + (0.3) * (playerScale / 2)), 1)
                    local offsetVector = (referenceCFrameForPets.RightVector * math.sin(math.rad(angleDegrees)) + referenceCFrameForPets.LookVector * -math.cos(math.rad(angleDegrees))) * radiusMultiplier
                    local petPosition = referenceCFrameForPets.Position + offsetVector
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
    end
    
    _G.StepTeleport = function(targetPosition)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        if not humanoidRootPart then
            Fluent:Notify({
                Title = "Error",
                Content = "Character not loaded!",
                Duration = 2
            })
            return
        end
        
        local playerObject = workspace.__Main.__Players:FindFirstChild(player.Name)
        if not playerObject then
            Fluent:Notify({
                Title = "Error",
                Content = "Player object not found in workspace!",
                Duration = 2
            })
            return
        end
        
        local originalInTp = playerObject:GetAttribute("InTp")
        if originalInTp == nil then
            playerObject:SetAttribute("InTp", false)
            originalInTp = false
        end
        playerObject:SetAttribute("InTp", true)
        
        humanoidRootPart.Anchored = true
        targetPosition = targetPosition + Vector3.new(4, 2, 0)
        humanoidRootPart.CFrame = CFrame.new(targetPosition)
        
        local maxWaitTime = 2
        local waitStart = tick()
        local groundLoaded = false
        
        while not groundLoaded and (tick() - waitStart < maxWaitTime) do
            local raycastResult = workspace:Raycast(targetPosition, Vector3.new(0, -10, 0), RaycastParams.new())
            if raycastResult and raycastResult.Instance then
                groundLoaded = true
            end
            task.wait(0.1)
        end
        
        humanoidRootPart.Anchored = false
        
        return function()
            if playerObject.Parent then
                playerObject:SetAttribute("InTp", originalInTp)
            end
        end
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
    
    local function getWeaponType(weaponName)
        local typeLength = #weaponName - 7
        return string.sub(weaponName, 1, typeLength)
    end
    
    local function getEligibleUpgrades()
        local upgrades = {}
        local weaponsFolder = player.leaderstats.Inventory.Weapons
    
        local weaponsByTypeAndLevel = {}
    
        for _, weapon in pairs(weaponsFolder:GetChildren()) do
            local weaponName = weapon.Name
            local typeName = getWeaponType(weaponName)
            local level = weapon:GetAttribute("Level")
    
            if level then
                local key = typeName .. "_" .. tostring(level)
                if not weaponsByTypeAndLevel[key] then
                    weaponsByTypeAndLevel[key] = {}
                end
                table.insert(weaponsByTypeAndLevel[key], weaponName)
            end
        end
    
        for key, weapons in pairs(weaponsByTypeAndLevel) do
            while #weapons >= 3 do
                local upgradeWeapons = {
                    table.remove(weapons, 1),
                    table.remove(weapons, 1),
                    table.remove(weapons, 1)
                }
                local typeName, levelStr = key:match("(.+)_(.+)")
                local level = tonumber(levelStr)
                table.insert(upgrades, {
                    type = typeName,
                    weapons = upgradeWeapons,
                    targetLevel = level + 1
                })
            end
        end
    
        return upgrades
    end
    
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
                Fluent:Notify({
                    Title = "Server Fetch Error",
                    Content = "Failed to get server list: " .. tostring(response) .. ". Retrying in " .. RETRY_DELAY .. "s...",
                    Duration = 5
                })
                return nil
            end
    
            local Site = response
            if not Site or type(Site) ~= "table" or not Site.data then
                warn("Invalid or empty API response: " .. tostring(Http:JSONEncode(Site)))
                Fluent:Notify({
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
                    Fluent:Notify({
                        Title = "Teleporting to Server",
                        Content = "Joining server with " .. v.playing .. "/" .. MAX_PLAYERS .. " players (" .. preferredServerType .. ")...",
                        Duration = 3
                    })
                    local success, err = pcall(function()
                        TPS:TeleportToPlaceInstance(_place, serverId, player)
                    end)
                    if not success then
                        warn("Teleport failed - Server: " .. serverId .. ", Error: " .. err)
                        Fluent:Notify({
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
                Fluent:Notify({
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
    
    _G.CloseAnyOpenMenu = function()
        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
        
        if not playerGui:FindFirstChild("Menus") then
            return false
        end
        
        local itemShop = playerGui.Menus:FindFirstChild("ItemShop")
        if itemShop and itemShop.Visible and itemShop.Main and itemShop.Main:FindFirstChild("Close") then
            local closeButton = itemShop.Main.Close
            for _, connection in pairs(getconnections(closeButton.Activated)) do
                connection:Fire()
            end
            return true
        end
        
        return success
    end
    
    function SavePlayerPosition()
        local root = getPlayerRoot()
        if not root then
            Fluent:Notify({ Title = "Error", Content = "Cannot save position: Player character not loaded!", Duration = 3})
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
            Fluent:Notify({ Title = "Success", Content = "Position saved!", Duration = 3})
        else
            Fluent:Notify({ Title = "Error", Content = "Failed to save position: " .. tostring(err), Duration = 5})
        end
    end
    
    _G.LoadPlayerPosition = function()
        if not isfile("position_arise.txt") then
            return nil
        end
    
        local cframeString = nil
        local successRead, resultRead = pcall(function()
            cframeString = readfile("position_arise.txt")
        end)
    
        if not successRead or not cframeString then
            return nil
        end
    
        local components = {}
        for numStr in string.gmatch(cframeString, "[^,]+") do
            local num = tonumber(numStr)
            if not num then
                return nil -- Número inválido encontrado
            end
            table.insert(components, num)
        end
    
        if #components ~= 6 then
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
            Fluent:Notify({ Title = "Teleport", Content = "Teleported to saved position.", Duration = 3})
        end
    end
    
    local potionTypes = {"CoinsPotion", "DropsPotion", "ExpPotion", "GemsPotion", "ShadowPotion"}
    local boostGuiMap = {
        CoinsPotion = "Coins",
        DropsPotion = "Drops",
        ExpPotion = "Exp",
        GemsPotion = "Gems",
        ShadowPotion = "Shadow"
    }
    
    local HttpService = game:GetService("HttpService")
    local request = http_request or request or HttpPost or syn.request
    
    local webhookUrl = ""
    local accountName = ""
    
    getgenv().webhookToggles = {
        Coins = true,
        Gems = true,
        Tickets = true,
        Common = true,
        Rare = true,
        Legendary = true,
    }
    
    local function formatNumber(num)
        if num >= 1000000000 then
            return string.format("%.1fb", num/1000000000)
        elseif num >= 1000000 then
            return string.format("%.1fm", num/1000000) 
        elseif num >= 1000 then
            return string.format("%.1fk", num/1000)
        end
        return tostring(num)
    end
    
    _G.getCurrentInventory = function()
        local playerGui = player:FindFirstChild("PlayerGui")
        local leaderstats = player:FindFirstChild("leaderstats")
    
        local coinsText = "0"
        local gemsText = "0"
        local ticketsValue = 0
        local commonValue = 0
        local rareValue = 0
        local legendaryValue = 0
    
        if playerGui then
            local hud = playerGui:FindFirstChild("Hud")
            if hud then
                local bottomContainer = hud:FindFirstChild("BottomContainer")
                if bottomContainer then
                    local coinsLabel = bottomContainer:FindFirstChild("Coins")
                    if coinsLabel and coinsLabel:IsA("TextLabel") then
                        coinsText = coinsLabel.Text or "0"
                    end
                    local gemsLabel = bottomContainer:FindFirstChild("Gems")
                    if gemsLabel and gemsLabel:IsA("TextLabel") then
                        gemsText = gemsLabel.Text or "0"
                    end
                end
            end
        end
    
        if leaderstats then
            local inventoryFolder = leaderstats:FindFirstChild("Inventory")
            if inventoryFolder then
                local items = inventoryFolder:FindFirstChild("Items")
                if items then
                    local ticketItem = items:FindFirstChild("Ticket")
                    if ticketItem then ticketsValue = ticketItem:GetAttribute("Amount") or 0 end
    
                    local commonItem = items:FindFirstChild("EnchCommon")
                    if commonItem then commonValue = commonItem:GetAttribute("Amount") or 0 end
    
                    local rareItem = items:FindFirstChild("EnchRare")
                    if rareItem then rareValue = rareItem:GetAttribute("Amount") or 0 end
    
                    local legendaryItem = items:FindFirstChild("EnchLegendary")
                    if legendaryItem then legendaryValue = legendaryItem:GetAttribute("Amount") or 0 end
                end
            end
        else
             warn("getCurrentInventory: leaderstats not found for player.")
        end
    
        ticketsValue = tonumber(ticketsValue) or 0
        commonValue = tonumber(commonValue) or 0
        rareValue = tonumber(rareValue) or 0
        legendaryValue = tonumber(legendaryValue) or 0
    
        local inventory = {
            Coins = coinsText,
            Gems = gemsText,
            Tickets = _G.FormatNumber(ticketsValue),
            Common = _G.FormatNumber(commonValue),
            Rare = _G.FormatNumber(rareValue),
            Legendary = _G.FormatNumber(legendaryValue)
        }
    
        return inventory
    end
    
    _G.saveInventory = function()
        local currentInventory = _G.getCurrentInventory()
        local jsonData = HttpService:JSONEncode(currentInventory)
        pcall(function()
            writefile(inventoryFile, jsonData)
        end)
    end
    
    _G.loadInventory = function()
        local success, data = pcall(function()
            if isfile and isfile(inventoryFile) then
                return readfile(inventoryFile)
            end
            return nil
        end)
        if success and data then
            return HttpService:JSONDecode(data)
        end
        return {Coins = "0", Gems = "0", Tickets = "0", Common = 0, Rare = 0, Legendary = 0}
    end
    
    _G.checkInventoryChanges = function()
        local savedInventory = _G.loadInventory()
        local currentInventory = _G.getCurrentInventory()
        local changes = {}
    
        if currentInventory.Coins ~= savedInventory.Coins then
            changes.Coins = currentInventory.Coins
        end
        if currentInventory.Gems ~= savedInventory.Gems then
            changes.Gems = currentInventory.Gems
        end
        if currentInventory.Tickets ~= savedInventory.Tickets then
            changes.Tickets = currentInventory.Tickets
        end
        if currentInventory.Common ~= savedInventory.Common then
            changes.Common = currentInventory.Common
        end
        if currentInventory.Rare ~= savedInventory.Rare then
            changes.Rare = currentInventory.Rare
        end
        if currentInventory.Legendary ~= savedInventory.Legendary then
            changes.Legendary = currentInventory.Legendary
        end
    
        return next(changes) and changes or nil
    end
    
    local fieldOrder = {"Coins", "Gems", "Tickets", "Common", "Rare", "Legendary"}
    
    local colorEmojis = {
        Coins = "🟡 ",
        Gems = "💎 ",
        Tickets = "🎟️ ",
        Common = "⚪ ",
        Rare = "🔵 ",
        Legendary = "🌟 "
    }
    
    _G.sendWebhookBase = function(dataToSend)
        local fields = {}
    
        for _, key in ipairs(fieldOrder) do
            if dataToSend[key] and getgenv().webhookToggles[key] then
                table.insert(fields, {
                    name = "**" .. key .. "**",
                    value = colorEmojis[key] .. "```" .. tostring(dataToSend[key]) .. "```",
                    inline = true
                })
            end
        end
    
        if #fields == 0 then return end
    
        local data = {
            ["content"] = "",
            ["embeds"] = {
                {
                    ["title"] = "Arise Crossover",
                    ["type"] = "rich",
                    ["color"] = 0x7A16DE,
                    ["author"] = {
                        ["name"] = "Account: " .. (accountName ~= "" and accountName or player.Name)
                    },
                    ["fields"] = fields,
                    ["footer"] = {["text"] = "twvz | " .. os.date("%Y-%m-%d")}
                }
            }
        }
    
        local headers = {["content-type"] = "application/json"}
        local requestData = {
            Url = webhookUrl,
            Body = HttpService:JSONEncode(data),
            Method = "POST",
            Headers = headers
        }
    
        if request then
            local success, response = pcall(request, requestData)
            if not success then
                warn("Webhook send failed: " .. tostring(response))
            end
        end
    end
    
    _G.sendWebhook = function()
        local changes = _G.checkInventoryChanges()
        if not changes then return end
        _G.sendWebhookBase(changes)
        _G.saveInventory()
    end
    
    _G.sendWebhookDungeon = function(gains)
        if not getgenv().webhookToggles.DungeonComplete then return end
        if not webhookUrl or not webhookUrl:match("^https://discord%.com/api/webhooks/") then return end
    
        local fields = {}
        local gainOrder = {"Tickets", "Common", "Rare", "Legendary"}
        local gainEmojis = {
            Tickets = "🎟️ ",
            Common = "⚪ ",
            Rare = "🔵 ",
            Legendary = "🌟 "
        }
    
        for _, key in ipairs(gainOrder) do
            local gainValue = gains[key] or 0
            if gainValue > 0 then
                table.insert(fields, {
                    name = "**" .. key .. " Gained**",
                    value = gainEmojis[key] .. "```" .. _G.FormatNumber(gainValue) .. "```",
                    inline = true
                })
            end
        end
    
        local embedData = {
            ["title"] = "🎉 Dungeon Completed! 🎉",
            ["description"] = "Rewards gained from the last dungeon run:",
            ["type"] = "rich",
            ["color"] = 0x1EAD3D,
            ["author"] = {
                ["name"] = "Account: " .. (accountName ~= "" and accountName or player.Name)
            },
            ["footer"] = {["text"] = "twvz | " .. os.date("%Y-%m-%d %H:%M:%S")}
        }
    
        if #fields > 0 then
            embedData["fields"] = fields
        else
            embedData["description"] = "Dungeon completed! No net gains detected (items may be at max capacity)."
        end
    
        local data = {
            ["content"] = "",
            ["embeds"] = { embedData }
        }
    
        local headers = {["content-type"] = "application/json"}
        local requestData = {
            Url = webhookUrl,
            Body = HttpService:JSONEncode(data),
            Method = "POST",
            Headers = headers
        }
    
        if request then
            local success, response = pcall(request, requestData)
            if not success then
                warn("Dungeon Webhook send failed: " .. tostring(response))
            end
        end
    end
    
    getgenv().initialDungeonTickets = 0
    getgenv().initialDungeonCommonDust = 0
    getgenv().initialDungeonRareDust = 0
    getgenv().initialDungeonLegendaryDust = 0
    getgenv().isInDungeonForTracking = false
    getgenv().dungeonCompletionSent = false
    
    _G.getRawInventory = function()
        local inventory = {
            Tickets = 0,
            Common = 0,
            Rare = 0,
            Legendary = 0
        }
        local leaderstats = player:FindFirstChild("leaderstats")
        if not leaderstats then
            return inventory
        end
    
        local inventoryFolder = leaderstats:FindFirstChild("Inventory")
        if not inventoryFolder then
            return inventory
        end
    
        local items = inventoryFolder:FindFirstChild("Items")
        if not items then
            return inventory
        end
    
        local ticketItem = items:FindFirstChild("Ticket")
        if ticketItem then
            inventory.Tickets = ticketItem:GetAttribute("Amount") or 0
        end
    
        local commonItem = items:FindFirstChild("EnchCommon")
        if commonItem then
            inventory.Common = commonItem:GetAttribute("Amount") or 0
        end
    
        local rareItem = items:FindFirstChild("EnchRare")
        if rareItem then
            inventory.Rare = rareItem:GetAttribute("Amount") or 0
        end
    
        local legendaryItem = items:FindFirstChild("EnchLegendary")
        if legendaryItem then
            inventory.Legendary = legendaryItem:GetAttribute("Amount") or 0
        end
    
        inventory.Tickets = tonumber(inventory.Tickets) or 0
        inventory.Common = tonumber(inventory.Common) or 0
        inventory.Rare = tonumber(inventory.Rare) or 0
        inventory.Legendary = tonumber(inventory.Legendary) or 0
    
        return inventory
    end
    
    
    _G.trackDungeonStartInventory = function()
        local initialRead = _G.getRawInventory()
    
        task.wait(0.5)
    
        local startInventory = _G.getRawInventory()
    
        getgenv().initialDungeonTickets = startInventory.Tickets
        getgenv().initialDungeonCommonDust = startInventory.Common
        getgenv().initialDungeonRareDust = startInventory.Rare
        getgenv().initialDungeonLegendaryDust = startInventory.Legendary
        getgenv().isInDungeonForTracking = true
        getgenv().dungeonCompletionSent = false
    end
    
    local function createFloorList()
        local rooms = {"None"}
        for i = 1, 100 do
            table.insert(rooms, tostring(i))
        end
        return rooms
    end
    
    local exchangeItemMap = {
        ["Guild Ticket"] = "GuildTicket",
        ["Rank Up Rune"] = "DgURankUpRune",
        ["Rare (10) -> Legendary (1)"] = "EnchLegendary",
        ["Legendary (1) -> Rare (1)"] = "EnchRare2",
        ["Common (10) -> Rare (1)"] = "EnchRare",
        ["Rare (1) -> Common (1)"] = "EnchCommon"
    }
    
    local function ExecuteExchange(itemName)
        if not itemName then return false end
    
        local args = {
            [1] = {
                [1] = {
                    ["Action"] = "Buy",
                    ["Shop"] = "ExchangeShop",
                    ["Item"] = itemName,
                    ["Event"] = "ItemShopAction"
                },
                [2] = "\010"
            }
        }
    
        local success, err = pcall(function()
            dataRemoteEvent:FireServer(unpack(args))
        end)
    
        if not success then
            warn("[ExecuteExchange] Error firing remote event:", err)
        end
        return success
    end
    
    local shopWorldMap = {
        WeaponShop1 = "SoloWorld",
        WeaponShop2 = "NarutoWorld",
        WeaponShop3 = "OPWorld",
        WeaponShop4 = "BleachWorld",
        WeaponShop5 = "BCWorld",
        WeaponShop6 = "ChainsawWorld",
        WeaponShop7 = "JojoWorld",
        WeaponShop8 = "DBWorld",
        WeaponShop9 = "OPMWorld",
        WeaponShop10 = "DanWorld",
        WeaponShop11 = "Solo2World"
    }
    
    local shop1Items = {
        SpikeMace = {Price = 80, Shop = "WeaponShop1"},
        GemStaff = {Price = 180, Shop = "WeaponShop1"},
        DualKando = {Price = 400, Shop = "WeaponShop1"},
        CrystalScepter = {Price = 900, Shop = "WeaponShop1"},
        DualBoneMace = {Price = 2000, Shop = "WeaponShop1"},
        DualSteelNaginata = {Price = 4500, Shop = "WeaponShop1"}
    }
    
    local shop2Items = {
        MonsterSlayer = {Price = 10000, Shop = "WeaponShop2"},
        DualBasicStaffs = {Price = 22000, Shop = "WeaponShop2"},
        PirateSaber = {Price = 49000, Shop = "WeaponShop2"},
        MixedBattleAxe = {Price = 110000, Shop = "WeaponShop2"},
        BronzeGreatAxe = {Price = 242000, Shop = "WeaponShop2"},
        DualAncientMace = {Price = 535000, Shop = "WeaponShop2"}
    }
    
    local shop3Items = {
        DualPirateSaber = {Price = 1200000, Shop = "WeaponShop3"},
        DualSteelSabers = {Price = 2500000, Shop = "WeaponShop3"},
        SteelSaber = {Price = 5650000, Shop = "WeaponShop3"},
        SteelButterfly = {Price = 12500000, Shop = "WeaponShop3"},
        DualSteelButterfly = {Price = 27500000, Shop = "WeaponShop3"},
        SteelKando = {Price = 60000000, Shop = "WeaponShop3"}
    }
    
    local shop4Items = {
        SteelNaginata = {Price = 132000000, Shop = "WeaponShop4"},
        GreatKopesh = {Price = 290000000, Shop = "WeaponShop4"},
        BoneMace = {Price = 630000000, Shop = "WeaponShop4"},
        AncientMace = {Price = 1400000000, Shop = "WeaponShop4"},
        CrimsonStaff = {Price = 3000000000, Shop = "WeaponShop4"},
        GreatSaber = {Price = 6700000000, Shop = "WeaponShop4"}
    }
    
    local shop5Items = {
        DualGreatSaber = {Price = 14070000000, Shop = "WeaponShop5"},
        BasicStaff = {Price = 28140000000, Shop = "WeaponShop5"},
        StellKopesh = {Price = 56280000000, Shop = "WeaponShop5"},
        GreatTrident = {Price = 112560000000, Shop = "WeaponShop5"},
        DualCrystalScepter = {Price = 223109999999.99997, Shop = "WeaponShop5"},
        DualTrident = {Price = 446219999999.99994, Shop = "WeaponShop5"}
    }
    
    local shop6Items = {
        OzSword2 = {Price = 840000000000, Shop = "WeaponShop6"},
        CrystalSword2 = {Price = 1680000000000, Shop = "WeaponShop6"},
        ObsidianDualAxe2 = {Price = 3360000000000, Shop = "WeaponShop6"},
        SilverSpear2 = {Price = 6720000000000, Shop = "WeaponShop6"},
        DragonAxe2 = {Price = 13319999999999.998, Shop = "WeaponShop6"},
        DualDivineAxe2 = {Price = 26639999999999.996, Shop = "WeaponShop6"}
    }
    
    local shop7Items = {
        BloodStaff2 = {Price = 42000000000000, Shop = "WeaponShop7"},
        DualCrimsonStaff2 = {Price = 84000000000000, Shop = "WeaponShop7"},
        DualGemStaffs2 = {Price = 168000000000000, Shop = "WeaponShop7"},
        GreatScythe2 = {Price = 336000000000000, Shop = "WeaponShop7"},
        TwinObsidianDualStaff2 = {Price = 666000000000000, Shop = "WeaponShop7"},
        SlayerScythe2 = {Price = 1332000000000000, Shop = "WeaponShop7"}
    }
    
    local shop8Items = {
        BeholderStaff2 = {Price = 2730000000000000, Shop = "WeaponShop8"},
        TwinMixedAxe2 = {Price = 5460000000000000, Shop = "WeaponShop8"},
        TwinTrollSlayer2 = {Price = 10920000000000000, Shop = "WeaponShop8"},
        RuneAxe2 = {Price = 21840000000000000, Shop = "WeaponShop8"},
        DualSilverSpear2 = {Price = 43290000000000000, Shop = "WeaponShop8"},
        DualDragonAxe2 = {Price = 86580000000000000, Shop = "WeaponShop8"}
    }
    
    local shop9Items = {
        SteelSword2 = {Price = 169130000000000000, Shop = "WeaponShop9"},
        SteelSpear2 = {Price = 338260000000000000, Shop = "WeaponShop9"},
        StarSpear2 = {Price = 559520000000000000, Shop = "WeaponShop9"},
        BoneStaff2 = {Price = 1119040000000000000, Shop = "WeaponShop9"},
        SunGreatAxe2 = {Price = 2405390000000000000, Shop = "WeaponShop9"},
        EnergyGreatSword2 = {Price = 5200780000000000000, Shop = "WeaponShop9"}
    }
    
    local shop10Items = {
        SteelAxe2 = {Price = 1066000000000000000, Shop = "WeaponShop10"},
        SteelGreatAxe2 = {Price = 2158000000000000000, Shop = "WeaponShop10"},
        TwinBeholderStaffs2 = {Price = 4498000000000000000, Shop = "WeaponShop10"},
        ObisidianGlaive2 = {Price = 9178000000000000000, Shop = "WeaponShop10"},
        DualSunGreatAxe2 = {Price = 19578000000000000000, Shop = "WeaponShop10"},
        DivineHammer2 = {Price = 42250000000000000000, Shop = "WeaponShop10"},
    }
    
    local shop11Items = {
        CrossSword2 = {Price = 8872500000000001, Shop = "WeaponShop11"},
        DualDivineBattleAxe2 = {Price = 19012500000000000, Shop = "WeaponShop11"},
        EyeSword2 = {Price = 38025000000000000, Shop = "WeaponShop11"},
        FaithSword2 = {Price = 76050000000000000, Shop = "WeaponShop11"},
        DualKrakenSword2 = {Price = 152100000000000000, Shop = "WeaponShop11"},
        ArchamageStaff2 = {Price = 304200000000000000, Shop = "WeaponShop11"},
    }
    
    local allShopItems = {}
    for name, data in pairs(shop1Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop2Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop3Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop4Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop5Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop6Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop7Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop8Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop9Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop10Items) do
        allShopItems[name] = data
    end
    for name, data in pairs(shop11Items) do
        allShopItems[name] = data
    end
    
    local dropdownValues = {}
    for name, data in pairs(allShopItems) do
        local worldName = shopWorldMap[data.Shop] or "Unknown"
        local formattedPrice = _G.FormatNumber(data.Price)
        table.insert(dropdownValues, name .. " | " .. formattedPrice .. " | " .. worldName)
    end
    
    table.sort(dropdownValues, function(a, b)
        local priceA = a:match(" | ([^|]+) |")
        local priceB = b:match(" | ([^|]+) |")
        
        local numA = 0
        local numB = 0
        
        if priceA then
            if priceA:find("K") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000
            elseif priceA:find("M") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000000
            elseif priceA:find("B") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000000000
            elseif priceA:find("T") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000000000000
            elseif priceA:find("Qa") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000000000000000
            elseif priceA:find("Qi") then
                numA = tonumber(priceA:match("([%d%.]+)")) * 1000000000000000000
            else
                numA = tonumber(priceA) or 0
            end
        end
        
        if priceB then
            if priceB:find("K") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000
            elseif priceB:find("M") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000000
            elseif priceB:find("B") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000000000
            elseif priceB:find("T") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000000000000
            elseif priceB:find("Qa") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000000000000000
            elseif priceB:find("Qi") then
                numB = tonumber(priceB:match("([%d%.]+)")) * 1000000000000000000
            else
                numB = tonumber(priceB) or 0
            end
        end
        
        return numA < numB
    end)
    
    local function buySelectedWeapon()
        local selectedOption = Options.WeaponDropdown.Value
        if not selectedOption then
            Fluent:Notify({
                Title = "Error",
                Content = "No weapon selected",
                Duration = 3
            })
            return
        end
        
        local weaponName = selectedOption:match("^([^|]+)"):gsub("%s+$", "")
        
        if not weaponName or not allShopItems[weaponName] then
            Fluent:Notify({
                Title = "Error",
                Content = "Invalid weapon selection",
                Duration = 3
            })
            return
        end
        
        local shopName = allShopItems[weaponName].Shop
        
        local args = {
            [1] = {
                [1] = {
                    ["Action"] = "Buy",
                    ["Shop"] = shopName,
                    ["Item"] = weaponName,
                    ["Event"] = "ItemShopAction"
                },
                [2] = "\010"
            }
        }
        
    
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    end
    
    local potionShopTypes = {"CoinsBoost", "DropsBoost", "ExpBoost", "GemsBoost", "ShadowBoost"}
    
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
        if Options.ToggleDungeonComplete.Value and getgenv().isInDungeonForTracking and getgenv().webhookToggles.DungeonComplete and not getgenv().dungeonCompletionSent then
            local finalInventory = _G.getRawInventory()
            local gains = {
                Tickets = math.max(0, finalInventory.Tickets - getgenv().initialDungeonTickets),
                Common = math.max(0, finalInventory.Common - getgenv().initialDungeonCommonDust),
                Rare = math.max(0, finalInventory.Rare - getgenv().initialDungeonRareDust),
                Legendary = math.max(0, finalInventory.Legendary - getgenv().initialDungeonLegendaryDust)
            }
            _G.sendWebhookDungeon(gains)
            getgenv().isInDungeonForTracking = false
            getgenv().dungeonCompletionSent = true
            getgenv().initialDungeonTickets = 0
            getgenv().initialDungeonCommonDust = 0
            getgenv().initialDungeonRareDust = 0
            getgenv().initialDungeonLegendaryDust = 0
        end
    
        task.wait(0.5)
    
        if Options.LeaveFastToggle.Value then
            local successLeave, errLeave = pcall(function()
                local leaveButton = _G.findLeaveButtonRegion()
    
                if leaveButton then
                    local previousSelection = GuiService.SelectedObject
    
                    GuiService.SelectedObject = leaveButton
                    task.wait(0.1)
    
                    if GuiService.SelectedObject == leaveButton then
                        local enterKeyCode = Enum.KeyCode.Return
    
                        for i = 1, 3 do -- Simula 3 cliques
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
        if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
    
        if Options.ToggleDungeonComplete.Value and getgenv().isInDungeonForTracking and getgenv().webhookToggles.DungeonComplete and not getgenv().dungeonCompletionSent then
            local finalInventory = _G.getRawInventory()
            local gains = {
                Tickets = math.max(0, finalInventory.Tickets - getgenv().initialDungeonTickets),
                Common = math.max(0, finalInventory.Common - getgenv().initialDungeonCommonDust),
                Rare = math.max(0, finalInventory.Rare - getgenv().initialDungeonRareDust),
                Legendary = math.max(0, finalInventory.Legendary - getgenv().initialDungeonLegendaryDust)
            }
            _G.sendWebhookDungeon(gains)
            getgenv().isInDungeonForTracking = false
            getgenv().dungeonCompletionSent = true
            getgenv().initialDungeonTickets = 0
            getgenv().initialDungeonCommonDust = 0
            getgenv().initialDungeonRareDust = 0
            getgenv().initialDungeonLegendaryDust = 0
        end
    
        getgenv().isInDungeonForTracking = false
    
        if _G.AriseSettings.Toggles.AutoRejoinDungeon then
    
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
    
                if _G.AriseSettings.Toggles.DungeonRuneOnRejoin then
                    addRune()
                end
    
                task.wait(2) -- Wait
    
                local testDungeonId = "81654360"
                startDungeonLocal(testDungeonId)
    
        else
            _G.executeLeaveSequence()
        end
    end
    
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
    
    local generateRandomName = function()
        local randomName = ""
        for i = 1, 10 do
            randomName = randomName .. string.char(math.random(97, 122))
        end
        return randomName
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
    
    --endofdef--
    
    local isInitializingUI = true
    local worldDropdownChangedConnection = nil
    
    task.wait(0.11)
    
    do
        Tabs.Main:AddSection("Farming Options")
        task.wait()
        Tabs.Main:AddDropdown("WorldDropdown", {
            Title = "Select World",
            Values = getgenv().worldList,
            Multi = false,
            Default = "SoloWorld"
        })
        task.wait()
        Tabs.Main:AddDropdown("EnemyDropdown", {
            Title = "Select Enemies",
            Values = getgenv().enemyList[Options.WorldDropdown.Value],
            Multi = true,
            Default = {}
        })
        task.wait()
        Tabs.Main:AddDropdown("MobTypeDropdown", {
            Title = "Enemy Type",
            Values = {"Normal", "Big"},
            Multi = true,
            Default = {"Normal"}
        })
        task.wait()
        local function WorldDropdownChangedHandler(Value)
            if isInitializingUI then
                 return
            end
            local newEnemyList = getgenv().enemyList[Value] or {}
            Options.EnemyDropdown:SetValues(newEnemyList)
        end
    
        worldDropdownChangedConnection = Options.WorldDropdown:OnChanged(WorldDropdownChangedHandler)
    
        Tabs.Main:AddDropdown("FarmMoveModeDropdown", {
            Title = "Move Mode",
            Description = "Slow: Tween\nFast: Teleport",
            Values = {"Slow", "Fast"},
            Default = "Fast",
            Callback = function(Value)
                _G.AriseSettings.FarmMoveMode = Value
            end
        })
        task.wait()
        Tabs.Main:AddSlider("FarmTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 150,   
            Min = 100,   
            Max = 1000,      
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.FarmTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Main:AddSlider("FarmDelaySlider", {
            Title = "Farm Delay",
            Description = "No kick >= 0.7",
            Default = 0.1,   
            Min = 0,   
            Max = 5,      
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.FarmDelay = Value
            end
        })
        task.wait()
        Tabs.Main:AddSection("Auto Farm")
        task.wait()
        Tabs.Main:AddToggle("AutoFarmToggle", {
            Title = "Auto Farm",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoFarmToggle = Value
                if Value then
                    if _G.ActivityPriority == "None" then
                        _G.ActivityPriority = "Farming"
                    end
                    spawn(function()
                        while Options.AutoFarmToggle.Value do
                            local player = game:GetService("Players").LocalPlayer
                            local character = player.Character 
                            local playerRoot = character and character:FindFirstChild("HumanoidRootPart") 
    
                            if not playerRoot then
                                task.wait(0.5)
                                continue
                            end
    
                            if _G.ActivityPriority ~= "Farming" then
                                task.wait(0.5)
                                continue
                            end
    
                            local selectedWorld = Options.WorldDropdown.Value
                            local currentWorld = getCurrentWorld()
                            if currentWorld ~= selectedWorld then
                                task.wait(1)
                                continue
                            end
    
                            local selectedEnemies = Options.EnemyDropdown.Value
                            local selectedMobTypes = Options.MobTypeDropdown.Value
    
                            local worldFolderName = getgenv().worldMap[currentWorld] or "1"
                            local worldFolder = workspace.__Main.__Enemies.Server:FindFirstChild(worldFolderName)
                            if not worldFolder then task.wait(1); continue end
    
                            local serverEnemies = worldFolder:GetChildren()
                            local nearestEnemy = nil
                            local minDistance = math.huge
    
                            for _, enemy in ipairs(serverEnemies) do
                                local isDead = enemy:GetAttribute("Dead") or false
                                local enemyId = enemy:GetAttribute("Id") or "nil"
    
                                if not isDead then
                                    local distance = (playerRoot.Position - enemy.Position).Magnitude
    
                                    local enemyIndex = tonumber(enemyId:match("%d+"))
                                    local scale = enemy:GetAttribute("Scale") or 1
                                    local isBig = scale >= 2
                                    local matchesType = (selectedMobTypes["Normal"] and not isBig) or (selectedMobTypes["Big"] and isBig)
                                    local enemyName = enemyIndex and getgenv().enemyList[currentWorld][enemyIndex] or "Unknown"
    
                                    if selectedEnemies[enemyName] and matchesType then
                                        if distance < minDistance then
                                            minDistance = distance
                                            nearestEnemy = enemy
                                        end
                                    end
                                end
                            end
    
                            if nearestEnemy then
                                local nearestEnemyPosition = nearestEnemy.Position
                                local needsToMove = minDistance > 5
                                if needsToMove then
                                    local moveMode = _G.AriseSettings.FarmMoveMode
                                    if moveMode == "Fast" then
                                        _G.MoveToEnemy(nearestEnemy.Position, "Teleport", _G.AriseSettings.FarmTweenSpeed, false)
                                    else
                                        _G.MoveToEnemy(nearestEnemyPosition, "Tween", _G.AriseSettings.FarmTweenSpeed or 150)
                                    end
                                end
                                if hasFreePet() then
                                    _G.AttackEnemy(nearestEnemy.Name)
                                end
                            end
    
                            task.wait(Options.FarmDelaySlider.Value)
                        end
    
                        if _G.ActivityPriority == "Farming" then
                             _G.ActivityPriority = "None"
                        end
                        local finalCharacter = game:GetService("Players").LocalPlayer.Character
                        local finalPlayerRoot = finalCharacter and finalCharacter:FindFirstChild("HumanoidRootPart")
                        if finalPlayerRoot then finalPlayerRoot.Anchored = false end
                    end)
                    spawn(function()
                        while Options.AutoFarmToggle.Value do
                           _G.CloseAnyOpenMenu()
                           task.wait(1)
                        end
                    end)
                else
                    if _G.ActivityPriority == "Farming" then
                        _G.ActivityPriority = "None"
                    end
                    local finalCharacter = game:GetService("Players").LocalPlayer.Character
                    local finalPlayerRoot = finalCharacter and finalCharacter:FindFirstChild("HumanoidRootPart")
                    if finalPlayerRoot then finalPlayerRoot.Anchored = false end
                end
            end
        })
        task.wait()
        Tabs.Main:AddToggle("AutoSendPetsToggle", {
            Title = "Auto Send Pets to Selected",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoSendPetsToggle = Value
                if Value then
                    local selectedWorld = Options.WorldDropdown.Value
                    local currentWorld = getCurrentWorld()
                
                    spawn(function()
                        while Options.AutoSendPetsToggle.Value do
                            local success, err = pcall(function()
                                if not playerRoot then 
                                    task.wait(1)
                                    return 
                                end
                            
                                local selectedEnemies = Options.EnemyDropdown.Value or {}
                                local selectedMobTypes = Options.MobTypeDropdown.Value or {Normal = false, Big = false}
                            
                                local worldFolderName = getgenv().worldMap[currentWorld] or "1"
                                local worldFolder = workspace.__Main.__Enemies.Server:FindFirstChild(worldFolderName)
                                if not worldFolder then 
                                    task.wait(1)
                                    return 
                                end
                            
                                local serverEnemies = worldFolder:GetChildren()
                                local nearestEnemy = nil
                                local minDistance = math.huge
                            
                                for _, enemy in ipairs(serverEnemies) do
                                    local isDead = enemy:GetAttribute("Dead") or false
                                    local enemyId = enemy:GetAttribute("Id") or "nil"
                                    if not isDead then
                                        local enemyIndex = tonumber(enemyId:match("%d+"))
                                        local scale = enemy:GetAttribute("Scale") or 1
                                        local isBig = scale >= 2
                                        local matchesType = (selectedMobTypes["Normal"] and not isBig) or (selectedMobTypes["Big"] and isBig)
                                        local enemyName = enemyIndex and getgenv().enemyList[currentWorld][enemyIndex] or "Unknown"
                                        if selectedEnemies[enemyName] and matchesType then
                                            local enemyRoot = enemy:IsA("BasePart") and enemy or enemy:FindFirstChildWhichIsA("BasePart")
                                            if enemyRoot then
                                                local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
                                                if distance < minDistance then
                                                    minDistance = distance
                                                    nearestEnemy = enemy
                                                end
                                            end
                                        end
                                    end
                                end
                            
                                if nearestEnemy and hasFreePet() then
                                    _G.AttackEnemy(nearestEnemy.Name)
                                end
                            end)
                        
                            if not success then
                                warn("AutoSendPets Error:", err)
                            end
                            task.wait()
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Main:AddToggle("AutoAttackNearestToggle", {
            Title = "Auto Attack Nearest Enemy",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoAttackNearestToggle = Value
                if Value then
                    spawn(function()
                        while Options.AutoAttackNearestToggle.Value do
                            local nearestEnemy = getNearestEnemyGlobal()
                            if nearestEnemy and hasFreePet() then
                                if _G.IsEnemyAlive(nearestEnemy) then
                                    _G.AttackEnemy(nearestEnemy.Name)
                                    task.wait(0.5)
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Main:AddSection("Auto Click Options")
        task.wait()
        Tabs.Main:AddSlider("AutoClickDelaySlider", {
            Title = "Auto Click Delay",
            Default = 0,   
            Min = 0,   
            Max = 1,      
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.AutoClickDelay = Value
            end
        })
        task.wait()
        Tabs.Main:AddToggle("AutoClickToggle", {
            Title = "Auto Click",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoClickToggle = Value
                if Value then
                    spawn(function()
                        while Options.AutoClickToggle.Value do
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
                            
                            task.wait(Options.AutoClickDelaySlider.Value)
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Main:AddSection("Filtered Action Options")
        task.wait()
        Tabs.Main:AddDropdown("AriseEnemiesDropdown", {
            Title = "Arise",
            Values = getgenv().enemyBaseNamesForDropdown,
            Multi = true, Default = {},
        })
        task.wait()
        Tabs.Main:AddDropdown("AriseEnemyTypesDropdown", {
            Title = "Arise - Sizes",
            Values = {"Normal", "Big"}, Multi = true, Default = {"Normal", "Big"},
        })
        task.wait()
        Tabs.Main:AddDropdown("DestroyEnemiesDropdown", {
            Title = "Destroy",
            Values = getgenv().enemyBaseNamesForDropdown,
            Multi = true, Default = {},
        })
        task.wait()
        Tabs.Main:AddDropdown("DestroyEnemyTypesDropdown", {
            Title = "Destroy - Sizes",
            Values = {"Normal", "Big"}, Multi = true, Default = {"Normal", "Big"},
        })
        task.wait()
        Tabs.Main:AddToggle("ActionToggle", {
            Title = "Activate Filtered Action",
            Default = false,
            Callback = function(Value)
                if Value then
                    if Options.SimpleActionToggle.Value then
                        Options.ActionToggle:SetValue(false)
                        Fluent:Notify({
                            Title = "Warning",
                            Content = "Simple Action cannot be used with Filtered Action",
                            Duration = 3
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
        
                        while Options.ActionToggle.Value do    
                                local playerRoot = getPlayerRoot()
                                updateDeadEnemies()
        
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
                                            local ariseEnemies = Options.AriseEnemiesDropdown.Value or {}
                                            local ariseTypes = Options.AriseEnemyTypesDropdown.Value or {}
                                            local destroyEnemies = Options.DestroyEnemiesDropdown.Value or {}
                                            local destroyTypes = Options.DestroyEnemyTypesDropdown.Value or {}
        
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
        Tabs.Main:AddSection("Simple Action Options")
        task.wait()
        Tabs.Main:AddDropdown("ActionDropdown", {
            Title = "Action",
            Values = {"Arise", "Destroy"},
            Default = "Arise",
        })
        task.wait()
        Tabs.Main:AddToggle("SimpleActionToggle", {
            Title = "Activate Action",
            Default = false,
            Callback = function(Value)
                if Value then
                    if Options.ActionToggle.Value then
                        Options.SimpleActionToggle:SetValue(false)
                        Fluent:Notify({
                            Title = "Warning",
                            Content = "Filtered Action cannot be used with Simple Action",
                            Duration = 3
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
                        
                        while Options.SimpleActionToggle.Value do
                                local playerRoot = getPlayerRoot()
                                updateDeadEnemies()
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
                                        local action = Options.ActionDropdown.Value
    
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
    end
    
    do
        Tabs.Winter:AddSection("Winter Options")
        Tabs.Winter:AddButton({
            Title = "Teleport to Winter Island",
            Callback = function()
                _G.teleportToWinterIsland()
            end
        })
        task.wait()
        Tabs.Winter:AddDropdown("WinterMoveModeDropdown", {
            Title = "Winter Move Mode",
            Values = {"Slow", "Fast"},
            Default = "Slow",
            Callback = function(Value)
                _G.AriseSettings.WinterMoveMode = Value
            end
        })
    
        Tabs.Winter:AddSlider("WinterTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 150,
            Min = 100,
            Max = 1000,
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.WinterTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Winter:AddSlider("WinterFarmDelaySlider", {
            Title = "Winter Farm Delay",
            Description = "No kick >= 0.7",
            Default = 0.1,
            Min = 0,
            Max = 5,
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.WinterFarmDelay = Value
            end
        })
    
        getgenv().WINTER_EVENT_POSITION = CFrame.new(4755.9140625, 29.726438522338867, -2026.7510986328125)
        local MIN_DISTANCE_WINTER = 700
    
        _G.teleportToWinterIsland = function(mode)
            local playerRoot = getPlayerRoot()
            if not playerRoot then return end
            local currentPosition = playerRoot.Position
            local distance = (currentPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude
            local adjustedPosition = getgenv().WINTER_EVENT_POSITION
    
            if distance > MIN_DISTANCE_WINTER then
                local restoreInTp = _G.StepTeleport(adjustedPosition.Position)
                if restoreInTp then restoreInTp() end
    
                playerRoot.Anchored = true
                playerRoot.CFrame = adjustedPosition
    
                local maxWaitTime = 10
                local waitStart = tick()
                local groundLoaded = false
                while not groundLoaded and (tick() - waitStart < maxWaitTime) do
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {player.Character}
                    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local raycastResult = workspace:Raycast(adjustedPosition.Position + Vector3.new(0, 5, 0), Vector3.new(0, -15, 0), rayParams)
                    if raycastResult and raycastResult.Instance and raycastResult.Instance.CanCollide then
                        groundLoaded = true
                    end
                    task.wait(0.1)
                end
                playerRoot.Anchored = false
            end
        end
    
        _G.IsInWinterIsland = function()
            local root = getPlayerRoot()
            if not root then return false end
            local playerPosition = root.Position
            local distance = (playerPosition - getgenv().WINTER_EVENT_POSITION.Position).Magnitude
            return distance < MIN_DISTANCE_WINTER
        end
    
        getgenv().winterIgnoreMobs = {
            ['Elf Soldier'] = {'WElf1'},
            ['High Frost'] = {'WElf2'},
            ['Laruda'] = {'WBoss'},
            ['Snow Monarch'] = {'WBoss2'},
            ['Metal'] = {'WIron'},
            ['Winter Bear'] = {'WBear'}
        }
    
        local function getReadableNameFromInstance(enemyInstance)
             if not enemyInstance or not enemyInstance:IsA("BasePart") then return nil end
             local enemyId = enemyInstance:GetAttribute("Id")
             return getgenv().enemyIdMap and enemyId and getgenv().enemyIdMap[enemyId]
        end
    
        _G.shouldIgnoreWinterMob = function(enemyReadableName)
            if not enemyReadableName then return false end
    
            local ignoredMobs = _G.AriseSettings.WinterIgnoreMobs or {}
    
            if type(ignoredMobs) ~= "table" then
                warn("ignoredMobs is not a table:", ignoredMobs)
                return false
            end
    
            for ignoredNameKey, _ in pairs(ignoredMobs) do
                if ignoredNameKey == enemyReadableName then
                    return true
                end
            end
    
            return false
        end
    
        local winterMobNames = {}
        for mobName, _ in pairs(getgenv().winterIgnoreMobs or {}) do
            table.insert(winterMobNames, mobName)
        end
        table.sort(winterMobNames)
    
        Tabs.Winter:AddDropdown("WinterIgnoreMobs", {
            Title = "Winter Ignore Mobs",
            Values = winterMobNames,
            Multi = true,
            Default = {},
            Callback = function(Value)
                _G.AriseSettings.WinterIgnoreMobs = Value
            end
        })
    
        -- =========================================================================
    -- Configuration & Constants
    -- =========================================================================
    local NOTIFICATION_DEBOUNCE_SECONDS = 8 -- Time between similar notifications
    local HIGH_FROST_APPROX_SPAWN_SECONDS = 85
    local MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW = 8
    local POST_LARUDA_MONARCH_WAIT_SECONDS = 30 -- Specific wait time after Laruda kill
    local TELEPORT_WAIT_TIME = 2.5
    local SERVER_HOP_WAIT_TIME = 20
    
    Tabs.Winter:AddSection("Winter Event Settings")
    
    Tabs.Winter:AddToggle("WinterServerHop",{
        Title = "Server Hop",
        Default = false, -- Load saved value
        Callback = function(Value)
            _G.AriseSettings.Toggles.ServerHop = Value
        end
    })
    
    Tabs.Winter:AddSlider("WinterServerHopDelay", {
        Title = "Server Hop Delay (s)",
        Default = 30,
        Min = 10,
        Max = 30,
        Rounding = 0.5,
        Callback = function(Value)
            _G.AriseSettings.MonarchWaitTime = Value
        end
    })
    
    Tabs.Winter:AddToggle("WinterAutoFarm", {
        Title = "Auto Winter Farm",
        Default = false,
        Callback = function(Value)
            _G.AriseSettings.Toggles.AutoWinter = Value
            if Value then
                spawn(function()
                    -- State variables
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
                            
                            Fluent:Notify({ 
                                Title = title or "Auto Winter", 
                                Content = content or "", 
                                Duration = duration or 5,
                            })
                            
                            state.notifications.lastTime = currentTime
                            table.insert(state.notifications.history, 1, content)
                            
                            if #state.notifications.history > 3 then 
                                table.remove(state.notifications.history) 
                            end
                        end
                    end
    
                    local function handleOutsideEventWindow(playerRoot, currentTime)
                        if _G.ActivityPriority == "WinterFarming" then
                            
                            if Options.AutoFarmToggle.Value then
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
                        local targetMinute, targetHour = 30, currentTime.hour
                        local waitSeconds = 0
                        
                        if minutes < 30 then
                            waitSeconds = (targetMinute - minutes - 1) * 60 + (60 - seconds)
                        else
                            targetHour = (targetHour + 1) % 24
                            waitSeconds = ((targetMinute + 60) - minutes - 1) * 60 + (60 - seconds)
                        end
                        
                        waitSeconds = math.max(1, waitSeconds)
                        notify("Auto Winter Paused", 
                              "Waiting " .. math.ceil(waitSeconds) .. "s until " .. 
                              string.format("%02d:%02d", targetHour, targetMinute), 5)
    
                        local waitEndTime = tick() + waitSeconds
                        while tick() < waitEndTime and Options.WinterAutoFarm.Value do
                            local now = os.date("*t")
                            if (now.min >= 30 and now.min < 45) then break end
                            task.wait(1)
                        end
                        
                        return true
                    end
    
                    local function handleCompletedCycle(playerRoot, currentTime)
                        --notify("Auto Winter", "Event cycle completed this window. Waiting.", 5)
                        
                        if Options.AutoFarmToggle.Value then
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
    
                        local minutes, seconds = currentTime.min, currentTime.sec
                        local waitSeconds = (45 - minutes - 1) * 60 + (60 - seconds)
                        waitSeconds = math.max(1, waitSeconds)
                        
                        notify("Auto Winter", 
                              "Waiting " .. math.ceil(waitSeconds) .. "s until event window ends (xx:45).", 5)
    
                        local waitEndTime = tick() + waitSeconds
                        while tick() < waitEndTime and Options.WinterAutoFarm.Value do
                            local now = os.date("*t")
                            if not (now.min >= 30 and now.min < 45) then break end
                            task.wait(1)
                        end
                        
                        return true
                    end
    
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
    
                    local function processWinterEnemies(playerRoot)
                        local serverFolder = workspace:FindFirstChild("__Main") and 
                                           workspace.__Main:FindFirstChild("__Enemies") and 
                                           workspace.__Main.__Enemies:FindFirstChild("Server")
                                           
                        if not serverFolder then 
                            notify("Auto Winter Error", "Enemy folder not found.", 5)
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
    
                    local function determineTarget(enemies)
                        if not enemies then return nil end
                        
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
    
                    local function attackTarget(targetEnemy, playerRoot)
                        if not targetEnemy then return false end
                        
                        local targetName = getReadableNameFromInstance(targetEnemy)
                        local targetPosition = targetEnemy.Position
                        local distanceToTarget = (playerRoot.Position - targetPosition).Magnitude
                        
                        if distanceToTarget > 15 then
                            local moveMode = (Options.WinterMoveModeDropdown.Value) or "Slow"
                            local tweenSpeed = (Options.WinterTweenSpeedSlider.Value) or 150
                            
                            _G.MoveToEnemy(
                                targetPosition, 
                                moveMode == "Fast" and "Teleport" or "Tween", 
                                tweenSpeed, 
                                false
                            )
                            task.wait(0.1)
                        end
                        
                        if hasFreePet() then
                            _G.AttackEnemy(targetEnemy.Name)
                            
                            if targetName == "Snow Monarch" then 
                                state.lastMonarchInstance = targetEnemy
                            elseif targetName == "Laruda" then
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
    
                    local function waitForMonarch(windowStartTime, minutesIntoEvent)
                        local monarchWaitSliderValue = (Options.WinterServerHopDelay.Value) or 30
                        local canWaitForMonarch = not _G.shouldIgnoreWinterMob("Snow Monarch")
                        
                        if not (state.monarchWaitAttempted or state.bosses.snowMonarchKilled) and 
                           tonumber(minutesIntoEvent) <= tonumber(MONARCH_MAX_SPAWN_MINUTE_IN_WINDOW) and
                           canWaitForMonarch and monarchWaitSliderValue > 0 then
                            
                            local maxWaitTime, waitReason
                            
                            if state.bosses.larudaKilled then
                                maxWaitTime = POST_LARUDA_MONARCH_WAIT_SECONDS
                                waitReason = "post-Laruda"
                            else
                                maxWaitTime = monarchWaitSliderValue
                                waitReason = "slider setting"
                            end
                            
                            --[[notify("Auto Winter", 
                                  "Island clear. Waiting up to " .. string.format("%.0f", maxWaitTime) .. 
                                  "s for Monarch ("..waitReason..")...", 
                                  math.max(5, maxWaitTime), "timer")]]
                                  
                            state.monarchWaitAttempted = true
                            local waitStart = tick()
                            local foundMonarch = false
                            
                            while tick() - waitStart < maxWaitTime and 
                                  Options.WinterAutoFarm.Value and 
                                  not state.bosses.snowMonarchKilled do
                                
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
                                    --notify("Auto Winter", "Snow Monarch detected during wait!", 3, "success")
                                    break
                                end
                                
                                task.wait(1)
                            end
                            
                            return true
                        end
                        
                        return false
                    end
    
                    local function finishEventCycle(playerRoot)
                        state.cycleCompleted = true
                        
                        if Options.WinterServerHop.Value then
                            --notify("Auto Winter", "Event cycle complete. Hopping server...", 5, "loading")
                            task.wait(1.5)
                            
                            for i = 1, 3 do
                                _G.HopToServer()
                                task.wait(15)
                            end
                            
                            --notify("Auto Winter", "Server hop initiated. Waiting...", SERVER_HOP_WAIT_TIME, "timer")
                            task.wait(SERVER_HOP_WAIT_TIME)
                            
                            state.bosses.snowMonarchKilled = false
                            state.bosses.larudaKilled = false
                            state.monarchWaitAttempted = false
                            state.lastMonarchInstance = nil
                            state.cycleCompleted = false
                            state.notifications.history = {}
                        else
                            if Options.AutoFarmToggle.Value then
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
                            
                            local currentTime = os.date("*t")
                            local minutes, seconds = currentTime.min, currentTime.sec
                            local waitSeconds = (45 - minutes - 1) * 60 + (60 - seconds)
                            waitSeconds = math.max(1, waitSeconds)
                            
                            local waitEndTime = tick() + waitSeconds
                            while tick() < waitEndTime and Options.WinterAutoFarm.Value do
                                local now = os.date("*t")
                                if not (now.min >= 30 and now.min < 45) then break end
                                task.wait(1)
                            end
                        end
                        
                        return true
                    end
    
                    local function handleEmptyIsland(enemies, windowStartTime, minutesIntoEvent)
                        if enemies.aliveCount > 0 then return false end
                        
                        if not enemies.bosses.highFrost and 
                           not enemies.bosses.laruda and 
                           not enemies.bosses.snowMonarch and 
                           windowStartTime < HIGH_FROST_APPROX_SPAWN_SECONDS and 
                           not _G.shouldIgnoreWinterMob("High Frost") then
                            
                            local waitTime = math.max(1, HIGH_FROST_APPROX_SPAWN_SECONDS - windowStartTime)
                            notify("Auto Winter", 
                                  "Waiting for High Frost (" .. string.format("%.0f", waitTime) .. "s left)...", 
                                  math.min(5, waitTime))
                                  
                            task.wait(waitTime)
                            return true
                        end
                        
                        if waitForMonarch(windowStartTime, minutesIntoEvent) then
                            return true
                        end
                        
                        finishEventCycle(getPlayerRoot())
                        return true
                    end
    
                    -- Main loop
                    while Options.WinterAutoFarm.Value do
                        local loopStartTime = tick()
                        local playerRoot = getPlayerRoot()
                        
                        if not playerRoot then 
                            task.wait(5)
                            continue
                        end
                        
                        if not Options.WinterAutoFarm.Value then break end
                        
                        local currentTime = os.date("*t")
                        local minutes, seconds = currentTime.min, currentTime.sec
                        local isEventWindow = (minutes >= 30 and minutes < 45)
                        
                        if isEventWindow and not state.inEventWindow then
                            notify("Auto Winter", "Event window (30-45) started. Status reset.", 4, "info")
                            state.bosses.snowMonarchKilled = false
                            state.bosses.larudaKilled = false
                            state.monarchWaitAttempted = false
                            state.lastMonarchInstance = nil
                            state.cycleCompleted = false
                            state.notifications.history = {}
                        end
                        state.inEventWindow = isEventWindow
                        
                        if _G.IsInDungeon() or _G.IsInCastle() then
                            --notify("Auto Winter Paused", "Inside Dungeon/Castle.", 5, "warning")
                            if _G.ActivityPriority == "WinterFarming" then 
                                _G.ActivityPriority = state.previousPriority or "None" 
                            end
                            task.wait(5)
                            continue
                        end
                        
                        if not isEventWindow then
                            handleOutsideEventWindow(playerRoot, currentTime)
                            continue
                        end
                        
                        if state.cycleCompleted then
                            handleCompletedCycle(playerRoot, currentTime)
                            continue
                        end
                        
                        if _G.ActivityPriority ~= "WinterFarming" then
                            state.previousPriority = _G.ActivityPriority
                            _G.ActivityPriority = "WinterFarming"
                            task.wait(0.1)
                        end
                        
                        if not _G.IsInWinterIsland() then
                            --notify("Auto Winter", "Teleporting to Winter Island...", 4, "loading")
                            _G.TeleportTo(getgenv().WINTER_EVENT_POSITION)
                            task.wait(TELEPORT_WAIT_TIME)
                            
                            playerRoot = getPlayerRoot()
                            if not playerRoot then 
                                --notify("Auto Winter Error", "Player lost after TP.", 5, "error")
                                task.wait(5)
                                continue
                            end
                            
                            if playerRoot then playerRoot.Anchored = false end
                            
                            if not _G.IsInWinterIsland() then 
                                --notify("Auto Winter Error", "Failed TP to Winter Island.", 5, "error")
                                task.wait(3)
                                continue
                            end
                        end
                        
                        checkMonarchStatus()
                        
                        local enemies = processWinterEnemies(playerRoot)
                        if not enemies then 
                            task.wait(5)
                            continue 
                        end
                        
                        local windowStartMinute = 30
                        local secondsSinceWindowStart = (minutes - windowStartMinute) * 60 + seconds
                        local minutesIntoEvent = tonumber(secondsSinceWindowStart / 60)
                        
                        local targetEnemy = determineTarget(enemies)
                        
                        if targetEnemy then
                            state.monarchWaitAttempted = false
                            attackTarget(targetEnemy, playerRoot)
                        else
                            if handleEmptyIsland(enemies, secondsSinceWindowStart, minutesIntoEvent) then
                                continue
                            end
                        end
                        
                        local delay = (Options.WinterFarmDelaySlider.Value) or 0.5
                        local elapsedTime = tick() - loopStartTime
                        if elapsedTime < delay then 
                            task.wait(delay - elapsedTime) 
                        else 
                            task.wait() 
                        end
                    end
                    
                    if _G.ActivityPriority == "WinterFarming" then
                        if Options.AutoFarmToggle.Value then
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
                if _G.ActivityPriority == "WinterFarming" then
                    if Options.AutoFarmToggle.Value then 
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
    end
    
    do
        Tabs.Dungeon:AddSection("Dungeon Options")
        task.wait()
        Tabs.Dungeon:AddToggle("AutoDungeonToggle", {
            Title = "Auto Dungeon",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoDungeon = Value
        
                if Value then
                    spawn(function()
                        local function searchForDungeonFast(selectedWorlds, selectedRanks)
                            local foundDungeon = false
                            local foundDungeonWorld = nil
                            local foundDungeonInstance = nil
                            local checkedWorlds = {}
        
                            if _G.AriseSettings.PreferredDungeonWorld and selectedWorlds[_G.AriseSettings.PreferredDungeonWorld] then
                                if _G.ActivityPriority == "Raiding" then
                                    checkedWorlds[_G.AriseSettings.PreferredDungeonWorld] = true
                                else
                                    local worldName = _G.AriseSettings.PreferredDungeonWorld
                                    checkedWorlds[worldName] = true
                                    local restoreInTp = _G.StepTeleport(_G.worldSpawns[worldName].Position)
                                    task.wait(_G.AriseSettings.DungeonActionDelay or 1)
                                    local dungeonInstance = workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                                    if dungeonInstance then
                                        local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
                                        local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
                                        local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
                                        if dungeonWorldAttr == worldName and selectedRanks[rankName] then
                                            foundDungeon = true
                                            foundDungeonWorld = worldName
                                            foundDungeonInstance = dungeonInstance
                                        end
                                    end
                                    if restoreInTp then restoreInTp() end
                                end
                            end
        
                            if not foundDungeon then
                                for worldName, isSelected in pairs(selectedWorlds) do
                                    if not Options.AutoDungeonToggle.Value then break end
                                    if isSelected and not checkedWorlds[worldName] then
                                        if _G.ActivityPriority == "Raiding" then
                                        else
                                            local restoreInTp = _G.StepTeleport(_G.worldSpawns[worldName].Position)
                                            task.wait(_G.AriseSettings.DungeonActionDelay or 1)
                                            local dungeonInstance = workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                                            if dungeonInstance then
                                                local dungeonWorldAttr = dungeonInstance:GetAttribute("Dungeon")
                                                local dungeonRankAttr = dungeonInstance:GetAttribute("DungeonRank")
                                                local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
                                                if dungeonWorldAttr == worldName and selectedRanks[rankName] then
                                                    foundDungeon = true
                                                    foundDungeonWorld = worldName
                                                    foundDungeonInstance = dungeonInstance
                                                    _G.AriseSettings.PreferredDungeonWorld = worldName
                                                end
                                            end
                                            if restoreInTp then restoreInTp() end
                                            if foundDungeon then break end
                                        end
                                    end
                                end
                            end
                            return foundDungeon, foundDungeonWorld, foundDungeonInstance
                        end
        
                        while Options.AutoDungeonToggle.Value do
                            if _G.IsInDungeon() then
                                break
                            end
        
                            if not playerRoot then
                                task.wait(1)
                                playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                if not playerRoot then
                                    Fluent:Notify({ Title = "Error", Content = "Player character not loaded!", Duration = 3 })
                                    task.wait(5)
                                end
                            end
        
                            
                                if _G.ActivityPriority == "Raiding" or _G.ActivityPriority == "WinterFarming" then
                                    task.wait(5)
                                else
                                    local currentTime = os.date("*t")
                                    local minutes = currentTime.min
                                    local seconds = currentTime.sec
        
                                    local isActiveWindow = (minutes >= 0 and minutes < 15) or 
                                                          (minutes >= 15 and minutes < 30) or 
                                                          (minutes >= 30 and minutes < 45) or 
                                                          (minutes >= 45 and minutes <= 59)
        
                                    local isIntervalSecond = (minutes == 14 or minutes == 29 or minutes == 44 or minutes == 59) and seconds >= 59
        
                                    if isActiveWindow and not isIntervalSecond then
                                        local selectedWorlds = Options.SearchWorldsDropdown.Value
                                        local selectedRanks = Options.DungeonRankDropdown.Value
                                        local hasSelectedWorlds = false; for _, v in pairs(selectedWorlds) do if v then hasSelectedWorlds = true; break end end
                                        local hasSelectedRanks = false; for _, v in pairs(selectedRanks) do if v then hasSelectedRanks = true; break end end
        
                                        if not hasSelectedWorlds then
                                            Fluent:Notify({ Title = "Error", Content = "No worlds selected to search!", Duration = 5 })
                                            task.wait(5)
                                        elseif not hasSelectedRanks then
                                            Fluent:Notify({ Title = "Error", Content = "No ranks selected!", Duration = 5 })
                                            task.wait(5)
                                        else
                                            local currentWorld = getCurrentWorld()
                                            local foundAndEntered = false
        
                                            if selectedWorlds[currentWorld] then
                                                local dungeon = workspace.__Main.__Dungeon:FindFirstChild("Dungeon")
                                                if dungeon then
                                                    local dungeonWorldAttr = dungeon:GetAttribute("Dungeon")
                                                    local dungeonRankAttr = dungeon:GetAttribute("DungeonRank")
                                                    local rankName = dungeonRankMap[dungeonRankAttr] or tostring(dungeonRankAttr)
        
                                                    if dungeonWorldAttr == currentWorld and selectedRanks[rankName] then
                                                        createDungeon()
                                                        task.wait(0.2)
                                                        if Options.DungeonRuneToggle.Value then
                                                            addRune()
                                                        end
                                                        task.wait(0.2)
                                                        startDungeon()
                                                        foundAndEntered = true
                                                        break
                                                    end
                                                end
                                            end
        
                                            if not foundAndEntered then
                                                local foundDungeon, foundDungeonWorld, foundDungeonInstance = searchForDungeonFast(selectedWorlds, selectedRanks)
        
                                                if foundDungeon and foundDungeonInstance then
                                                    local foundRankName = dungeonRankMap[foundDungeonInstance:GetAttribute("DungeonRank")] or "??"
                                                    createDungeon()
                                                    task.wait(0.2)
                                                    if Options.DungeonRuneToggle.Value then
                                                        addRune()
                                                    end
                                                    task.wait(0.2)
                                                    startDungeon()
                                                    foundAndEntered = true
                                                    break
                                                end
                                            end
        
                                            if not foundAndEntered then
                                                local waitSeconds = 0
                                                local targetMinute = 0
                                                local targetHour = currentTime.hour
        
                                                if minutes >= 0 and minutes < 15 then
                                                    waitSeconds = (14 - minutes) * 60 + (60 - seconds)
                                                    targetMinute = 15
                                                elseif minutes >= 15 and minutes < 30 then
                                                    waitSeconds = (29 - minutes) * 60 + (60 - seconds)
                                                    targetMinute = 30
                                                elseif minutes >= 30 and minutes < 45 then
                                                    waitSeconds = (44 - minutes) * 60 + (60 - seconds)
                                                    targetMinute = 45
                                                elseif minutes >= 45 then
                                                    waitSeconds = (59 - minutes) * 60 + (60 - seconds)
                                                    targetMinute = 0
                                                    targetHour = (targetHour + 1) % 24
                                                end
        
                                                Fluent:Notify({ Title = "Auto Dungeon", Content = "No suitable dungeon found. Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetHour, targetMinute) .. "", Duration = 5 })
                                                if Options.AutoFarmToggle.Value then
                                                    Options.AutoFarmToggle:SetValue(false)
                                                    task.wait(0.2)
                                                    Options.AutoFarmToggle:SetValue(true)
                                                end
                                                if _G.SavedFarmPosition then
                                                    local currentCheckWorld = getCurrentWorld()
                                                    local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                                    if currentCheckWorld ~= targetWorld then
                                                        _G.TeleportTo(_G.SavedFarmPosition)
                                                        task.wait(0.5)
                                                        local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                                        if currentRoot then currentRoot.Anchored = false end
                                                    end
                                                end
        
                                                local waitEndTime = tick() + waitSeconds
                                                while tick() < waitEndTime and Options.AutoDungeonToggle.Value do
                                                    task.wait(1)
                                                end
                                            end
                                        end
                                    else
                                        local waitSeconds = 0
                                        local targetMinute = 0
                                        local targetHour = currentTime.hour
        
                                        if minutes == 14 or minutes == 29 or minutes == 44 or minutes == 59 then
                                            waitSeconds = 1
                                            targetMinute = minutes + 1
                                            if minutes == 59 then
                                                targetMinute = 0
                                                targetHour = (targetHour + 1) % 24
                                            end
                                        elseif minutes >= 0 and minutes < 15 then
                                            waitSeconds = (14 - minutes) * 60 + (60 - seconds)
                                            targetMinute = 15
                                        elseif minutes >= 15 and minutes < 30 then
                                            waitSeconds = (29 - minutes) * 60 + (60 - seconds)
                                            targetMinute = 30
                                        elseif minutes >= 30 and minutes < 45 then
                                            waitSeconds = (44 - minutes) * 60 + (60 - seconds)
                                            targetMinute = 45
                                        elseif minutes >= 45 then
                                            waitSeconds = (59 - minutes) * 60 + (60 - seconds)
                                            targetMinute = 0
                                            targetHour = (targetHour + 1) % 24
                                        end
        
                                        Fluent:Notify({ Title = "Auto Dungeon Paused", Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. string.format("%02d:%02d", targetHour, targetMinute) .. "", Duration = 5 })
                                        if _G.SavedFarmPosition then
                                            local currentCheckWorld = getCurrentWorld()
                                            local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                            local farmingActive = Options.AutoFarmToggle.Value
                                            if currentCheckWorld ~= targetWorld then
                                                _G.TeleportTo(_G.SavedFarmPosition)
                                                task.wait(0.5)
                                                local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                                if currentRoot then currentRoot.Anchored = false end
                                                if farmingActive then
                                                    Options.AutoFarmToggle:SetValue(false)
                                                    task.wait(0.2)
                                                    Options.AutoFarmToggle:SetValue(true)
                                                end
                                            else
                                                if farmingActive and (_G.ActivityPriority == "None" or _G.ActivityPriority == "Farming") then
                                                    Options.AutoFarmToggle:SetValue(false)
                                                    task.wait(0.2)
                                                    Options.AutoFarmToggle:SetValue(true)
                                                end
                                            end
                                        end
        
                                        local waitEndTime = tick() + waitSeconds
                                        while tick() < waitEndTime and Options.AutoDungeonToggle.Value do
                                            task.wait(1)
                                        end
                                    end
                                end
                            task.wait(0.1)
                        end
                    end)
                else
                    if playerRoot and playerRoot.Anchored then
                        playerRoot.Anchored = false
                    end
                end
            end
        })
        task.wait()
        Tabs.Dungeon:AddDropdown("SearchWorldsDropdown", {
            Title = "Worlds to Search",
            Values = getgenv().worldList,
            Multi = true,
            Default = {["BCWorld"] = true}
        })
        task.wait()
        Tabs.Dungeon:AddDropdown("DungeonRankDropdown", {
            Title = "Ranks to Search",
            Values = {"E", "D", "C", "B", "A", "S", "SS"},
            Multi = true,
            Default = {["S"] = true}
        })
        task.wait()
        Tabs.Dungeon:AddSlider("DungeonActionDelaySlider", {
            Title = "Action Delay",
            Default = 1,
            Min = 0.1,  
            Max = 5,
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.DungeonActionDelay = Value
            end
        })
        task.wait()
        Tabs.Dungeon:AddSection("Dungeon Rune Options")
        task.wait()
        Tabs.Dungeon:AddDropdown("DungeonRuneDropdown", {
            Title = "Choose Dungeon Rune",
            Values = DgRunes,
            Multi = false,
            Default = "None"
        })
        task.wait()
        Tabs.Dungeon:AddToggle("DungeonRuneToggle", {
            Title = "Use Rune",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.DungeonRune = Value
            end
        })
        Tabs.Dungeon:AddToggle("DungeonRuneOnRejoinToggle", {
            Title = "Use Rune On Auto Rejoin",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.DungeonRuneOnRejoin = Value
            end
        })
        task.wait()
        _G.AriseSettings.DungeonActionDelay = Options.DungeonActionDelaySlider.Value or 0.1
        
        Tabs.Dungeon:AddSection("Dungeon Settings")
        task.wait()
        Tabs.Dungeon:AddToggle("AutoResetDungeonToggle", {
            Title = "Auto Reset Dungeon",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoResetDungeon = Value
                if Value then
                    resetDungeon()
                end
            end
        })
        task.wait()
        Tabs.Dungeon:AddToggle("LeaveFastToggle", {
            Title = "Leave Fast",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.LeaveFastToggle = Value
            end
        })
        task.wait()
        Tabs.Dungeon:AddToggle("AutoRejoinDungeonToggle", {
            Title = "Auto Rejoin",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoRejoinDungeon = Value
            end
        })
        task.wait()
        Tabs.Dungeon:AddSection("Dungeon Farm")
        task.wait()
        Tabs.Dungeon:AddDropdown("DungeonMoveModeDropdown", {
            Title = "Move Mode",
            Description = "Slow: Tween\nFast: Teleport",
            Values = {"Slow", "Fast"},
            Default = "Slow",
            Callback = function(Value)
                _G.AriseSettings.DungeonMoveMode = Value
            end
        })
        task.wait()
        Tabs.Dungeon:AddSlider("DungeonFarmTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 150,   
            Min = 100,   
            Max = 1000,      
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.DungeonFarmTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Dungeon:AddSlider("DungeonFarmDelaySlider", {
            Title = "Dungeon Farm Delay",
            Description = "No kick >= 0.7",
            Default = 0.1,   
            Min = 0,   
            Max = 5,      
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.DungeonFarmDelay = Value
            end
        })
        task.wait()
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
        
        Tabs.Dungeon:AddToggle("AutoFarmDungeonToggle", {
            Title = "Auto Farm Dungeon",
            Default = false,
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
       
                        while Options.AutoFarmDungeonToggle.Value and hasConfirmedEntry do
                            if _G.IsInCastle() then
                                break
                            end
        
                            local playerRoot = getPlayerRoot()
                            if not playerRoot then
                                 task.wait(0.5)
                                 continue
                            end
        
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
                                            local moveMode = Options.DungeonMoveModeDropdown.Value                                 
                                            if moveMode == "Fast" then                                        
                                                 _G.MoveToEnemy(nearestEnemyPosition, "Teleport", Options.DungeonFarmTweenSpeedSlider.Value, false)                                        
                                            else
                                                _G.MoveToEnemy(nearestEnemyPosition, "Tween", Options.DungeonFarmTweenSpeedSlider.Value)
                                            end
                                        end
    
                                        if hasFreePet() then
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
                                         _G.HandleDungeonEnd()
                                         if not _G.IsInDungeon() then
                                             hasConfirmedEntry = false 
                                         end
                                         break
                                     else
                                         isPotentiallyEnding = false
                                     end
                                end
                            end
        
                            local delay = Options.DungeonFarmDelaySlider.Value
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
        
        task.wait()
    end
    
    do
        Tabs.Castle:AddSection("Castle Options")
        Tabs.Castle:AddDropdown("CastleCheckpointDropdown",{
            Title = "Choose Checkpoint",
            Values = {"None", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"},
            Multi = false,
            Default = "None"
        })
        task.wait()
        local CheckpointToggle = Tabs.Castle:AddToggle("AutoCastleToggle", {
            Title = "Auto Castle",
            Default = false,
            Callback = function(value)
                _G.AriseSettings.Toggles.AutoCastle = value
        
                if value and _G.AriseSettings.Toggles.AutoCastleNoCheckpoint then
                    Options.AutoCastleNoCheckpointToggle:SetValue(false)
                end
        
                if value then
                    spawn(function()
                        while _G.AriseSettings.Toggles.AutoCastle do
                            if _G.IsInCastle() or _G.IsInDungeon() then
                                break
                            end
        
                            if _G.ActivityPriority == "Dungeon" or _G.ActivityPriority == "WinterFarming" then
                                task.wait(5)
                                continue
                            end
        
                            local currentTime = os.date("*t")
                            local minutes = currentTime.min
                            local isActiveWindow = minutes >= 45 and minutes < 60
        
                            if isActiveWindow then
                                if _G.ActivityPriority == "Farming" or _G.ActivityPriority == "None" then
                                    _G.ActivityPriority = "Castle"
                                end
        
                                if _G.ActivityPriority == "Castle" then
                                    if Options.CastleCheckpointDropdown.Value ~= "None" then
                                        dataRemoteEvent:FireServer(unpack({
                                            [1] = {
                                                [1] = {
                                                ["Check"] = true,
                                                ["Floor"] = Options.CastleCheckpointDropdown.Value,
                                                ["Event"] = "CastleAction",
                                                ["Action"] = "Join"
                                            },
                                            [2] = "\v"
                                            }
                                        }))
                                        task.wait(5)
                                        break
                                    else
                                        dataRemoteEvent:FireServer(unpack({
                                            [1] = {
                                                [1] = {
                                                    ["Check"] = false,
                                                    ["Event"] = "CastleAction",
                                                    ["Action"] = "Join"
                                                },
                                                [2] = "\v"
                                            }
                                        }))
                                        task.wait(5)
                                        break
                                    end
                                end
                            else
                                if _G.SavedFarmPosition then
                                    local currentCheckWorld = getCurrentWorld()
                                    local targetWorld = _G.FindNearestWorld(_G.SavedFarmPosition)
                                    local farmingActive = Options.AutoFarmToggle.Value
        
                                    if currentCheckWorld ~= targetWorld then
                                        _G.TeleportTo(_G.SavedFarmPosition)
                                        task.wait(0.5)
                                        local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                        if currentRoot then currentRoot.Anchored = false end
                                        if farmingActive then
                                            Options.AutoFarmToggle:SetValue(false)
                                            task.wait(0.2)
                                            Options.AutoFarmToggle:SetValue(true)
                                        end
                                    else
                                        if farmingActive and (_G.ActivityPriority == "None" or _G.ActivityPriority == "Farming") then
                                            Options.AutoFarmToggle:SetValue(false)
                                            task.wait(0.2)
                                            Options.AutoFarmToggle:SetValue(true)
                                        end
                                    end
                                end
        
                                local waitSeconds = 0
                                local targetMinute = 45
                                local targetHour = currentTime.hour
        
                                if minutes < 45 then
                                    waitSeconds = (45 - minutes) * 60 - currentTime.sec
                                else
                                    waitSeconds = (60 - minutes) * 60 - currentTime.sec + 45 * 60
                                    targetHour = (targetHour + 1) % 24
                                end
                                local targetTimeString = string.format("%02d:%02d", targetHour, targetMinute)
                                Fluent:Notify({
                                    Title = "Auto Castle Paused",
                                    Content = "Waiting " .. math.ceil(waitSeconds) .. "s until " .. targetTimeString,
                                    Duration = 5
                                })
        
                                local waitEndTime = tick() + waitSeconds
                                while tick() < waitEndTime and _G.AriseSettings.Toggles.AutoCastle do
                                    task.wait(1)
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                else
                    if _G.ActivityPriority == "Castle" then
                        _G.ActivityPriority = "None"
                    end
                    local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                    if playerRoot and playerRoot.Anchored then
                        playerRoot.Anchored = false
                    end
                end
            end
        })
        task.wait()
        Tabs.Castle:AddToggle("AutoResetCastleToggle", {
            Title = "Auto Reset Castle (Gems)",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoResetCastle = Value
                if Value then
                    resetCastle()
                end
            end
        })
        task.wait()
        Tabs.Castle:AddSection("Castle Settings")
        task.wait()
        Tabs.Castle:AddDropdown("CastleFloorDropdown", {
            Title = "Choose a Floor",
            Values = createFloorList(),
            Multi = false,
            Default = "None",
        })
        task.wait()
        Tabs.Castle:AddDropdown("ActionOnFloorDropdown", {
            Title = "What to Do",
            Values = {"Leave Castle", "Leave After Boss", "Do Nothing"},
            Multi = false,
            Default = "Do Nothing",
        })
        task.wait()
        Tabs.Castle:AddSection("Castle Farm")
        task.wait()
        Tabs.Castle:AddDropdown("CastleMoveModeDropdown", {
            Title = "Move Mode",
            Description = "Slow: Tween\nFast: Teleport",
            Values = {"Slow", "Fast"},
            Default = "Slow",
            Callback = function(Value)
                _G.AriseSettings.CastleMoveMode = Value
            end
        })
        task.wait()
        Tabs.Castle:AddSlider("CastleFarmTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 150,   
            Min = 100,   
            Max = 1000,      
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.CastleTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Castle:AddSlider("CastleFarmDelaySlider", {
            Title = "Castle Farm Delay",
            Description = "No kick >= 0.7",
            Default = 0.1,   
            Min = 0,   
            Max = 5,      
            Rounding = 1,
            Callback = function(Value)
                _G.AriseSettings.CastleFarmDelay = Value
            end
        })
        task.wait()
        Tabs.Castle:AddToggle("FocusBossesToggle", {
            Title = "Focus Bosses",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.FocusBosses = Value
            end
        })
        task.wait()
        local teleportedToRoom = false
        Tabs.Castle:AddToggle("AutoFarmCastleToggle", {
            Title = "Auto Farm Castle",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoFarmCastle = Value
                if Value then
                    task.wait(2)
                    spawn(function()
                        while Options.AutoFarmCastleToggle.Value do
                            if not _G.IsInCastle() then
                                break
                            end
        
                            local playerRoot = getPlayerRoot()
                            if not playerRoot then
                                task.wait(0.5)
                                continue
                            end
        
                            local currentFloor = _G.GetCurrentCastleFloor()
                            local targetFloorStr = Options.CastleFloorDropdown.Value
                            local action = Options.ActionOnFloorDropdown.Value
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
                                        _G.MoveToEnemy(room25:GetPivot().Position, "Teleport", Options.CastleFarmTweenSpeedSlider.Value, false)
                                    end)
                                    task.wait()
                                    teleportedToRoom = true
                                    continue
                                elseif room50 then
                                    pcall(function()
                                        _G.MoveToEnemy(room50:GetPivot().Position, "Teleport", Options.CastleFarmTweenSpeedSlider.Value, false)
                                    end)
                                    task.wait()
                                    teleportedToRoom = true
                                    continue
                                end
                            end
    
                            local serverFolder = workspace.__Main.__Enemies:FindFirstChild("Server")
                            local nearestEnemy = nil
                            local minDistance = math.huge
                            local nearestBossInstance = nil
                            local minBossDistance = math.huge
                            local hasAliveServerEnemy = false
                            local hasAliveBoss = false
        
                            local focusBosses = Options.FocusBossesToggle and Options.FocusBossesToggle.Value or false
        
                            local function processEnemy(enemyInstance)
                                 if not enemyInstance or not enemyInstance:IsA("BasePart") then return end
                                local isDead = enemyInstance:GetAttribute("Dead") or false
                                if not isDead then
                                    hasAliveServerEnemy = true
                                    local distance = (playerRoot.Position - enemyInstance.Position).Magnitude
        
                                    if distance < minDistance then
                                        minDistance = distance
                                        nearestEnemy = enemyInstance
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
                                 finalTargetInstance = nearestEnemy
                                 finalMinDistance = minDistance
                            end
        
                            local performedFloorAction = false
                            if targetFloorStr ~= "None" and action ~= "Do Nothing" then
                                if currentFloor and targetFloorNum then
                                    local isOnTargetFloor = (currentFloor == targetFloorNum)
                                    local canActBasedOnFloor = (currentFloor >= targetFloorNum)
        
                                    if action == "Leave Castle" and canActBasedOnFloor then
                                        Fluent:Notify({ Title = "Auto Farm Castle", Content = "Target floor " .. targetFloorStr .. " reached. Leaving Castle.", Duration = 5 })
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
                                                Fluent:Notify({ Title = "Auto Farm Castle", Content = "Boss on floor " .. targetFloorStr .. " defeated. Leaving Castle.", Duration = 5 })
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
                                                _G.MoveToEnemy(targetRoom:GetPivot().Position, "Teleport", Options.CastleFarmTweenSpeedSlider.Value, false)
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
                                        local moveMode = Options.CastleMoveModeDropdown.Value
                                        local tweenSpeed = Options.CastleFarmTweenSpeedSlider.Value or 150
                                        pcall(function()
                                            if moveMode == "Fast" then
                                                _G.MoveToEnemy(targetPosition, "Teleport", tweenSpeed, false)
                                            else
                                                _G.MoveToEnemy(targetPosition, "Tween", tweenSpeed)
                                            end
                                        end)
                                    end
        
                                    if hasFreePet() then
                                        pcall(function()
                                            _G.AttackEnemy(finalTargetInstance.Name)
                                        end)
                                    end
                                else
                                    task.wait(0.5)
                                end
                            end
        
                            task.wait(Options.CastleFarmDelaySlider.Value)
                        end
        
                        local playerRootOnExit = getPlayerRoot()
                        if playerRootOnExit and playerRootOnExit.Anchored then
                            playerRootOnExit.Anchored = false
                        end
                    end)
                else
                    local playerRootOnDisable = getPlayerRoot()
                    if playerRootOnDisable and playerRootOnDisable.Anchored then
                        playerRootOnDisable.Anchored = false
                    end
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Rank:AddSection("Rank Up Farm")
        task.wait()
        Tabs.Rank:AddButton({
            Title = "Auto Enter Test Dungeon",
            Callback = function()
                local argsChar = {
                    [1] = {
                        [1] = {
                            ["Event"] = "DungeonAction",
                            ["Action"] = "TestEnter"
                        },
                        [2] = "\010"
                    }
                }
                local argsInt = {
                    [1] = {
                        [1] = {
                            ["Event"] = "DungeonAction",
                            ["Action"] = "TestEnter"
                        },
                        [2] = "\010"
                    }
                }
                dataRemoteEvent:FireServer(unpack(argsChar))
                dataRemoteEvent:FireServer(unpack(argsInt))
            end
        })
        task.wait()
        Tabs.Rank:AddDropdown("TestDungeonMoveModeDropdown", {
            Title = "Move Mode",
            Description = "Slow: Tween\nFast: Teleport",
            Values = {"Slow", "Fast"},
            Default = "Slow",
            Callback = function(Value)
                _G.AriseSettings.TestDungeonMoveMode = Value
            end
        })
        task.wait()
        Tabs.Rank:AddSlider("TestDungeonFarmTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 150,   
            Min = 100,   
            Max = 1000,      
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.TestDungeonFarmTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Rank:AddToggle("AutoFarmTestDungeonToggle", {
            Title = "Auto Farm Test Dungeon",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoFarmDungeon = Value
                
                if Value then
                    task.wait(2)
                    if Options.AutoFarmDungeonToggle.Value then
                        Options.AutoFarmDungeonToggle:SetValue(false)
                    end
    
                    spawn(function()
                        while Options.AutoFarmTestDungeonToggle.Value do
                            if _G.IsInCastle() then
                                break
                            end
    
                            if playerRoot then
                                local serverFolder = workspace.__Main.__Enemies:FindFirstChild("Server")
                                if serverFolder then
                                    local serverEnemies = serverFolder:GetChildren()
                                    local nearestEnemy = nil
                                    local minDistance = math.huge
                                
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
        
                                    if nearestEnemy then
                                        if minDistance > 5 then
                                            local moveMode = Options.TestDungeonMoveModeDropdown.Value
                                            if moveMode == "Fast" then
                                                local distance = (playerRoot.Position - nearestEnemy.Position).Magnitude
                                                if distance > 8 then
                                                    _G.MoveToEnemy(nearestEnemy.Position, "Teleport", _G.AriseSettings.FarmTweenSpeed, false)
                                                end
                                            else
                                                _G.MoveToEnemy(nearestEnemy.Position, "Tween", _G.AriseSettings.TestDungeonFarmTweenSpeed)
                                            end
                                        end
                                        
                                        if hasFreePet() then
                                            _G.AttackEnemy(nearestEnemy.Name)
                                            task.wait(0.5)
                                        end
                                    end
                                end
                            end
                            task.wait(0.5)
                        end
                    end)
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Raid:AddSection("Raid Options")
        task.wait()
        Tabs.Raid:AddButton({
            Title = "Teleport to Jeju Island",
            Callback = function()
                teleportToJejuIsland(Options.RaidMoveModeDropdown.Value)
            end
        })
        task.wait()
        Tabs.Raid:AddDropdown("RaidMoveModeDropdown", {
            Title = "Go To Raid Mode",
            Values = {"Slow", "Fast"},
            Multi = false,
            Default = "Fast"
        })
        task.wait()
        Tabs.Raid:AddDropdown("MoveTypeDropdown", {
            Title = "Move Type",
            Values = {"Tween", "Walk"},
            Multi = false,
            Default = "Tween"
        })
        task.wait()
        Tabs.Raid:AddDropdown("FarmTypeDropdown", {
            Title = "Farm Type",
            Values = {"Ants", "Guards And Boss", "Only Boss"},
            Multi = false,
            Default = "Guards And Boss"
        })
        task.wait()
        Tabs.Raid:AddToggle("AutoRaidToggle", {
            Title = "Auto Raid",
            Default = false,
            Callback = function(Value)
                if Value and Options.AutoServerHopRaidToggle.Value then
                    Fluent:Notify({ Title = "Conflict", Content = "Auto Server Hop Raid is active. Disable it first.", Duration = 4 })
                    Options.AutoRaidToggle:SetValue(false)
                    return
                end
    
                _G.AriseSettings.Toggles.AutoRaidToggle = Value
                if Value then
                    local function hasRelevantEnemies(farmType)
                        for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                            local enemyId = enemy:GetAttribute("Id")
                            local isDead = enemy:GetAttribute("Dead") or false
                            if not isDead then
                                if farmType == "Ants" and enemyId == "JJ1" then return true
                                elseif farmType == "Guards And Boss" and (enemyId == "JJ2" or enemyId == "JJ3" or enemyId == "JJ4") then return true
                                elseif farmType == "Only Boss" and (enemyId == "JJ3" or enemyId == "JJ4") then return true
                                end
                            end
                        end
                        return false
                    end
                     local function hasAntKing()
                        for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                            local isDead = enemy:GetAttribute("Dead") or false
                            local enemyId = enemy:GetAttribute("Id") or "nil"
                            if not isDead and enemyId == "JJ4" then return true end
                        end
                        return false
                    end
                    local function hasQueen()
                       for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                            local isDead = enemy:GetAttribute("Dead") or false
                            local enemyId = enemy:GetAttribute("Id") or "nil"
                            if not isDead and enemyId == "JJ3" then return true end
                        end
                        return false
                    end
                     local function waitForKingAfterQueenDeath()
                        local wasAnchored = playerRoot and playerRoot.Anchored
    
                        if hasAntKing() then return true end
    
                        if playerRoot and not wasAnchored then
                            playerRoot.Anchored = true
                        end
    
                        local waitTime = 0
                        local maxWait = _G.AriseSettings.KingWaitTime or 15
    
                        local kingSpawned = false
                        while waitTime < maxWait do
                            if not Options.AutoRaidToggle.Value or (_G.ActivityPriority ~= "Raiding" and _G.ActivityPriority ~= "None") then
                                 break
                            end
    
                            task.wait(0.1)
                            waitTime = waitTime + 0.1
                            if hasAntKing() then
                                kingSpawned = true
                                break
                            end
                        end
    
                        if playerRoot and playerRoot.Anchored and not wasAnchored then
                            playerRoot.Anchored = false
                        end
    
                        return kingSpawned
                    end
    
                    spawn(function()
                        local previousPriority = _G.ActivityPriority
                        local returnPosition = _G.SavedFarmPosition
                        local raidCompleted = false
    
                        while Options.AutoRaidToggle.Value do
                            local currentTime = os.date("*t")
                            local minutes = currentTime.min
                            local seconds = currentTime.sec
                            local isRaidWindow = (minutes >= 16 and minutes < 30)
    
                            if _G.IsInDungeon() then
                                Fluent:Notify({ Title = "Auto Raid Paused", Content = "Currently in dungeon. Waiting...", Duration = 3 })
                                break
                            elseif not isRaidWindow then
                                local wait_seconds = 0
                                if minutes < 16 then
                                    wait_seconds = (15 - minutes) * 60 + (60 - seconds)
                                else
                                    wait_seconds = (60 + 15 - minutes) * 60 + (60 - seconds)
                                end
                                local targetHour = (currentTime.hour + (minutes >= 30 and 1 or 0)) % 24
                                Fluent:Notify({ Title = "Auto Raid Paused", Content = "Waiting " .. math.ceil(wait_seconds) .. "s until " .. string.format("%02d:16", targetHour) .. "", Duration = 5 })
                                local waitEndTime = tick() + wait_seconds
                                while tick() < waitEndTime and Options.AutoRaidToggle.Value do task.wait(1) end
                            else
                                if _G.ActivityPriority ~= "Raiding" and _G.ActivityPriority ~= "WinterFarming" then
                                    previousPriority = _G.ActivityPriority
                                    _G.ActivityPriority = "Raiding"
                                    teleportToJejuIsland(Options.RaidMoveModeDropdown.Value)
                                    task.wait(2)
                                end
    
                                if not playerRoot then
                                     Fluent:Notify({ Title = "Auto Raid Error", Content = "Player character not loaded on Jeju. Waiting...", Duration = 4 })
                                     task.wait(5)
                                else
                                    if Options.AutoAttackNearestToggle.Value then Options.AutoAttackNearestToggle:SetValue(false) end
    
                                    raidCompleted = false
                                    local attemptStartTime = tick()
                                    local maxAttemptTime = 300
    
                                    while Options.AutoRaidToggle.Value and not raidCompleted and (tick() - attemptStartTime < maxAttemptTime) do
                                         if _G.ActivityPriority ~= "Raiding" and _G.ActivityPriority ~= "WinterFarming" then
                                              break
                                         end
    
                                         if _G.IsInDungeon() or not isRaidWindow then
                                             break
                                         end
    
                                         local success, err = pcall(function()
                                             if not playerRoot then task.wait(1); return end
    
                                             local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
                                             local nearestEnemy = nil
                                             local minDistance = math.huge
                                             local farmType = Options.FarmTypeDropdown.Value
                                             local aliveAntsCount = 0
                                             local currentAntQueen = nil
                                             local currentAntKing = nil
    
                                             for _, enemy in ipairs(serverEnemies) do
                                                 local isDead = enemy:GetAttribute("Dead") or false
                                                 local enemyId = enemy:GetAttribute("Id") or "nil"
                                                 if not isDead then
                                                     local enemyPos = enemy:IsA("BasePart") and enemy.Position or (enemy:FindFirstChildWhichIsA("BasePart") and enemy:FindFirstChildWhichIsA("BasePart").Position)
    
                                                     if enemyPos then
                                                         local distance = (playerRoot.Position - enemyPos).Magnitude
    
                                                         if farmType == "Ants" and enemyId == "JJ1" then
                                                             aliveAntsCount = aliveAntsCount + 1
                                                             if distance < minDistance then minDistance = distance; nearestEnemy = enemy end
                                                         elseif farmType == "Guards And Boss" then
                                                             if enemyId == "JJ2" then -- Guards
                                                                 aliveAntsCount = aliveAntsCount + 1
                                                                 if distance < minDistance then minDistance = distance; nearestEnemy = enemy end
                                                             elseif enemyId == "JJ3" then currentAntQueen = enemy
                                                             elseif enemyId == "JJ4" then currentAntKing = enemy
                                                             end
                                                         elseif farmType == "Only Boss" then
                                                             if enemyId == "JJ3" then currentAntQueen = enemy
                                                             elseif enemyId == "JJ4" then currentAntKing = enemy
                                                             end
                                                         end
                                                     end
                                                 end
                                             end
    
                                             local targetEnemy = nil
                                             local isRaidFinishedThisCheck = false
    
                                             if farmType == "Ants" then
                                                 targetEnemy = nearestEnemy
                                                 if aliveAntsCount == 0 then isRaidFinishedThisCheck = true end
                                             elseif farmType == "Guards And Boss" then
                                                 if aliveAntsCount > 0 then
                                                     targetEnemy = nearestEnemy
                                                 else
                                                     if currentAntQueen then
                                                         targetEnemy = currentAntQueen
                                                     elseif currentAntKing then
                                                         targetEnemy = currentAntKing
                                                     else
                                                         if not waitForKingAfterQueenDeath() then
                                                              isRaidFinishedThisCheck = true
                                                         else
                                                              task.wait(0.5)
                                                         end
                                                     end
                                                 end
                                             elseif farmType == "Only Boss" then
                                                 if currentAntQueen then
                                                     targetEnemy = currentAntQueen
                                                 elseif currentAntKing then
                                                     targetEnemy = currentAntKing
                                                 else
                                                     if not waitForKingAfterQueenDeath() then
                                                         isRaidFinishedThisCheck = true
                                                     else
                                                         task.wait(0.5)
                                                     end
                                                 end
                                             end
    
                                             if targetEnemy then
                                                 local targetPos = targetEnemy:IsA("BasePart") and targetEnemy.Position or (targetEnemy:FindFirstChildWhichIsA("BasePart") and targetEnemy:FindFirstChildWhichIsA("BasePart").Position)
                                                 if targetPos then
                                                     local distance = (playerRoot.Position - targetPos).Magnitude
                                                     if distance > 5 then
                                                         _G.MoveToEnemy(targetPos, Options.MoveTypeDropdown.Value or "Tween", 500, false, true)
                                                     end
                                                     if hasFreePet() then
                                                         _G.AttackEnemy(targetEnemy.Name)
                                                     end
                                                 end
                                             elseif not isRaidFinishedThisCheck then
                                                 task.wait(1)
                                             end
    
                                             if isRaidFinishedThisCheck then raidCompleted = true end
                                         end)
    
                                         if not success then warn("AutoRaid Error:", err) end
                                         task.wait(0.5)
    
                                    end
    
                                    if raidCompleted then
                                         if returnPosition then
                                            local currentPos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position
                                            local distanceToJeju = currentPos and (currentPos - JEJU_ISLAND_POSITION.Position).Magnitude or math.huge
                                            if distanceToJeju < MIN_DISTANCE_JEJU + 100 then
                                                _G.TeleportTo(returnPosition)
                                                task.wait(1.5)
                                                local currentRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                                                if currentRoot then currentRoot.Anchored = false end
                                            end
                                         end
                                         if _G.ActivityPriority == "Raiding" then
                                             _G.ActivityPriority = Options.AutoFarmToggle.Value and "Farming" or "None"
                                         end
                                         break
    
                                    elseif not Options.AutoRaidToggle.Value then
                                         break
                                    elseif tick() - attemptStartTime >= maxAttemptTime then
                                          if _G.ActivityPriority == "Raiding" then
                                             _G.ActivityPriority = Options.AutoFarmToggle.Value and "Farming" or "None"
                                         end
                                    else
                                         if _G.ActivityPriority ~= "Raiding" then
                                              _G.ActivityPriority = Options.AutoFarmToggle.Value and "Farming" or "None"
                                         end
                                    end
                                end
                            end
                            task.wait(0.2)
                        end
    
                        if not Options.AutoRaidToggle.Value then
                             if _G.ActivityPriority == "Raiding" then
                                  _G.ActivityPriority = Options.AutoFarmToggle.Value and "Farming" or "None"
                             end
                             if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
                        end
                    end)
                else
                     if _G.ActivityPriority == "Raiding" then
                          _G.ActivityPriority = Options.AutoFarmToggle.Value and "Farming" or "None"
                     end
                     if playerRoot and playerRoot.Anchored then playerRoot.Anchored = false end
                end
            end
        })
        task.wait()
        Tabs.Raid:AddSection("Raid Server Hop")
        task.wait()
        Tabs.Raid:AddDropdown("PreferServerTypeDropdown", {
            Title = "Preferred Server Type",
            Values = {"Empty", "Full"},
            Default = "Empty",
            Callback = function(Value)
                _G.AriseSettings.PreferredServerType = Value
            end
        })
        task.wait()
        function hasRelevantEnemies(farmType)
            for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                local enemyId = enemy:GetAttribute("Id")
                local isDead = enemy:GetAttribute("Dead") or false
                if not isDead then
                    if farmType == "Ants" and enemyId == "JJ1" then
                        return true
                    elseif farmType == "Guards And Boss" and (enemyId == "JJ2" or enemyId == "JJ3" or enemyId == "JJ4") then
                        return true
                    elseif farmType == "Only Boss" and (enemyId == "JJ3" or enemyId == "JJ4") then
                        return true
                    end
                end
            end
            return false
        end
    
        _G.AriseSettings.KingWaitTime = _G.AriseSettings.KingWaitTime or 15
    
        Tabs.Raid:AddToggle("AutoServerHopRaidToggle", {
            Title = "Auto Server Hop for Raids",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoServerHopRaid = Value
                if Value then
                    if Options.AutoRaidToggle.Value then
                        Options.AutoRaidToggle:SetValue(false)
                    end
                    spawn(function()
                        local function hasAntKing()
                            for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                                local isDead = enemy:GetAttribute("Dead") or false
                                local enemyId = enemy:GetAttribute("Id") or "nil"
                                if not isDead and enemyId == "JJ4" then
                                    return true
                                end
                            end
                            return false
                        end
    
                        local function hasQueen()
                            for _, enemy in ipairs(workspace.__Main.__Enemies.Server:GetChildren()) do
                                local isDead = enemy:GetAttribute("Dead") or false
                                local enemyId = enemy:GetAttribute("Id") or "nil"
                                if not isDead and enemyId == "JJ3" then
                                    return true
                                end
                            end
                            return false
                        end
    
                        local function waitForKingAfterQueenDeath()
                            if hasAntKing() then return true end
                            local waitTime = 0
                            local maxWait = 15
                            Fluent:Notify({
                                Title = "Queen Dead",
                                Content = "Waiting up to " .. maxWait .. "s for Ant King to spawn...",
                                Duration = 3
                            })
                            while waitTime < maxWait do
                                task.wait(0.5)
                                waitTime = waitTime + 0.5
                                if hasAntKing() then
                                    Fluent:Notify({
                                        Title = "Ant King Spawned",
                                        Content = "Detected Ant King after " .. waitTime .. " seconds.",
                                        Duration = 3
                                    })
                                    return true
                                end
                            end
                            Fluent:Notify({
                                Title = "No Ant King",
                                Content = "Ant King did not spawn after " .. maxWait .. " seconds.",
                                Duration = 3
                            })
                            return false
                        end
    
                        local function areBothBossesDead()
                            local queenDead = not hasQueen()
                            local kingDead = not hasAntKing()
                            return queenDead and kingDead
                        end
    
                        while Options.AutoServerHopRaidToggle.Value do
                            local currentTime = os.date("*t")
                            local minutes = currentTime.min
                            local seconds = currentTime.sec
                            local isRaidWindow = (minutes >= 16 and minutes < 30)
    
                            if not isRaidWindow then
                                local wait_seconds = 0
                                if minutes < 16 then
                                    wait_seconds = (15 - minutes) * 60 + (60 - seconds)
                                else
                                    wait_seconds = (60 + 15 - minutes) * 60 + (60 - seconds)
                                end
                                local targetHour = (currentTime.hour + (minutes >= 30 and 1 or 0)) % 24
    
                                Fluent:Notify({ Title = "Auto Server Hop Paused", Content = "Waiting " .. math.ceil(wait_seconds) .. "s until " .. string.format("%02d:16", targetHour) .. "", Duration = 5 })
    
                                local waitEndTime = tick() + wait_seconds
                                while tick() < waitEndTime and Options.AutoServerHopRaidToggle.Value do task.wait(1) end
                            else
                                teleportToJejuIsland(Options.RaidMoveModeDropdown.Value)
                                task.wait(2)
    
                                if not playerRoot then
                                    task.wait(1)
                                end
    
                                local farmType = Options.FarmTypeDropdown.Value
                                local shouldHop = false
                                local initialEnemiesFound = hasRelevantEnemies(farmType)
    
                                if not initialEnemiesFound then
                                    task.wait(3)
                                    if not hasRelevantEnemies(farmType) then
                                        shouldHop = true
                                    else
                                        shouldHop = false
                                        shouldHop = false
                                    end
                                else
                                    shouldHop = false
                                end
    
                                if not shouldHop then
                                    while Options.AutoServerHopRaidToggle.Value and not shouldHop do
                                        local currentFarmTime = os.date("*t")
                                        if not (currentFarmTime.min >= 16 and currentFarmTime.min < 30) then
                                            shouldHop = true
                                            break
                                        end
    
                                        local success, err = pcall(function()
                                            if not playerRoot then task.wait(1) return end
    
                                            local serverEnemies = workspace.__Main.__Enemies.Server:GetChildren()
                                            local nearestEnemy = nil
                                            local minDistance = math.huge
                                            local aliveAntsCount = 0
                                            local antQueen = nil
                                            local antKing = nil
    
                                            for _, enemy in ipairs(serverEnemies) do
                                                local isDead = enemy:GetAttribute("Dead") or false
                                                local enemyId = enemy:GetAttribute("Id") or "nil"
                                                if not isDead then
                                                    if farmType == "Ants" and enemyId == "JJ1" then
                                                        aliveAntsCount = aliveAntsCount + 1
                                                        local distance = (playerRoot.Position - enemy.Position).Magnitude
                                                        if distance < minDistance then
                                                            minDistance = distance
                                                            nearestEnemy = enemy
                                                        end
                                                    elseif farmType == "Guards And Boss" then
                                                        if enemyId == "JJ2" then
                                                            aliveAntsCount = aliveAntsCount + 1
                                                            local distance = (playerRoot.Position - enemy.Position).Magnitude
                                                            if distance < minDistance then
                                                                minDistance = distance
                                                                nearestEnemy = enemy
                                                            end
                                                        elseif enemyId == "JJ3" then antQueen = enemy
                                                        elseif enemyId == "JJ4" then antKing = enemy
                                                        end
                                                    elseif farmType == "Only Boss" then
                                                        if enemyId == "JJ3" then
                                                            antQueen = enemy
                                                            local distance = (playerRoot.Position - enemy.Position).Magnitude
                                                            if distance < minDistance then
                                                                minDistance = distance
                                                                nearestEnemy = enemy
                                                            end
                                                        elseif enemyId == "JJ4" then
                                                            antKing = enemy
                                                            local distance = (playerRoot.Position - enemy.Position).Magnitude
                                                            if distance < minDistance then
                                                                minDistance = distance
                                                                nearestEnemy = enemy
                                                            end
                                                        end
                                                    end
                                                end
                                            end
    
                                            if farmType == "Ants" and aliveAntsCount > 0 and nearestEnemy then
                                                if minDistance > 5 then
                                                    _G.MoveToEnemy(nearestEnemy.Position, Options.MoveTypeDropdown.Value or "Tween")
                                                end
                                                if hasFreePet() then _G.AttackEnemy(nearestEnemy.Name) end
                                            elseif farmType == "Guards And Boss" then
                                                if aliveAntsCount > 0 and nearestEnemy then
                                                    local guardEnemy = nil
                                                    local minGuardDistance = math.huge
    
                                                    for _, enemy in ipairs(serverEnemies) do
                                                        local isDead = enemy:GetAttribute("Dead") or false
                                                        local enemyId = enemy:GetAttribute("Id") or "nil"
                                                        if not isDead and enemyId == "JJ2" then
                                                            local distance = (playerRoot.Position - enemy.Position).Magnitude
                                                            if distance < minGuardDistance then
                                                                minGuardDistance = distance
                                                                guardEnemy = enemy
                                                            end
                                                        end
                                                    end
    
                                                    if guardEnemy then
                                                        if minGuardDistance > 5 then
                                                            _G.MoveToEnemy(guardEnemy.Position, Options.MoveTypeDropdown.Value or "Tween", 500, false, true)
                                                        end
                                                        if hasFreePet() then
                                                            _G.AttackEnemy(guardEnemy.Name)
                                                        end
                                                    else
                                                        if minDistance > 5 then
                                                            _G.MoveToEnemy(nearestEnemy.Position, Options.MoveTypeDropdown.Value or "Tween", 500, false, true)
                                                        end
                                                        if hasFreePet() then
                                                            _G.AttackEnemy(nearestEnemy.Name)
                                                        end
                                                    end
                                                elseif aliveAntsCount == 0 then
                                                    local target = antQueen or antKing
                                                    if target then
                                                        local distance = (playerRoot.Position - target.Position).Magnitude
                                                        if distance > 5 then
                                                            _G.MoveToEnemy(target.Position, Options.MoveTypeDropdown.Value or "Tween", 500, false, true)
                                                        end
                                                        if hasFreePet() then
                                                            _G.AttackEnemy(target.Name)
                                                        end
                                                    end
                                                end
                                            elseif farmType == "Only Boss" and nearestEnemy then
                                                if minDistance > 5 then
                                                    _G.MoveToEnemy(nearestEnemy.Position, Options.MoveTypeDropdown.Value or "Tween")
                                                end
                                                if hasFreePet() then _G.AttackEnemy(nearestEnemy.Name) end
                                            end
    
                                            if farmType ~= "Ants" then
                                                if not hasQueen() then
                                                    if waitForKingAfterQueenDeath() then
                                                        shouldHop = areBothBossesDead()
                                                    else
                                                        shouldHop = true
                                                    end
                                                end
                                            else
                                                shouldHop = not hasRelevantEnemies(farmType)
                                            end
                                        end)
                                        if not success then warn("AutoServerHopRaid Farm Error:", err) end
                                        task.wait(0.5)
                                    end
                                end
    
                                if Options.AutoServerHopRaidToggle.Value and shouldHop then
                                    local serverTypeToHop = _G.AriseSettings.PreferredServerType or "Empty"
                                    local successHop = _G.HopToServer(serverTypeToHop)
                                    if not successHop then
                                        Fluent:Notify({
                                            Title = "Hop Failed",
                                            Content = "Couldn't find a suitable server. Retrying per hop settings...",
                                            Duration = 5
                                        })
                                    end
                                end
                            end
                            task.wait(1)
                        end
                    end)
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Teleport:AddSection("World Teleport")
        task.wait()
        Tabs.Teleport:AddToggle("TeleportModeToggle", {
            Title = "Teleport",
            Description = "Off: Sets spawn and resets\nOn: Teleport",
            Default = true,
            Callback = function(Value)
                _G.AriseSettings.Toggles.TeleportMode = Value
            end
        })
        task.wait()
        local function teleportToWorld(worldName)
            if _G.AriseSettings.Toggles.TeleportMode then
                local targetCFrame = _G.worldSpawns[worldName]
                if targetCFrame then
                    _G.TeleportTo(targetCFrame)
                end
            else
                _G.ChangeWorld(worldName)
            end
        end
    
        Tabs.Teleport:AddButton({
            Title = "Solo",
            Callback = function() teleportToWorld("SoloWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Naruto",
            Callback = function() teleportToWorld("NarutoWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "One Piece",
            Callback = function() teleportToWorld("OPWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Bleach",
            Callback = function() teleportToWorld("BleachWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Black Clover",
            Callback = function() teleportToWorld("BCWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Chainsaw Man",
            Callback = function() teleportToWorld("ChainsawWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Jojo",
            Callback = function() teleportToWorld("JojoWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Dragon Ball",
            Callback = function() teleportToWorld("DBWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "One Punch Man",
            Callback = function() teleportToWorld("OPMWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Dan Dan Dan Dan Dan Dan Dan Dan Dan",
            Callback = function() teleportToWorld("DanWorld") end
        })
        Tabs.Teleport:AddButton({
            Title = "Solo2",
            Callback = function() teleportToWorld("Solo2World") end
        })
        task.wait()
        Tabs.Teleport:AddSection("Guild Teleport")
        task.wait()
        Tabs.Teleport:AddButton({
            Title = "Guild Hall",
            Callback = function()
                _G.TeleportTo(getgenv().guildPositions.GuildHall)
            end
        })
        task.wait()
        Tabs.Teleport:AddSection("Server Options")
        task.wait()
        Tabs.Teleport:AddDropdown("ServerHopTypeDropdown", {
            Title = "Server Hop Type",
            Values = {"Empty", "Full"},
            Default = "Empty",
        })
        task.wait()
        Tabs.Teleport:AddButton({
            Title = "Server Hop",
            Callback = function()
                _G.HopToServer(Options.ServerHopTypeDropdown.Value)
            end
        })
        task.wait()
    end
    
    do
        Tabs.Quests:AddSection("Daily Quests")
        task.wait()
        Tabs.Quests:AddToggle("DailyQuestToggle", {
            Title = "Auto Redeem Daily Quests",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.DailyQuestToggle = Value
                if Value then
                    spawn(function()
                        while Options.DailyQuestToggle.Value do
                            for _, quest in ipairs(dailyQuests) do
                                _G.RedeemDailyQuest(quest)
                                task.wait(1)
                            end
                            task.wait(15)
                        end
                    end)
                end
            end
        })
    
        Tabs.Quests:AddSection("Weekly Quests")
        task.wait()
        Tabs.Quests:AddToggle("WeeklyQuestToggle", {
            Title = "Auto Redeem Weekly Quests",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.WeeklyQuestToggle = Value
                if Value then
                    spawn(function()
                        while Options.WeeklyQuestToggle.Value do
                            for _, quest in ipairs(weeklyQuests) do
                                _G.RedeemWeeklyQuest(quest)
                                task.wait(1)
                            end
                            task.wait(15)
                        end
                    end)
                end
            end
        })
    end
    
    do
        Tabs.Sell:AddSection("Shadow Selling")
        task.wait()
        Tabs.Sell:AddDropdown("SellRankDropdown", {
            Title = "Ranks to Sell",
            Values = rankList,
            Multi = true,
            Default = {["E"] = true}
        })
        task.wait()
        Tabs.Sell:AddDropdown("IgnorePetsDropdown", {
            Title = "Ignore Pets",
            Values = getgenv().pets,
            Multi = true,
            Default = {},
        })    
        task.wait()
        Tabs.Sell:AddToggle("AutoSellToggle", {
            Title = "Auto Sell",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoSellToggle = Value
                if Value then
                    Fluent:Notify({
                        Title = "Auto Sell Started",
                        Content = "Selling unlocked pets of selected ranks.",
                        Duration = 3
                    })
                    spawn(function()
                        while Options.AutoSellToggle.Value do
                            local selectedRanks = Options.SellRankDropdown.Value
                            if not selectedRanks or type(selectedRanks) ~= "table" then
                                Fluent:Notify({
                                    Title = "Error",
                                    Content = "No ranks selected in dropdown!",
                                    Duration = 3
                                })
                                task.wait(1)
                            else
                                local petsToSell = _G.getPetsToSell(selectedRanks)
                                if petsToSell and #petsToSell > 0 then
                                    if _G.SellPets then
                                        _G.SellPets(petsToSell)
                                    else
                                        warn("AutoSellToggle: error!")
                                        Fluent:Notify({
                                            Title = "Error",
                                            Content = "SellPets function is missing!",
                                            Duration = 3
                                        })
                                    end
                                end
                                task.wait(1)
                            end
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Sell:AddButton({
            Title = "Sell Selected Ranks Once",
            Callback = function()
                local selectedRanks = Options.SellRankDropdown.Value
                if not selectedRanks or type(selectedRanks) ~= "table" then
                    Fluent:Notify({
                        Title = "Error",
                        Content = "No ranks selected in dropdown!",
                        Duration = 3
                    })
                    return
                end
                local petsToSell = _G.getPetsToSell(selectedRanks)
                if not petsToSell then
                    Fluent:Notify({
                        Title = "Error",
                        Content = "Failed to retrieve pets to sell!",
                        Duration = 3
                    })
                    return
                end
                if #petsToSell > 0 then
                    if _G.SellPets then
                        _G.SellPets(petsToSell)
                        Fluent:Notify({
                            Title = "Pets Sold",
                            Content = "Sold " .. #petsToSell .. " pets.",
                            Duration = 3
                        })
                    else
                        Fluent:Notify({
                            Title = "Error",
                            Content = "SellPets function is missing!",
                            Duration = 3
                        })
                    end
                else
                    Fluent:Notify({
                        Title = "No Pets to Sell",
                        Content = "No unlocked pets match the selected ranks.",
                        Duration = 3
                    })
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Experimental:AddSection("DPS Customization")
        Tabs.Experimental:AddInput("DpsInput", {
            Title = "New DPS",
            Default = customDpsValue,
            Placeholder = "Ex: 10T, 1.5M, 500K",
            Numeric = false,
            Finished = true,
            Callback = function(Value)
                customDpsValue = Value
                if isCustomizing then
                    updateDpsText(Value)
                    Fluent:Notify({
                        Title = "DPS Updated",
                        Content = "New DPS: " .. Value,
                        Duration = 3
                    })
                end
            end
        })
        task.wait()
        Tabs.Experimental:AddToggle("DpsToggle", {
            Title = "Activate custom DPS. VISUAL ONLY",
            Default = false,
            Callback = function(Value)
                isCustomizing = Value
                _G.AriseSettings.Toggles.DpsToggle = Value
                if Value then
                    updateDpsText(customDpsValue)
                    Fluent:Notify({
                        Title = "Activated",
                        Content = "DPS now customized to: " .. customDpsValue,
                        Duration = 3
                    })
                end
            end
        })
        task.wait()
        Tabs.Experimental:AddParagraph({
            Title = "How to use",
            Content = "Input your desired DPS value in the input box above. Then, toggle the switch."
        })
    
        Tabs.Experimental:AddSection("Bypass Dungeon")
        Tabs.Experimental:AddButton({
            Title = "Bypass Dungeon",
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
    
                Fluent:Notify({ Title = "Bypass", Content = "Starting dungeon bypass...", Duration = 2 })
    
                resetDungeon()
    
                createDungeonLocal()
    
                task.wait(2) -- Wait
    
                local testDungeonId = "81654360"
                startDungeonLocal(testDungeonId)
    
            end
        })
        task.wait()
    end
    
    do
        Tabs.Upgrader:AddSection("Weapon Upgrader")
        Tabs.Upgrader:AddDropdown("UpgradeBuyTypeDropdown", {
            Title = "Type of Upgrade",
            Values = {"Gems", "Tickets"},
            Default = "Gems",
        })
        task.wait()
        Tabs.Upgrader:AddToggle("AutoUpgradeToggle", {
            Title = "Auto Weapon Upgrade",
            Default = false,
            Callback = function(Value)
                if Value then
                    spawn(function()
                        while Options.AutoUpgradeToggle.Value do
                            local upgrades = getEligibleUpgrades()
                            for _, upgrade in ipairs(upgrades) do
                                local args = {
                                    [1] = {
                                        [1] = {
                                            ["Type"] = upgrade.type,
                                            ["BuyType"] = Options.UpgradeBuyTypeDropdown.Value,
                                            ["Weapons"] = upgrade.weapons,
                                            ["Event"] = "UpgradeWeapon",
                                            ["Level"] = upgrade.targetLevel
                                        },
                                        [2] = "\010"
                                    }
                                }
                                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                            end
                            task.wait()
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Upgrader:AddParagraph({
            Title = "Warning",
            Content = "Auto Upgrade will consume a big amount of Gems/Tickets."
        })
    end
    
    do
        Tabs.Mount:AddSection("Auto Mount Options")
        Tabs.Mount:AddDropdown("MountMoveModeDropdown", {
            Title = "Search Mode",
            Description = "Safe: Slow Tween\nFast: Teleport",
            Values = {"Safe", "Fast"},
            Multi = false,
            Default = "Fast"
        })
        task.wait()
        Tabs.Mount:AddSection("Auto Mount")
        Tabs.Mount:AddSlider("MountTweenSpeedSlider", {
            Title = "Tween Speed",
            Default = 20,   
            Min = 20,   
            Max = 150,      
            Rounding = 0.1,
            Callback = function(Value)
                _G.AriseSettings.TryMountTweenSpeed = Value
            end
        })
        task.wait()
        Tabs.Mount:AddToggle("AutoMountToggle", {
            Title = "Auto Mount",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoMountToggle = Value
                if Value then
                    if Options.AutoMountHopToggle.Value then
                        Options.AutoMountHopToggle:SetValue(false)
                    end
                    spawn(function()
                        local visitedIslands = {}
                        while Options.AutoMountToggle.Value do
                            if #visitedIslands >= #_G.islandPositions then
                                visitedIslands = {}
                            end
    
                            local mountFound = false
                            for _, model in pairs(workspace.__Extra.__Appear:GetChildren()) do
                                if model:FindFirstChild("MountPrompt") then
                                    mountFound = true
                                    Fluent:Notify({
                                        Title = "Mount Found",
                                        Content = "Mount located! Stopping here...",
                                        Duration = 3
                                    })
                                    Options.AutoMountToggle:SetValue(false)
                                    break
                                end
                            end
    
                            if mountFound then break end
                            
                            for i = 1, #_G.islandPositions do
                                if not Options.AutoMountToggle.Value then break end
                                if not table.find(visitedIslands, i) then
                                    table.insert(visitedIslands, i)
                                    local islandCFrame = _G.islandPositions[i]
                                    
                                    local restoreInTp
                                    if Options.MountMoveModeDropdown.Value == "Safe" then
                                        _G.MoveWithTween(islandCFrame, 500)
                                    else
                                        restoreInTp = _G.StepTeleport(islandCFrame.Position)
                                    end
    
                                    task.wait(0.2)
    
                                    for attempt = 1, 3 do
                                        local mountFound = false
                                        for _, model in pairs(workspace.__Extra.__Appear:GetChildren()) do
                                            if model:FindFirstChild("MountPrompt") then
                                                mountFound = true
                                                Fluent:Notify({
                                                    Title = "Mount Found",
                                                    Content = "Mount located on Island " .. i .. "!",
                                                    Duration = 3
                                                })
                                                if restoreInTp then restoreInTp() end
                                                Options.AutoMountToggle:SetValue(false)
                                                break
                                            end
                                        end
                                        
                                        if mountFound then
                                            task.wait(2.5)
                                            _G.TryMount()
                                            break
                                        elseif attempt < 3 then
                                            task.wait(0.1)
                                        end
                                    end
    
                                    if restoreInTp then
                                        restoreInTp()
                                    end
                                    
                                    if not Options.AutoMountToggle.Value then
                                        break
                                    end
                                end
                            end
                            
                            if #visitedIslands >= #_G.islandPositions then
                                task.wait(0.5)
                            end
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Mount:AddToggle("AutoMountHopToggle", {
            Title = "Auto Mount Hop",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoMountHop = Value
                if Value then
                    if Options.AutoMountToggle.Value then
                        Options.AutoMountToggle:SetValue(false)
                        Fluent:Notify({
                            Title = "Auto Mount Disabled",
                            Content = "Disabled to prevent interference with Auto Mount Hop.",
                            Duration = 3
                        })
                    end
        
                    spawn(function()
                        local visitedIslands = {}
                        while Options.AutoMountHopToggle.Value do
                            visitedIslands = {}
        
                            local mountFound = false
                            for _, model in pairs(workspace.__Extra.__Appear:GetChildren()) do
                                if model:FindFirstChild("MountPrompt") then
                                    mountFound = true
                                    Fluent:Notify({
                                        Title = "Mount Found",
                                        Content = "Mount located! Attempting to mount before hopping...",
                                        Duration = 3
                                    })
                                    _G.TryMount(Options.TryMountTweenSpeedSlider.Value)
                                    task.wait(1)
                                    break
                                end
                            end
        
                            if not mountFound then
                                for i = 1, #_G.islandPositions do
                                    if not Options.AutoMountHopToggle.Value then break end
                                    if not table.find(visitedIslands, i) then
                                        table.insert(visitedIslands, i)
                                        local islandCFrame = _G.islandPositions[i]
        
                                        local restoreInTp
                                        if Options.MountMoveModeDropdown.Value == "Safe" then
                                            _G.MoveWithTween(islandCFrame, 500)
                                        else
                                            restoreInTp = _G.StepTeleport(islandCFrame.Position)
                                        end
        
                                        task.wait()
        
                                        for attempt = 1, 3 do
                                            mountFound = false
                                            for _, model in pairs(workspace.__Extra.__Appear:GetChildren()) do
                                                if model:FindFirstChild("MountPrompt") then
                                                    mountFound = true
                                                    Fluent:Notify({
                                                        Title = "Mount Found",
                                                        Content = "Mount located on Island " .. i .. "! Attempting to mount before hopping...",
                                                        Duration = 3
                                                    })
                                                    if restoreInTp then restoreInTp() end
                                                    task.wait(2.5)
                                                    _G.TryMount(Options.MountTweenSpeedSlider.Value)
                                                    break
                                                end
                                            end
        
                                            if mountFound then break end
                                            if attempt < 3 then task.wait(0.1) end
                                        end
        
                                        if restoreInTp then restoreInTp() end
                                        if mountFound then break end
                                    end
                                end
                            end
        
                            Fluent:Notify({
                                Title = "Server Hop Initiated",
                                Content = mountFound and "Mount attempted. Hopping to next server..." or "No mounts found. Hopping to next server...",
                                Duration = 3
                            })
                            local success = _G.HopToServer("Empty")
                            if not success then
                                Fluent:Notify({
                                    Title = "Server Hop Failed",
                                    Content = "No suitable servers found. Retrying in 5 seconds...",
                                    Duration = 5
                                })
                                task.wait(5)
                            end
                            task.wait(2)
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Mount:AddParagraph({
            Title = "NOTE",
            Content = "If you get security kicked, try to use less tween speed."
        })
    end
        
    do
        Tabs.Shop:AddSection("Weapon Shop")
        
        Tabs.Shop:AddDropdown("WeaponDropdown", {
            Title = "Select Weapon",
            Values = dropdownValues,
            Multi = false,
            Default = dropdownValues[1]
        })
        task.wait()
        Tabs.Shop:AddToggle("AutoBuyToggle", {
            Title = "Auto Buy",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoBuy = Value
                if Value then
                    spawn(function()
                        while Options.AutoBuyToggle.Value do
                            buySelectedWeapon()
                            task.wait(1)
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Shop:AddButton({
            Title = "Buy Selected Weapon Once",
            Callback = buySelectedWeapon
        })
    
        Tabs.Shop:AddSection("Potion Shop")
    
        Tabs.Shop:AddDropdown("BuyPotionTypeDropdown", {
            Title = "Select Potions",
            Values = potionShopTypes,
            Multi = true, -- Changed to true
            Default = {[potionShopTypes[1]] = true},
            Callback = function(Value)
                _G.AriseSettings.SelectedPotionToBuy = Value
            end
        })
        task.wait()
        _G.AriseSettings.SelectedPotionToBuy = _G.AriseSettings.SelectedPotionToBuy or {[potionShopTypes[1]] = true}
        Options.BuyPotionTypeDropdown:SetValue(_G.AriseSettings.SelectedPotionToBuy)
    
        Tabs.Shop:AddToggle("AutoBuyPotionToggle", {
            Title = "Auto Buy Potion",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoBuyPotion = Value
                if Value then
                    spawn(function()
                        local itemsFolder = game:GetService("Players").LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Inventory"):WaitForChild("Items")
    
                        while Options.AutoBuyPotionToggle.Value do
                            local selectedPotionsToBuy = Options.BuyPotionTypeDropdown.Value
    
                            if type(selectedPotionsToBuy) == "table" and itemsFolder then
                                for potionName, isSelected in pairs(selectedPotionsToBuy) do
                                    if isSelected then
                                        local potionItem = itemsFolder:FindFirstChild(potionName)
    
                                        if not potionItem then
    
                                            local buyArgs = {
                                                [1] = {
                                                    [1] = {
                                                        ["Name"] = potionName,
                                                        ["Type"] = "Product",
                                                        ["SubType"] = "Products",
                                                        ["Event"] = "TicketShop"
                                                    },
                                                    [2] = "\n"
                                                }
                                            }
                                            pcall(function()
                                                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(buyArgs))
                                            end)
                                            
                                            task.wait(1)
                                        end
                                    end
                                end
                            end
                            task.wait(5)
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Shop:AddButton({
            Title = "Buy Selected Potions Once",
            Callback = function()
                local selectedPotionsToBuy = Options.BuyPotionTypeDropdown.Value
                if type(selectedPotionsToBuy) == "table" then
                    local purchaseAttempted = false
                    for potionName, isSelected in pairs(selectedPotionsToBuy) do
                        if isSelected then
                            local buyArgs = {
                                [1] = {
                                    [1] = {
                                        ["Name"] = potionName,
                                        ["Type"] = "Product",
                                        ["SubType"] = "Products",
                                        ["Event"] = "TicketShop"
                                    },
                                    [2] = "\n"
                                }
                            }
                            local success, err = pcall(function()
                                game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(buyArgs))
                            end)
                            task.wait(1)
                        end
                    end
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Exchange:AddSection("Exchange Shop")
        Tabs.Exchange:AddDropdown("ExchangeShopTypeDropdown", {
            Title = "Select Exchange",
            Values = {"Guild Ticket", "Rank Up Rune", "Rare (10) -> Legendary (1)", "Legendary (1) -> Rare (1)", "Common (10) -> Rare (1)", "Rare (1) -> Common (1)"},
            Multi = false,
            Default = "Rare (10) -> Legendary (1)"
        })
        task.wait()
        Tabs.Exchange:AddButton({
            Title = "Buy Selected Exchange Once",
            Callback = function()
                local selectedExchangeType = Options.ExchangeShopTypeDropdown.Value
                local selectedItemName = exchangeItemMap[selectedExchangeType]
        
                if selectedItemName then
                    ExecuteExchange(selectedItemName)
                end
            end
        })
        task.wait()
        Tabs.Exchange:AddSlider("ExchangeAmountSlider", {
            Title = "Exchange Amount",
            Min = 1,
            Max = 50,
            Default = 10,
            Suffix = " times",
            Rounding = 0.1
        })
        task.wait()
        Tabs.Exchange:AddButton({
            Title = "Buy Selected Amount",
            Callback = function()
                local selectedExchangeType = Options.ExchangeShopTypeDropdown.Value
                local selectedItemName = exchangeItemMap[selectedExchangeType]
                local amountToBuy = tonumber(Options.ExchangeAmountSlider.Value)
        
                if not selectedItemName then
                    Fluent:Notify({ Title = "Exchange Error", Content = "Invalid exchange type selected.", Duration = 5 })
                    return
                end
        
                if not amountToBuy or amountToBuy < 1 then
                    Fluent:Notify({ Title = "Exchange Error", Content = "Invalid amount selected.", Duration = 5 })
                    return
                end
            
                spawn(function()
                    for i = 1, amountToBuy do
                        ExecuteExchange(selectedItemName)
                        task.wait(0.2)
                    end
                end)
            end
        })
        task.wait()
        Tabs.Exchange:AddToggle("ExchangeShopToggle",{
            Title = "Auto Exchange",
            Default = false,
            Callback = function (Value)
        
                if Value then
                    Fluent:Notify({ Title = "Auto Exchange", Content = "Started.", Duration = 3 })
                    spawn(function()
                        while Options.ExchangeShopToggle.Value do
                            local selectedExchangeType = Options.ExchangeShopTypeDropdown.Value
                            local selectedItemName = exchangeItemMap[selectedExchangeType]
        
                            if selectedItemName then
                                local success = ExecuteExchange(selectedItemName)
                                if not success then
                                    Options.ExchangeShopToggle:SetValue(false)
                                    Fluent:Notify({ Title = "Auto Exchange Error", Content = "Failed to send request. Stopping.", Duration = 5 })
                                    break 
                                end
                            else
                                Options.ExchangeShopToggle:SetValue(false)
                                Fluent:Notify({ Title = "Auto Exchange Error", Content = "Invalid exchange type selected. Stopping.", Duration = 5 })
                                break
                            end
        
                            task.wait(1)
                        end
                    end)
                else
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Infos:AddSection("Position")
        Tabs.Infos:AddParagraph({
            Title = "Read me!",
            Content = "Save your position where you want to go back after dungeon/raid/castle/winter." 
        })
        Tabs.Infos:AddButton({
            Title = "Save Position",
            Callback = function()
                SavePlayerPosition()
            end
        })
        task.wait()
        Tabs.Infos:AddButton({
            Title = "Teleport to Saved Position",
            Callback = function()
                TeleportToSavedPosition()
            end
        })
        task.wait()
        Tabs.Infos:AddSection("Support")
        Tabs.Infos:AddParagraph({
            Title = "Version 2.2",
            Content = "Buy permanent key on discord!"
        })
        task.wait()
        Tabs.Infos:AddParagraph({
            Title = "Anti-AFK",
            Content = "Anti-AFK is automatically enabled."
        })
        task.wait()
        Tabs.Infos:AddButton({
            Title = "Discord Server",
            Description = "Click to copy discord server invite",
            Callback = function()
                setclipboard("https://discord.com/invite/NxVkhKEr3Y")
                Fluent:Notify({
                    Title = "ok",
                    Content = "copied :D",
                    Duration = 3
                })
            end
        })
    end
    
    do
        Tabs.Boosts:AddSection("Potion Options")
    
        Tabs.Boosts:AddDropdown("PotionTypeDropdown", {
            Title = "Select Potion",
            Values = potionTypes,
            Multi = true,
            Default = {[potionTypes[1]] = true},
            Callback = function(Value)
                _G.AriseSettings.SelectedPotion = Value
            end
        })
        task.wait()
        _G.AriseSettings.SelectedPotion = _G.AriseSettings.SelectedPotion or {[potionTypes[1]] = true}
        Options.PotionTypeDropdown:SetValue(_G.AriseSettings.SelectedPotion)
    
        Tabs.Boosts:AddToggle("AutoUsePotionToggle", {
            Title = "Auto Use Potion",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoUsePotion = Value
                if Value then
                    spawn(function()
                        local playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
                        local hud = playerGui and playerGui:FindFirstChild("Hud")
                        local boostsFrame = hud and hud:FindFirstChild("Boosts")
    
                        while Options.AutoUsePotionToggle.Value do
                            local selectedPotions = Options.PotionTypeDropdown.Value
    
                            if type(selectedPotions) == "table" and boostsFrame then
                                for potionName, isSelected in pairs(selectedPotions) do
                                    if isSelected then
                                        local boostGuiName = boostGuiMap[potionName]
                                        if boostGuiName then
                                            local success, boostElement = pcall(function()
                                                return boostsFrame:FindFirstChild(boostGuiName)
                                            end)
    
                                            if success and not boostElement then
                                                local args = {
                                                    [1] = {
                                                        [1] = {
                                                            ["Action"] = "Use",
                                                            ["Event"] = "UseItem",
                                                            ["Name"] = potionName
                                                        },
                                                        [2] = "\n"
                                                    }
                                                }
                                                local success_fire, err_fire = pcall(function()
                                                    game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
                                                end)
                                                task.wait(0.2)
                                            end
                                        end
                                    end
                                end
                            else
                                playerGui = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
                                hud = playerGui and playerGui:FindFirstChild("Hud")
                                boostsFrame = hud and hud:FindFirstChild("Boosts")
                            end
    
                            task.wait(10)
                        end
                    end)
                end
            end
        })
        task.wait()
    end
    
    do
        Tabs.Gamepasses:AddButton({
            Title = "Get Auto Clicker Gamepass",
            Callback = function ()
                local gameAutoClickGamepass = player.leaderstats.Passes:GetAttribute("AutoClicker")
    
                if not gameAutoClickGamepass then
                    player.leaderstats.Passes:SetAttribute("AutoClicker", true)
                    Fluent:Notify({
                        Title = "Success",
                        Content = "Auto Clicker Gamepass activated!",
                        Duration = 2
                    })
                end
            end
        })
        task.wait()
        Tabs.Gamepasses:AddButton({
            Title = "Get Instant Arise Gamepass",
            Callback = function ()
                local instaAriseGamepass = player.leaderstats.Passes:GetAttribute("InstaArise")
    
                if not instaAriseGamepass then
                    player.leaderstats.Passes:SetAttribute("InstaArise", true)
                    Fluent:Notify({
                        Title = "Success",
                        Content = "Instant Arise Gamepass activated!",
                        Duration = 2
                    })
                end
            end
        })
        task.wait()
        Tabs.Gamepasses:AddButton({
            Title = "Get Instant Destroy Gamepass",
            Callback = function ()
                local instaDestroyGamepass = player.leaderstats.Passes:GetAttribute("InstaDestroy")
    
                if not instaDestroyGamepass then
                    player.leaderstats.Passes:SetAttribute("InstaDestroy", true)
                    Fluent:Notify({
                        Title = "Success",
                        Content = "Instant Destroy Gamepass activated!",
                        Duration = 2
                    })
                end
            end
        })
        task.wait()
        Tabs.Gamepasses:AddButton({
            Title = "Get Auto Attack Gamepass",
            Callback = function ()
                local autoAttackGamepass = player.leaderstats.Passes:GetAttribute("AutoAttack")
    
                if not autoAttackGamepass then
                    player.leaderstats.Passes:SetAttribute("AutoAttack", true)
                    Fluent:Notify({
                        Title = "Success",
                        Content = "Auto Attack Gamepass activated!",
                        Duration = 2
                    })
                end
            end
        })
        task.wait()
        Tabs.Gamepasses:AddParagraph({
            Title = "NOTE",
            Content = "Gamepasses are permanent.\nIf you already have it nothing will change."
        })
    end
    
    do
        Tabs.Webhook:AddInput("WebhookInput", {
            Title = "Webhook URL",
            Default = "",
            Numeric = false,
            Finished = false,
            Text = "Enter your Discord Webhook URL",
            Placeholder = "https://discord.com/api/webhooks/..."
        })
        task.wait()
        Options.WebhookInput:OnChanged(function(value)
            webhookUrl = value
        end)
    
        Tabs.Webhook:AddInput("Name", {
            Title = "Account Name",
            Default = "",
            Numeric = false,
            Finished = false,
            Text = "Optional name (leave blank to use account name)",
            Placeholder = "e.g., Account1"
        })
    
        Options.Name:OnChanged(function(value)
            accountName = value
        end)
    
        getgenv().WebhookWait = 10
        Tabs.Webhook:AddSlider("WebhookWait", {
            Title = "Send Interval (minutes)",
            Default = 10,
            Min = 1,
            Max = 30,
            Rounding = 0.1,
            Compact = false
        })
    
        Options.WebhookWait:OnChanged(function(value)
            getgenv().WebhookWait = value
        end)
    
        Tabs.Webhook:AddToggle("EnableWebhook", {
            Title = "Enable Webhook",
            Default = false,
        })
    
        Options.EnableWebhook:OnChanged(function(value)
            if value then
                task.spawn(function()
                    while Options.EnableWebhook.Value do
                        if webhookUrl ~= "" and webhookUrl:match("^https://discord%.com/api/webhooks/") then
                            task.wait(2)
                            _G.sendWebhook()
                        end
                        task.wait(getgenv().WebhookWait * 60)
                    end
                end)
            end
        end)
        task.wait()
        Tabs.Webhook:AddButton({
            Title = "Test Webhook",
            Callback = function()
                if webhookUrl ~= "" and webhookUrl:match("^https://discord%.com/api/webhooks/") then
                    _G.sendWebhookBase(_G.getCurrentInventory())
                    task.wait(0.5)
                     local sampleGains = { Tickets = 10, Common = 50, Rare = 5, Legendary = 1 }
                     _G.sendWebhookDungeon(sampleGains)
    
                    Fluent:Notify({
                        Title = "Success",
                        Content = "Webhook tests sent!",
                        Duration = 3
                    })
                else
                    Fluent:Notify({
                        Title = "Error",
                        Content = "Please enter a valid Discord webhook URL!",
                        Duration = 3
                    })
                end
            end
        })
            
        Tabs.Webhook:AddToggle("ToggleCoins", {
            Title = "Send Coins",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Coins = value
            end
        })
        
        Tabs.Webhook:AddToggle("ToggleGems", {
            Title = "Send Gems",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Gems = value
            end
        })
    
        Tabs.Webhook:AddToggle("ToggleTickets", {
            Title = "Send Tickets",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Tickets = value
            end
        })
    
    
        Tabs.Webhook:AddToggle("ToggleCommon", {
            Title = "Send Common Dust",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Common = value
            end
        })
        
        Tabs.Webhook:AddToggle("ToggleRare", {
            Title = "Send Rare Dust",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Rare = value
            end
        })
    
        Tabs.Webhook:AddToggle("ToggleLegendary", {
            Title = "Send Legendary Dust",
            Default = true,
            Callback = function(value)
                getgenv().webhookToggles.Legendary = value
            end
        })
    
        Tabs.Webhook:AddToggle("ToggleDungeonComplete", {
            Title = "Send Dungeon Rewards",
            Default = false,
            Callback = function(value)
                getgenv().webhookToggles.DungeonComplete = value
            end
        })
        getgenv().webhookToggles.DungeonComplete = getgenv().webhookToggles.DungeonComplete or false
        Options.ToggleDungeonComplete:SetValue(getgenv().webhookToggles.DungeonComplete)
    
    end
    
    do
        Tabs.Settings:AddSection("Script Settings")
        Tabs.Settings:AddToggle("AutoReinjectToggle", {
            Title = "Auto Execute on Teleport",
            Description = "Executes the script automatically after teleporting (e.g., server hop).",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.AutoReinject = Value
                if Value then
                    if not queueteleport then
                        Fluent:Notify({
                            Title = "Error",
                            Content = "Your exploit does not support this feature.",
                            Duration = 5
                        })
                        Options.AutoReinjectToggle:SetValue(false)
                        return
                    end
                end
            end
        })
        task.wait()
        Tabs.Settings:AddToggle("HideMinimizeToggle", {
            Title = "Hide Minimize Button",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.HideMinimizeButton = Value
                
                local function tryHideButton()
                    local success, result = pcall(function()
                        local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
                        if not playerGui then return false end
                        
                        local minimizeGui = playerGui:FindFirstChild("MinimizeGui")
                        if not minimizeGui then return false end
                        
                        local minimizeButton = minimizeGui:FindFirstChild("MinimizeButton")
                        if not minimizeButton then return false end
                        
                        minimizeButton.Visible = not Value
                        return true
                    end)
                    
                    return success and result
                end
                
                if not tryHideButton() then
                    spawn(function()
                        for i = 1, 5 do
                            task.wait(1)
                            if tryHideButton() then break end
                        end
                    end)
                end
            end
        })
        task.wait()
        Tabs.Settings:AddSection("Player")
        Tabs.Settings:AddSlider("PlayerSpeedSlider", {
            Title = "Walkspeed",
            Default = 16,
            Min = 16,
            Max = 500,
            Rounding = 0.1,
            Callback = function(Value)
                if Options and Options.PlayerSpeedToggle and Options.PlayerSpeedToggle.Value then
                    local character = player.Character
                    if character and character.Humanoid then
                        character.Humanoid.WalkSpeed = Value
                    end
                end
            end
        })
    
        Tabs.Settings:AddToggle("PlayerSpeedToggle", {
            Title = "Keep Walkspeed",
            Default = false,
            Callback = function(Value)
                local character = player.Character or player.CharacterAdded:Wait()
                
                if Value then
                    if Options and Options.PlayerSpeedSlider then
                        local humanoid = character.Humanoid
                        local speedValue = Options.PlayerSpeedSlider.Value
                        humanoid.WalkSpeed = speedValue
                        
                        humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                            if Options and Options.PlayerSpeedToggle and Options.PlayerSpeedToggle.Value and Options.PlayerSpeedSlider then
                                humanoid.WalkSpeed = Options.PlayerSpeedSlider.Value
                            end
                        end)
                        
                        player.CharacterAdded:Connect(function(newCharacter)
                            local newHumanoid = newCharacter:WaitForChild("Humanoid")
                            if Options and Options.PlayerSpeedToggle and Options.PlayerSpeedToggle.Value and Options.PlayerSpeedSlider then
                                newHumanoid.WalkSpeed = Options.PlayerSpeedSlider.Value
                            end
                        end)
                    end
                else
                    local humanoid = character.Humanoid
                    humanoid.WalkSpeed = 16
                end
            end
        })
        task.wait()
        Tabs.Settings:AddSlider("PlayerJumpPowerSlider", {
            Title = "Jump Power",
            Default = 50,
            Min = 50,
            Max = 500,
            Rounding = 0.1,
            Callback = function(Value)
                if Options and Options.PlayerJumpPowerToggle and Options.PlayerJumpPowerToggle.Value then
                    local character = player.Character
                    if character and character.Humanoid then
                        local humanoid = character.Humanoid
                        if humanoid.UseJumpPower then
                            humanoid.JumpPower = Value
                        else
                            humanoid.JumpHeight = Value
                        end
                    end
                end
            end
        })
    
        Tabs.Settings:AddToggle("PlayerJumpPowerToggle", {
            Title = "Keep Jump Power",
            Default = false,
            Callback = function(Value)
                local character = player.Character or player.CharacterAdded:Wait()
                
                if Value then
                    if Options and Options.PlayerJumpPowerSlider then
                        local humanoid = character.Humanoid
                        local jumpValue = Options.PlayerJumpPowerSlider.Value
                        if humanoid.UseJumpPower then
                            humanoid.JumpPower = jumpValue
                        else
                            humanoid.JumpHeight = jumpValue
                        end
                        
                        player.CharacterAdded:Connect(function(newCharacter)
                            local newHumanoid = newCharacter:WaitForChild("Humanoid")
                            if Options and Options.PlayerJumpPowerToggle and Options.PlayerJumpPowerToggle.Value and Options.PlayerJumpPowerSlider then
                                if newHumanoid.UseJumpPower then
                                    newHumanoid.JumpPower = Options.PlayerJumpPowerSlider.Value
                                else
                                    newHumanoid.JumpHeight = Options.PlayerJumpPowerSlider.Value
                                end
                            end
                        end)
                    end
                else
                    local humanoid = character.Humanoid
                    if humanoid.UseJumpPower then
                        humanoid.JumpPower = 50
                    else
                        humanoid.JumpHeight = 7.3
                    end
                end
            end
        })
        task.wait()
        Tabs.Settings:AddToggle("HideNameToggle", {
            Title = "Hide Name (Clientside)",
            Default = false,
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
    
        Tabs.Settings:AddSection("Performance")
        Tabs.Settings:AddToggle("WhiteScreenToggle", {
            Title = "White Screen",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.WhiteScreenToggle = Value
    
                if not whiteScreenGui or not whiteScreenGui.Parent then
                    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
                    whiteScreenGui = Instance.new("ScreenGui")
                    whiteScreenGui.Name = "WhiteoutScreenGui_Arise"
                    whiteScreenGui.ResetOnSpawn = false
                    whiteScreenGui.IgnoreGuiInset = true
                    whiteScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
    
                    local whiteoutFrame = Instance.new("Frame")
                    whiteoutFrame.Name = "WhiteoutFrame"
                    whiteoutFrame.BackgroundColor3 = Color3.new(1, 1, 1)
                    whiteoutFrame.BorderColor3 = Color3.new(1, 1, 1)
                    whiteoutFrame.BorderSizePixel = 0
                    whiteoutFrame.Size = UDim2.new(1, 0, 1, 0)
                    whiteoutFrame.Position = UDim2.new(0, 0, 0, 0)
                    whiteoutFrame.Visible = false
                    whiteoutFrame.ZIndex = 900
                    whiteoutFrame.Parent = whiteScreenGui
    
                    whiteScreenGui.Parent = playerGui
                end
    
                local frame = whiteScreenGui and whiteScreenGui:FindFirstChild("WhiteoutFrame")
    
                if Value then
                    if frame then
                        frame.Visible = true
                    end
                    pcall(game:GetService("RunService").Set3dRenderingEnabled, game:GetService("RunService"), false)
                else
                    if frame then
                        frame.Visible = false
                    end
                    pcall(game:GetService("RunService").Set3dRenderingEnabled, game:GetService("RunService"), true)
                end
            end
        })
        task.wait()
        Tabs.Settings:AddToggle("BlackScreenToggle", { 
            Title = "Black Screen",
            Default = false,
            Callback = function(Value)
                _G.AriseSettings.Toggles.BlackScreenToggle = Value
    
                if not blackScreenGui or not blackScreenGui.Parent then
                    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
                    blackScreenGui = Instance.new("ScreenGui")
                    blackScreenGui.Name = "BlackoutScreenGui_Arise"
                    blackScreenGui.ResetOnSpawn = false
                    blackScreenGui.IgnoreGuiInset = true
                    blackScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
                    local blackoutFrame = Instance.new("Frame")
                    blackoutFrame.Name = "BlackoutFrame"
                    blackoutFrame.BackgroundColor3 = Color3.new(0, 0, 0)
                    blackoutFrame.BorderColor3 = Color3.new(0, 0, 0)
                    blackoutFrame.BorderSizePixel = 0
                    blackoutFrame.Size = UDim2.new(1, 0, 1, 0)
                    blackoutFrame.Position = UDim2.new(0, 0, 0, 0)
                    blackoutFrame.Visible = false 
                    blackoutFrame.ZIndex = 1000
                    blackoutFrame.Parent = blackScreenGui
    
                    blackScreenGui.Parent = playerGui
                end
    
                local frame = blackScreenGui and blackScreenGui:FindFirstChild("BlackoutFrame")
    
                if Value then
                    if frame then
                        frame.Visible = true
                    end
                    pcall(game:GetService("RunService").Set3dRenderingEnabled, game:GetService("RunService"), false)
                else
                    if frame then
                        frame.Visible = false
                    end
                    pcall(game:GetService("RunService").Set3dRenderingEnabled, game:GetService("RunService"), true)
                end
            end
        })
        task.wait()
        Tabs.Settings:AddToggle("FpsBoostToggle", {
            Title = "Fps Boost",
            Default = false,
            Callback = function(Value)
                isFpsBoostActive = Value
        
                if isFpsBoostActive then    
                    if not originalTerrainValues then
                        originalTerrainValues = {
                            WaterWaveSize = Terrain.WaterWaveSize,
                            WaterWaveSpeed = Terrain.WaterWaveSpeed,
                            WaterReflectance = Terrain.WaterReflectance,
                            WaterTransparency = Terrain.WaterTransparency
                        }
                    end
                    if not originalLightingValues then
                        originalLightingValues = {
                            GlobalShadows = Lighting.GlobalShadows,
                            FogEnd = Lighting.FogEnd,
                            Effects = {}
                        }
                        for _, v in pairs(Lighting:GetDescendants()) do
                            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                                originalLightingValues.Effects[v] = v.Enabled
                            end
                        end
                    end
                    if originalQualityLevel == nil then
                        originalQualityLevel = settings().Rendering.QualityLevel
                    end
        
                    Terrain.WaterWaveSize = 0
                    Terrain.WaterWaveSpeed = 0
                    Terrain.WaterReflectance = 0
                    Terrain.WaterTransparency = 0
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
                    for _, v in pairs(Lighting:GetDescendants()) do
                        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                            v.Enabled = false
                        end
                    end
        
                    for i, v in pairs(game:GetDescendants()) do
                        pcall(function()
                            if v:IsA("BasePart") then
                                v.Material = Enum.Material.Plastic
                                v.Reflectance = 0
                            elseif v:IsA("Decal") or v:IsA("Texture") then
                                v.Transparency = 1
                            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                                v.Lifetime = NumberRange.new(0)
                            elseif v:IsA("Explosion") then
                                v.BlastPressure = 1
                                v.BlastRadius = 1
                            end
                        end)
                    end
        
                    if not fpsBoostConnection or not fpsBoostConnection.Connected then
                        fpsBoostConnection = workspace.DescendantAdded:Connect(function(child)
                            task.spawn(function()
                                if not isFpsBoostActive then return end
        
                                if child:IsA('ForceField') or child:IsA('Sparkles') or child:IsA('Smoke') or child:IsA('Fire') then
                                    task.wait()
                                    pcall(function() child:Destroy() end)
                                end
                            end)
                        end)
                    end
        
                else    
                    if originalTerrainValues then
                        pcall(function()
                            Terrain.WaterWaveSize = originalTerrainValues.WaterWaveSize
                            Terrain.WaterWaveSpeed = originalTerrainValues.WaterWaveSpeed
                            Terrain.WaterReflectance = originalTerrainValues.WaterReflectance
                            Terrain.WaterTransparency = originalTerrainValues.WaterTransparency
                        end)
                    end
                    if originalLightingValues then
                        pcall(function()
                            Lighting.GlobalShadows = originalLightingValues.GlobalShadows
                            Lighting.FogEnd = originalLightingValues.FogEnd
                            for effectInstance, originalState in pairs(originalLightingValues.Effects) do
                                 if effectInstance and effectInstance.Parent then
                                     pcall(function() effectInstance.Enabled = originalState end)
                                 end
                            end
                        end)
                    end
                    if originalQualityLevel ~= nil then
                        pcall(function()
                            settings().Rendering.QualityLevel = originalQualityLevel
                        end)
                    end
        
                    if fpsBoostConnection and fpsBoostConnection.Connected then
                        fpsBoostConnection:Disconnect()
                        fpsBoostConnection = nil
                    end
                end
            end
        })
        task.wait()
    end
    
    -- endofdef
    
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)
    SaveManager:SetIgnoreIndexes({})
    InterfaceManager:SetFolder("Arisetwvz")
    SaveManager:SetFolder("Arisetwvz/game")
    
    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)
    
    Window:SelectTab(6)
    SaveManager:LoadAutoloadConfig()
    
    task.wait(0.2)
    
    local autoloadConfigFile = SaveManager.Folder .. "/settings/autoload.txt"
    local configToLoadName = nil
    if isfile(autoloadConfigFile) then
        configToLoadName = readfile(autoloadConfigFile)
    end
    
    local finalWorldValue = Options.WorldDropdown.Default or "SoloWorld"
    local finalEnemyValue = { (getgenv().enemyList[finalWorldValue] or {})[1] }
    if configToLoadName then
        local configFilePath = SaveManager.Folder .. "/settings/" .. configToLoadName .. ".json"
        if isfile(configFilePath) then
            local successRead, fileContent = pcall(readfile, configFilePath)
            if successRead and fileContent then
                local successDecode, decodedData = pcall(HttpService.JSONDecode, HttpService, fileContent)
                if successDecode and decodedData and decodedData.objects then
                    local tempSavedWorld = nil
                    local tempSavedEnemy = nil
                    for _, optionData in ipairs(decodedData.objects) do
                        if optionData.idx == "WorldDropdown" and optionData.type == "Dropdown" then
                            tempSavedWorld = optionData.value
                        elseif optionData.idx == "EnemyDropdown" and optionData.type == "Dropdown" then
                            tempSavedEnemy = optionData.value
                            if type(tempSavedEnemy) ~= "table" then tempSavedEnemy = {tempSavedEnemy} end
                        end
                    end
                    if tempSavedWorld then finalWorldValue = tempSavedWorld end
                    if tempSavedEnemy then finalEnemyValue = tempSavedEnemy end
                end
            end
        end
    end
    
    Options.WorldDropdown:SetValue(finalWorldValue)
    task.wait(0.1)
    local currentWorldValue = Options.WorldDropdown.Value
    local correctEnemyList = getgenv().enemyList[currentWorldValue] or {}
    Options.EnemyDropdown:SetValues(correctEnemyList)
    task.wait(0.1)
    Options.EnemyDropdown:SetValue(finalEnemyValue)
    isInitializingUI = false
    
    if _G.LoadPlayerPosition() == nil then
        Fluent:Notify({
            Title = "Save Position",
            Content = "No saved position found, saving current position.",
            Duration = 3,
        })
        SavePlayerPosition()
    end
    
    LocalPlayer.OnTeleport:Connect(function(State)
        if _G.AriseSettings.Toggles.AutoReinject and not TeleportCheck and queueteleport then
            TeleportCheck = true
            queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ZhangJunZ84/twvz/refs/heads/main/arisecrossover.lua'))()")
            Fluent:Notify({
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
            Window:Minimize()
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
    
    print("\n==========\n[INFO] Loaded\n==========\n")
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
                    Fluent:Notify({Title = "Success", Content = "Key is valid!", Duration = 5})
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
