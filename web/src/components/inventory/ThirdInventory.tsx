import React from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectThirdInventory } from '../../store/inventory';

const ThirdInventory: React.FC = () => {
  const third = useAppSelector(selectThirdInventory);
  if (!third) return null;
  // No `readOnly` here — moves to/from the bag are now routed server-side via
  // the `backpackPreview` inventory type. The third window behaves like a
  // normal panel for drag/drop purposes.
  return (
    <div className="third-inventory">
      <InventoryGrid inventory={third} />
    </div>
  );
};

export default ThirdInventory;
