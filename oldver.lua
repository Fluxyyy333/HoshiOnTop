--!nocheck
-- HoshiHub — Old-Version Unlock (keyless-gated, non-abuseable)
-- ============================================================
-- KONSEP: 2 loadstring terpisah.
--   1) loadstring(THIS)           -> arm flag trust (cuma kalau keyless ON)
--   2) loadstring(<build LAMA>)   -> build pin apa pun; guard-nya short-circuit
--                                    di cek free-tier, jalan INLINE tanpa handoff
--                                    ke loader (yg akan force-load versi terbaru).
--
-- ANTI-ABUSE: file ini menolak total saat server keyless OFF, jadi tidak bisa
-- dipakai sebagai bypass premium permanen. Saat keyless ON, free access memang
-- sah dibuka untuk semua, jadi ini tidak menambah vektor abuse baru.
-- ============================================================
local API = "https://api.hoshihub.my.id"
local HS  = game:GetService("HttpService")

local function get(url)
    local ok, b = pcall(function() return game:HttpGet(url) end)
    if ok then return b end
end

-- 1) Konfirmasi keyless ON (server-authoritative, fail-closed)
local keylessOn = false
local body = get(API .. "/api/loader/keyless")
if body then
    local ok, dec = pcall(function() return HS:JSONDecode(body) end)
    if ok and dec and dec.keyless == true then keylessOn = true end
end
if not keylessOn then
    warn("[HoshiHub] Old-Version Unlock: keyless OFF -> ditolak (bukan bypass premium).")
    return false
end

-- 2) Keyless ON -> set flag trust yang sama dgn jalur keyless loader, di env + _G.
--    Guard build-lama (baru maupun lawas) short-circuit di cek free-tier:
--    _HH_luarmor_ok (>=2026-06-02) ATAU LRM_* (sejak awal). _HH_loader_handoff=true
--    sebagai fail-safe: kalau flag gagal kebaca, guard refuse, BUKAN force-load terbaru.
local env = (getgenv and getgenv()) or getfenv()
for _, e in ipairs({ env, _G }) do
    rawset(e, "_HH_luarmor_ok",     true)
    rawset(e, "LRM_ScriptName",     "HoshiHub")
    rawset(e, "LRM_IsUserPremium",  false)
    rawset(e, "_HH_loader_handoff", true)
end

print("[HoshiHub] Old-Version Unlock aktif (keyless ON). Sekarang jalankan loadstring build lama.")
return true
