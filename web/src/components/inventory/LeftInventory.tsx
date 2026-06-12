import InventoryGrid from './InventoryGrid';
import BackpackHeaderActions from './BackpackHeaderActions';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';

const LeftInventory: React.FC = () => {
  const leftInventory = useAppSelector(selectLeftInventory);

  return <InventoryGrid inventory={leftInventory} headerActions={<BackpackHeaderActions />} />;
};

export default LeftInventory;
