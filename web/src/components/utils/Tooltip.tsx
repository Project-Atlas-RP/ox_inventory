import { flip, FloatingPortal, offset, shift, useFloating, useTransitionStyles } from '@floating-ui/react';
import React, { useEffect, useRef, useState } from 'react';
import { useAppSelector } from '../../store';
import SlotTooltip from '../inventory/SlotTooltip';

const Tooltip: React.FC = () => {
  const hoverData = useAppSelector((state) => state.tooltip);

  const { refs, context, floatingStyles } = useFloating({
    middleware: [flip(), shift(), offset({ mainAxis: 10, crossAxis: 10 })],
    open: hoverData.open,
    placement: 'right-start',
  });

  const { isMounted, styles } = useTransitionStyles(context, {
    duration: 200,
  });

  // Position is updated through a ref on every mousemove (no re-render per pixel)
  // and a one-shot state flag tracks whether we've ever received a position. The
  // flag gates the FloatingPortal — without it, opening the inventory with the
  // cursor parked over a slot fires mouseEnter → openTooltip with no mousemove
  // ever happening, and floating-ui falls back to (0,0) → tooltip flashes in the
  // top-left corner of the screen.
  const lastPosRef = useRef<{ x: number; y: number } | null>(null);
  const [hasPosition, setHasPosition] = useState(false);

  useEffect(() => {
    const handleMouseMove = ({ clientX, clientY }: MouseEvent) => {
      lastPosRef.current = { x: clientX, y: clientY };
      if (!hasPosition) setHasPosition(true);
      refs.setPositionReference({
        getBoundingClientRect() {
          return {
            width: 0,
            height: 0,
            x: clientX,
            y: clientY,
            left: clientX,
            top: clientY,
            right: clientX,
            bottom: clientY,
          };
        },
      });
    };

    window.addEventListener('mousemove', handleMouseMove);
    return () => window.removeEventListener('mousemove', handleMouseMove);
  }, [hasPosition, refs]);

  return (
    <>
      {isMounted && hasPosition && hoverData.item && hoverData.inventoryType && (
        <FloatingPortal>
          <SlotTooltip
            ref={refs.setFloating}
            style={{ ...floatingStyles, ...styles }}
            item={hoverData.item!}
            inventoryType={hoverData.inventoryType!}
          />
        </FloatingPortal>
      )}
    </>
  );
};

export default Tooltip;
