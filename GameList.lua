-- HoshiHub — GameList (GameId → Luraph'd game-script raw URL)
-- Hosted on GitHub raw, fetched at runtime. Add a new game = edit THIS file only;
-- the obfuscated loaders/scripts never need re-uploading.
--
-- Key = game.GameId (universe id, NOT PlaceId — matches main/VIP/private/event servers).
-- Value = raw GitHub URL of the Luraph'd game script.
--
-- SINGLE SOURCE OF TRUTH for GameId→url. Both paths fetch this same file:
--   • Free : Luarmor Script 2 fetches this, looks up GameId, loadstrings the URL.
--   • Paid : the loader fetches this directly after /auth (no /resolve — removed).
-- No DB mirror needed: the server only validates keys (/auth + /verify) now.

return {
    [10004244222] = "https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/kalb.lua",
    [10039338037] = "https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/buildaringfarm.lua",
    [9792947201]  = "https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/slimerng.lua",
    [7395930870]  = "https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/selllemon.lua",
}
