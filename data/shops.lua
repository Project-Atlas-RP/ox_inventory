-- Shops are now defined in [Tools]/atlas_shops/config/shops.lua (single source
-- of truth for ALL buy + sell shops). atlas_shops registers them with
-- ox_inventory on boot via ApplyShopDefinitions, so this file is intentionally
-- empty. Edit shops there, not here.
return {}
