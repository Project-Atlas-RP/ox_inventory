import React, { useMemo } from 'react';
import { useAppSelector } from '../../store';
import {
  selectEquippedBackpack,
  selectLeftInventory,
  selectThirdInventory,
} from '../../store/inventory';
import { BACKPACK_ITEM_NAMES } from '../../typings/backpack';
import { fetchNui } from '../../utils/fetchNui';

interface Props {
  // The right header doesn't show this button — the toggle lives on the
  // player (left) header and covers both the equipped and unequipped cases.
  variant?: 'left' | 'right';
}

const BackpackHeaderActions: React.FC<Props> = ({ variant = 'left' }) => {
  const equipped = useAppSelector(selectEquippedBackpack);
  const left = useAppSelector(selectLeftInventory);
  const third = useAppSelector(selectThirdInventory);

  const target = useMemo(() => {
    if (equipped) {
      return { slot: equipped.slot };
    }
    const bag = left?.items?.find(
      (item) => item && item.name && BACKPACK_ITEM_NAMES.has(item.name)
    );
    if (!bag) return null;
    return { slot: bag.slot };
  }, [equipped, left]);

  if (!target || variant !== 'left') return null;

  const thirdOpen = !!third;

  const onToggleThird = () => {
    if (thirdOpen) {
      fetchNui('closeBackpackThirdPanel', {}).catch(() => {});
    } else {
      fetchNui('openBackpackThirdPanel', { slot: target.slot }).catch(() => {});
    }
  };

  return (
    <button
      type="button"
      className={`backpack-header-button${thirdOpen ? ' is-active' : ''}`}
      title={thirdOpen ? 'Close backpack window' : 'Open backpack as a separate window'}
      onClick={onToggleThird}
      aria-label="Open backpack window"
    >
      <BackpackIcon />
    </button>
  );
};

const BackpackIcon: React.FC = () => (
  <svg
    width="12"
    height="12"
    viewBox="0 0 24 24"
    fill="none"
    stroke="currentColor"
    strokeWidth="2"
    strokeLinecap="round"
    strokeLinejoin="round"
    aria-hidden="true"
  >
    {/* Body: explicit rounded rectangle so the icon reads as a square shape
        instead of the previous all-curves path that rendered as a circle at
        small sizes. */}
    <rect x="5" y="7" width="14" height="14" rx="3" ry="3" />
    {/* Handle / top strap arc */}
    <path d="M9 7V5a3 3 0 0 1 6 0v2" />
    {/* Front pocket divider */}
    <line x1="5" y1="13" x2="19" y2="13" />
  </svg>
);

export default BackpackHeaderActions;
