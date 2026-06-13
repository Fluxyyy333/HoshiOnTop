--!nocheck
local API = "https://api.hoshihub.my.id"
local HS  = game:GetService("HttpService")

local function get(url)
    local ok, b = pcall(function() return game:HttpGet(url) end)
    if ok then return b end
end

local keylessOn = false
local body = get(API .. "/api/loader/keyless")
if body then
    local ok, dec = pcall(function() return HS:JSONDecode(body) end)
    if ok and dec and dec.keyless == true then keylessOn = true end
end
if not keylessOn then
    warn("[HoshiHub] Old-Version Unlock: keyless OFF -> ditolak.")
    return false
end

local env = (getgenv and getgenv()) or getfenv()
for _, e in ipairs({ env, _G }) do
    rawset(e, "_HH_luarmor_ok",     true)
    rawset(e, "LRM_ScriptName",     "HoshiHub")
    rawset(e, "LRM_IsUserPremium",  false)
    rawset(e, "_HH_loader_handoff", true)
end

print("[HoshiHub] Old-Version Unlock aktif. Jalankan loadstring build lama sekarang.")
return true
