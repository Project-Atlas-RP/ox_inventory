export type BackpackTier = 'small' | 'medium' | 'large';

export type BackpackState = {
  tier: BackpackTier;
  item: string;
  label: string;
  slot: number;
  // Inventory id of the container that backs this backpack — used by the swap
  // button to recognise when ox_inventory has loaded the bag into the right panel.
  containerId: string;
} | null;

// Item names recognised as wearable backpacks. Keep in sync with
// atlas_backpacks/config.lua (Config.Tiers[*].item) AND the Lua
// BACKPACK_ITEM_NAMES table at the top of ox_inventory/client.lua —
// drift between the two causes the bag-icon header button and the
// useSlot third-panel routing to disagree on what counts as a backpack.
export const BACKPACK_ITEM_NAMES = new Set<string>([
  'backpack_tote',
  'backpack_tote_b',
  'backpack_small',
  'backpack_medium',
  'backpack_large',
]);
