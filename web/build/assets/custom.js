/**
 * Atlas RP - Custom ox_inventory Enhancements
 * Adds draggable panels with zoom and server-side persistence
 */

(function() {
    'use strict';

    // Cache for settings loaded from server
    let serverSettings = {
        zoom: 1,
        leftPos: { x: 0, y: 0 },
        rightPos: { x: 0, y: 0 },
        loaded: false
    };

    // Save settings to server via NUI callback
    function saveToServer() {
        const settings = {
            zoom: serverSettings.zoom,
            leftPos: serverSettings.leftPos,
            rightPos: serverSettings.rightPos
        };
        
        fetch(`https://${GetParentResourceName()}/saveUISettings`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(settings)
        }).catch(() => {});
        
        // Also save to localStorage as backup
        localStorage.setItem('inventory-settings', JSON.stringify(settings));
    }

    // Load settings from server
    async function loadFromServer() {
        try {
            const response = await fetch(`https://${GetParentResourceName()}/loadUISettings`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
            
            const data = await response.json();
            
            if (data && (data.zoom || data.leftPos || data.rightPos)) {
                serverSettings.zoom = data.zoom || 1;
                serverSettings.leftPos = data.leftPos || { x: 0, y: 0 };
                serverSettings.rightPos = data.rightPos || { x: 0, y: 0 };
                serverSettings.loaded = true;
                
                // Update injected CSS with server settings
                updateInjectedCSS();
                return;
            }
        } catch (e) {}
        
        // Fallback to localStorage if server fails
        try {
            const local = localStorage.getItem('inventory-settings');
            if (local) {
                const data = JSON.parse(local);
                serverSettings.zoom = data.zoom || 1;
                serverSettings.leftPos = data.leftPos || { x: 0, y: 0 };
                serverSettings.rightPos = data.rightPos || { x: 0, y: 0 };
            }
        } catch (e) {}
        
        serverSettings.loaded = true;
    }

    // Get current zoom scale
    function getZoom() {
        return serverSettings.zoom;
    }

    // Get position for a panel
    function getPosition(panelId) {
        return panelId === 'left' ? serverSettings.leftPos : serverSettings.rightPos;
    }

    // Set position for a panel
    function setPosition(panelId, x, y) {
        if (panelId === 'left') {
            serverSettings.leftPos = { x, y };
        } else {
            serverSettings.rightPos = { x, y };
        }
    }

    // Build transform string with position and zoom
    function buildTransform(x, y, scale) {
        return `translate(${x}px, ${y}px) scale(${scale})`;
    }

    // Update the injected CSS with current positions and zoom
    function updateInjectedCSS() {
        let style = document.getElementById('inventory-saved-styles');
        if (!style) {
            style = document.createElement('style');
            style.id = 'inventory-saved-styles';
            document.head.appendChild(style);
        }
        
        const zoom = getZoom();
        const leftPos = serverSettings.leftPos;
        const rightPos = serverSettings.rightPos;
        
        let css = '.inventory-grid-wrapper { transform-origin: center center !important; }\n';
        css += `.inventory-grid-wrapper:first-of-type { transform: ${buildTransform(leftPos.x, leftPos.y, zoom)} !important; }\n`;
        css += `.inventory-grid-wrapper:last-of-type { transform: ${buildTransform(rightPos.x, rightPos.y, zoom)} !important; }\n`;
        
        style.textContent = css;
    }

    // Immediately inject default styles and then load from server
    function injectSavedStyles() {
        // First try localStorage for immediate display
        try {
            const local = localStorage.getItem('inventory-settings');
            if (local) {
                const data = JSON.parse(local);
                serverSettings.zoom = data.zoom || 1;
                serverSettings.leftPos = data.leftPos || { x: 0, y: 0 };
                serverSettings.rightPos = data.rightPos || { x: 0, y: 0 };
            }
        } catch (e) {}
        
        updateInjectedCSS();
        
        // Then load from server (will update if different)
        loadFromServer();
    }
    
    // Run immediately
    injectSavedStyles();

    // Wait for DOM and React to fully render
    function waitForElements(selector, callback, maxAttempts = 50) {
        let attempts = 0;
        const interval = setInterval(() => {
            const elements = document.querySelectorAll(selector);
            if (elements.length > 0) {
                clearInterval(interval);
                callback(elements);
            } else if (++attempts >= maxAttempts) {
                clearInterval(interval);
            }
        }, 100);
    }

    // Global drag state - only one panel can be dragged at a time
    let activeDrag = null;

    // Single global mousemove handler
    document.addEventListener('mousemove', (e) => {
        if (!activeDrag) return;
        
        const { element, startX, startY, initialX, initialY, elementRect, baseLeft, baseTop } = activeDrag;
        const zoom = getZoom();
        
        const newX = initialX + (e.clientX - startX);
        const newY = initialY + (e.clientY - startY);
        
        // Clamp position to keep element on screen
        // Scale boundary constraints with zoom level
        const viewportWidth = window.innerWidth;
        const viewportHeight = window.innerHeight;
        const baseMinVisibleX = 600;
        const baseMinVisibleY = 680;
        
        // When zoomed out (smaller), panels are smaller so we need less visible area
        // When zoomed in (larger), panels are larger so we need more visible area
        const minVisibleX = baseMinVisibleX * zoom;
        const minVisibleY = baseMinVisibleY * zoom;
        
        const minX = -baseLeft + minVisibleX - elementRect.width;
        const maxX = viewportWidth - baseLeft - minVisibleX;
        const minY = -baseTop + minVisibleY - elementRect.height;
        const maxY = viewportHeight - baseTop - minVisibleY;
        
        const clampedX = Math.max(minX, Math.min(maxX, newX));
        const clampedY = Math.max(minY, Math.min(maxY, newY));
        
        element.style.transform = buildTransform(clampedX, clampedY, zoom);
        element.dataset.translateX = clampedX;
        element.dataset.translateY = clampedY;
    });
    
    // Single global mouseup handler
    document.addEventListener('mouseup', () => {
        if (!activeDrag) return;
        
        const { element, handle } = activeDrag;
        
        handle.style.cursor = 'grab';
        element.style.zIndex = '';
        document.body.style.userSelect = '';
        
        // Save position
        const panelId = element.dataset.dragId;
        const x = parseFloat(element.dataset.translateX);
        const y = parseFloat(element.dataset.translateY);
        setPosition(panelId, x, y);
        
        // Update injected CSS for next open
        updateInjectedCSS();
        
        // Save to server
        saveToServer();
        
        activeDrag = null;
    });

    // Make an element draggable with boundary constraints
    function makeDraggable(element, handle) {
        // Get current transform from server settings
        const pos = getPosition(element.dataset.dragId);
        element.dataset.translateX = pos.x;
        element.dataset.translateY = pos.y;

        handle.addEventListener('mousedown', (e) => {
            if (e.target.closest('button, input, .inventory-control-button')) return;
            if (activeDrag) return; // Already dragging something
            
            const zoom = getZoom();
            
            // Before removing injected CSS, apply inline transforms to ALL panels
            // so they don't jump when CSS is removed
            const allPanels = document.querySelectorAll('.inventory-grid-wrapper[data-drag-id]');
            allPanels.forEach(panel => {
                const panelPos = getPosition(panel.dataset.dragId);
                panel.style.transform = buildTransform(panelPos.x, panelPos.y, zoom);
                panel.style.transformOrigin = 'center center';
                panel.dataset.translateX = panelPos.x;
                panel.dataset.translateY = panelPos.y;
            });
            
            // Now safe to remove injected CSS
            const injectedStyle = document.getElementById('inventory-saved-styles');
            if (injectedStyle) injectedStyle.remove();
            
            const startX = e.clientX;
            const startY = e.clientY;
            const initialX = parseFloat(element.dataset.translateX) || 0;
            const initialY = parseFloat(element.dataset.translateY) || 0;
            
            // Apply current position as inline style
            element.style.transform = buildTransform(initialX, initialY, zoom);
            
            // Cache element dimensions at drag start
            const elementRect = element.getBoundingClientRect();
            const baseLeft = elementRect.left - initialX;
            const baseTop = elementRect.top - initialY;
            
            handle.style.cursor = 'grabbing';
            element.style.zIndex = '1000';
            document.body.style.userSelect = 'none';
            
            // Store drag state globally
            activeDrag = {
                element,
                handle,
                startX,
                startY,
                initialX,
                initialY,
                elementRect,
                baseLeft,
                baseTop
            };
            
            e.preventDefault();
        });
    }

    // Setup draggable panels
    function initializeEnhancements() {
        waitForElements('.inventory-grid-wrapper', (panels) => {
            panels.forEach((panel, index) => {
                // Skip if already enhanced
                if (panel.dataset.enhanced) return;
                panel.dataset.enhanced = 'true';
                panel.dataset.dragId = index === 0 ? 'left' : 'right';

                // Find the header
                const header = panel.querySelector('.inventory-grid-header-wrapper');
                if (!header) return;

                // Make panel draggable via header
                makeDraggable(panel, header);
                header.style.cursor = 'grab';
            });
        });
    }

    // Reset positions on inventory close/open
    function setupResetListener() {
        const observer = new MutationObserver((mutations) => {
            mutations.forEach((mutation) => {
                if (mutation.addedNodes.length > 0) {
                    setTimeout(initializeEnhancements, 50);
                }
            });
        });

        observer.observe(document.body, { childList: true, subtree: true });
    }

    // Double-click header to reset position
    document.addEventListener('dblclick', (e) => {
        const header = e.target.closest('.inventory-grid-header-wrapper');
        if (header) {
            const panel = header.closest('.inventory-grid-wrapper');
            if (panel) {
                const zoom = getZoom();
                panel.style.transform = buildTransform(0, 0, zoom);
                panel.dataset.translateX = 0;
                panel.dataset.translateY = 0;
                setPosition(panel.dataset.dragId, 0, 0);
                updateInjectedCSS();
                saveToServer();
            }
        }
    });

    // Reset all panel positions
    function resetAllPositions() {
        const zoom = getZoom();
        const panels = document.querySelectorAll('.inventory-grid-wrapper[data-drag-id]');
        panels.forEach(panel => {
            panel.style.transform = buildTransform(0, 0, zoom);
            panel.dataset.translateX = 0;
            panel.dataset.translateY = 0;
        });
        serverSettings.leftPos = { x: 0, y: 0 };
        serverSettings.rightPos = { x: 0, y: 0 };
        updateInjectedCSS();
        saveToServer();
    }

    // Apply zoom scale to inventory panels
    function applyZoom(scale) {
        serverSettings.zoom = scale;
        
        const panels = document.querySelectorAll('.inventory-grid-wrapper[data-drag-id]');
        panels.forEach(panel => {
            const pos = getPosition(panel.dataset.dragId);
            panel.style.transform = buildTransform(pos.x, pos.y, scale);
            panel.style.transformOrigin = 'center center';
        });
        
        updateInjectedCSS();
        saveToServer();
    }

    // Make the useful controls dialog draggable
    function makeDialogDraggable(dialog) {
        if (dialog.dataset.draggable) return;
        dialog.dataset.draggable = 'true';
        
        const titleBar = dialog.querySelector('.useful-controls-dialog-title');
        if (!titleBar) return;
        
        let isDragging = false;
        let offsetX, offsetY;
        
        titleBar.style.cursor = 'grab';
        
        titleBar.addEventListener('mousedown', (e) => {
            if (e.target.closest('button, .useful-controls-dialog-close')) return;
            
            isDragging = true;
            
            // Get dialog's current position
            const rect = dialog.getBoundingClientRect();
            
            // Calculate offset from mouse to dialog's top-left corner
            offsetX = e.clientX - rect.left;
            offsetY = e.clientY - rect.top;
            
            // Switch from centered positioning to absolute positioning
            dialog.style.position = 'fixed';
            dialog.style.left = rect.left + 'px';
            dialog.style.top = rect.top + 'px';
            dialog.style.transform = 'none';
            
            titleBar.style.cursor = 'grabbing';
            document.body.style.userSelect = 'none';
            e.preventDefault();
        });
        
        document.addEventListener('mousemove', (e) => {
            if (!isDragging) return;
            
            let newLeft = e.clientX - offsetX;
            let newTop = e.clientY - offsetY;
            
            // Boundary constraints
            const viewportWidth = window.innerWidth;
            const viewportHeight = window.innerHeight;
            const dialogWidth = dialog.offsetWidth;
            const dialogHeight = dialog.offsetHeight;
            const minVisible = 100;
            
            // Keep at least minVisible pixels on screen
            newLeft = Math.max(minVisible - dialogWidth, Math.min(viewportWidth - minVisible, newLeft));
            newTop = Math.max(minVisible - dialogHeight, Math.min(viewportHeight - minVisible, newTop));
            
            dialog.style.left = newLeft + 'px';
            dialog.style.top = newTop + 'px';
        });
        
        document.addEventListener('mouseup', () => {
            if (isDragging) {
                isDragging = false;
                titleBar.style.cursor = 'grab';
                document.body.style.userSelect = '';
            }
        });
    }

    // Add controls to useful controls dialog
    function addControlsToDialog() {
        const dialog = document.querySelector('.useful-controls-dialog');
        if (!dialog || dialog.dataset.controlsAdded) return;
        
        const contentWrapper = dialog.querySelector('.useful-controls-content-wrapper');
        if (!contentWrapper) return;

        // Make dialog draggable via its title
        makeDialogDraggable(dialog);

        // Get saved zoom
        const savedZoom = getZoom();
        
        // Create zoom control container
        const zoomContainer = document.createElement('div');
        zoomContainer.style.cssText = `
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-top: 12px;
            padding: 12px;
            background: var(--bg-secondary, #1a1a1a);
            border: 1px solid var(--border, #333);
            border-radius: 8px;
        `;
        
        // Zoom label and value
        const zoomHeader = document.createElement('div');
        zoomHeader.style.cssText = `
            display: flex;
            justify-content: space-between;
            align-items: center;
        `;
        
        const zoomLabel = document.createElement('span');
        zoomLabel.textContent = 'Window Scale';
        zoomLabel.style.cssText = `
            color: white;
            font-size: 14px;
            font-weight: 500;
        `;
        
        const zoomValue = document.createElement('span');
        zoomValue.textContent = `${Math.round(savedZoom * 100)}%`;
        zoomValue.style.cssText = `
            color: var(--text-secondary, #a0a0a0);
            font-size: 13px;
        `;
        
        zoomHeader.appendChild(zoomLabel);
        zoomHeader.appendChild(zoomValue);
        
        // Zoom slider
        const zoomSlider = document.createElement('input');
        zoomSlider.type = 'range';
        zoomSlider.min = '0.5';
        zoomSlider.max = '1.5';
        zoomSlider.step = '0.05';
        zoomSlider.value = savedZoom;
        zoomSlider.style.cssText = `
            width: 100%;
            height: 6px;
            border-radius: 3px;
            background: var(--bg-tertiary, #242424);
            outline: none;
            cursor: pointer;
            -webkit-appearance: none;
            appearance: none;
        `;
        
        // Custom slider thumb styling
        const sliderStyle = document.createElement('style');
        sliderStyle.textContent = `
            .zoom-slider::-webkit-slider-thumb {
                -webkit-appearance: none;
                appearance: none;
                width: 16px;
                height: 16px;
                border-radius: 50%;
                background: var(--accent, #6366f1);
                cursor: pointer;
                border: none;
            }
            .zoom-slider::-moz-range-thumb {
                width: 16px;
                height: 16px;
                border-radius: 50%;
                background: var(--accent, #6366f1);
                cursor: pointer;
                border: none;
            }
        `;
        document.head.appendChild(sliderStyle);
        zoomSlider.className = 'zoom-slider';
        
        zoomSlider.addEventListener('input', (e) => {
            const scale = parseFloat(e.target.value);
            zoomValue.textContent = `${Math.round(scale * 100)}%`;
            applyZoom(scale);
        });
        
        zoomContainer.appendChild(zoomHeader);
        zoomContainer.appendChild(zoomSlider);
        
        // Reset zoom button
        const resetZoomBtn = document.createElement('button');
        resetZoomBtn.textContent = 'Reset to 100%';
        resetZoomBtn.style.cssText = `
            padding: 8px 12px;
            background: transparent;
            border: 1px solid var(--border, #333);
            border-radius: 6px;
            color: var(--text-secondary, #a0a0a0);
            font-size: 12px;
            cursor: pointer;
            transition: all 0.15s ease;
            margin-top: 4px;
        `;
        
        resetZoomBtn.addEventListener('mouseenter', () => {
            resetZoomBtn.style.background = 'var(--bg-tertiary, #242424)';
            resetZoomBtn.style.color = 'white';
        });
        
        resetZoomBtn.addEventListener('mouseleave', () => {
            resetZoomBtn.style.background = 'transparent';
            resetZoomBtn.style.color = 'var(--text-secondary, #a0a0a0)';
        });
        
        resetZoomBtn.addEventListener('click', () => {
            zoomSlider.value = 1;
            zoomValue.textContent = '100%';
            applyZoom(1);
        });
        
        zoomContainer.appendChild(resetZoomBtn);
        
        // Create reset positions button
        const resetBtn = document.createElement('button');
        resetBtn.className = 'inventory-control-button reset-positions-btn';
        resetBtn.textContent = 'Reset Window Positions';
        resetBtn.style.cssText = `
            width: 100%;
            padding: 12px 16px;
            background: var(--bg-tertiary, #242424);
            border: 1px solid var(--border, #333);
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.15s ease;
            margin-top: 8px;
        `;
        
        resetBtn.addEventListener('mouseenter', () => {
            resetBtn.style.background = 'var(--bg-hover, #2a2a2a)';
            resetBtn.style.borderColor = '#444';
        });
        
        resetBtn.addEventListener('mouseleave', () => {
            resetBtn.style.background = 'var(--bg-tertiary, #242424)';
            resetBtn.style.borderColor = 'var(--border, #333)';
        });
        
        resetBtn.addEventListener('click', () => {
            resetAllPositions();
            resetBtn.textContent = 'Positions Reset!';
            setTimeout(() => {
                resetBtn.textContent = 'Reset Window Positions';
            }, 1500);
        });
        
        contentWrapper.appendChild(zoomContainer);
        contentWrapper.appendChild(resetBtn);
        dialog.dataset.controlsAdded = 'true';
    }

    // Watch for useful controls dialog to appear
    function setupDialogObserver() {
        const dialogObserver = new MutationObserver(() => {
            const dialog = document.querySelector('.useful-controls-dialog');
            if (dialog) {
                setTimeout(addControlsToDialog, 50);
            }
        });
        dialogObserver.observe(document.body, { childList: true, subtree: true });
    }

    // Setup drag detection for drop zone expansion
    function setupDragDetection() {
        let isDragging = false;
        let isOutsidePanel = false;
        let mouseX = 0;
        let mouseY = 0;
        
        // Track mouse position
        document.addEventListener('mousemove', (e) => {
            mouseX = e.clientX;
            mouseY = e.clientY;
            
            if (isDragging) {
                checkIfOutsidePanel();
            }
        });
        
        // Check if mouse is outside inventory panels
        const checkIfOutsidePanel = () => {
            const panels = document.querySelectorAll('.inventory-grid-wrapper');
            let outside = true;
            
            panels.forEach(panel => {
                const rect = panel.getBoundingClientRect();
                // Add some padding to make detection smoother
                const padding = 10;
                if (mouseX >= rect.left - padding && 
                    mouseX <= rect.right + padding && 
                    mouseY >= rect.top - padding && 
                    mouseY <= rect.bottom + padding) {
                    outside = false;
                }
            });
            
            updateDropZoneVisual(outside);
        };
        
        const updateDropZoneVisual = (showExpanded) => {
            if (isOutsidePanel === showExpanded) return;
            isOutsidePanel = showExpanded;
            
            const buttons = document.querySelectorAll('.inventory-control .inventory-control-button');
            buttons.forEach((btn, index) => {
                // Skip the close button (last button)
                if (index < buttons.length - 1) {
                    if (showExpanded && isDragging) {
                        btn.classList.add('drop-zone-active');
                    } else {
                        btn.classList.remove('drop-zone-active');
                    }
                }
            });
        };
        
        const updateDragState = (dragging) => {
            if (isDragging === dragging) return;
            isDragging = dragging;
            
            if (!dragging) {
                // Reset when drag ends
                isOutsidePanel = false;
                const buttons = document.querySelectorAll('.inventory-control .inventory-control-button');
                buttons.forEach((btn) => {
                    btn.classList.remove('drop-zone-active');
                });
            }
        };
        
        // Monitor for drag preview element and apply zoom scaling
        const dragObserver = new MutationObserver(() => {
            const dragPreview = document.querySelector('.item-drag-preview');
            updateDragState(!!dragPreview);
            
            // Scale drag preview to match inventory slot size and zoom
            if (dragPreview) {
                const zoom = getZoom();
                // Base size matches inventory slot size (10.2vh from grid-template-columns)
                const baseSize = 10.2;
                const scaledSize = baseSize * zoom;
                dragPreview.style.width = `${scaledSize}vh`;
                dragPreview.style.height = `${scaledSize}vh`;
                dragPreview.style.backgroundSize = `${scaledSize * 0.7}vh`; // Icon size ratio
                dragPreview.style.borderRadius = '12px'; // Match --radius-md from slots
            }
        });
        
        dragObserver.observe(document.body, { 
            childList: true, 
            subtree: true 
        });
    }

    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            initializeEnhancements();
            setupResetListener();
            setupDialogObserver();
            setupDragDetection();
        });
    } else {
        initializeEnhancements();
        setupResetListener();
        setupDialogObserver();
        setupDragDetection();
    }

    // Double-click on inventory slot to use item
    document.addEventListener('dblclick', (e) => {
        const slot = e.target.closest('.inventory-slot');
        if (!slot) return;
        
        // Only allow using items from player inventory (left panel)
        const inventoryWrapper = slot.closest('.inventory-grid-wrapper');
        if (!inventoryWrapper) return;
        
        // Check if this is the player inventory (first/left panel)
        const allWrappers = document.querySelectorAll('.inventory-grid-wrapper');
        if (allWrappers.length === 0 || inventoryWrapper !== allWrappers[0]) return;
        
        // Get the slot index from the grid position
        const grid = inventoryWrapper.querySelector('.inventory-grid-container');
        if (!grid) return;
        
        const slots = Array.from(grid.querySelectorAll('.inventory-slot'));
        const slotIndex = slots.indexOf(slot);
        
        if (slotIndex === -1) return;
        
        // Slot numbers are 1-indexed
        const slotNumber = slotIndex + 1;
        
        // Check if slot has an item (has background image that's not 'none')
        const bgImage = window.getComputedStyle(slot).backgroundImage;
        if (!bgImage || bgImage === 'none' || bgImage === 'url("none")') return;
        
        // Send useItem NUI callback
        fetch(`https://${GetParentResourceName()}/useItem`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(slotNumber)
        }).catch(() => {});
    });

    // ========================================
    // Gun Rack - Gun icon slots in emergency vehicle gloveboxes
    // ========================================
    const GUN_RACK_START_SLOT = 7; // 1-indexed: slots 7+ are gun rack (matches server config)
    let gunRackObserver = null;

    function cleanupGunRack() {
        if (gunRackObserver) {
            gunRackObserver.disconnect();
            gunRackObserver = null;
        }
        // Move gun rack slots back into the grid before removing container
        const container = document.querySelector('.gun-rack-container');
        if (container) {
            const rightPanel = document.querySelectorAll('.inventory-grid-wrapper')[1];
            const grid = rightPanel?.querySelector('.inventory-grid-container');
            if (grid) {
                grid.classList.remove('gun-rack-active');
                container.querySelectorAll('.inventory-slot').forEach(slot => {
                    slot.classList.remove('gun-rack-slot');
                    slot.style.display = '';
                    grid.appendChild(slot);
                });
            }
            container.remove();
        }
        document.querySelectorAll('.gun-rack-slot').forEach(slot => {
            slot.classList.remove('gun-rack-slot');
        });
        document.querySelectorAll('.gun-rack-hidden').forEach(slot => {
            slot.style.display = '';
            slot.classList.remove('gun-rack-hidden');
        });
    }

    function setupGunRack() {
        const rightPanel = document.querySelectorAll('.inventory-grid-wrapper')[1];
        if (!rightPanel) return;

        const grid = rightPanel.querySelector('.inventory-grid-container');
        if (!grid) return;

        const allSlots = Array.from(grid.querySelectorAll(':scope > .inventory-slot'));
        const rackSlots = allSlots.slice(GUN_RACK_START_SLOT - 1);
        if (rackSlots.length === 0) return;

        // Immediately hide gun rack slots to prevent flash while we check LEO status
        for (const slot of rackSlots) {
            slot.style.display = 'none';
            slot.classList.add('gun-rack-hidden');
        }

        fetch(`https://${GetParentResourceName()}/isOnDutyLeo`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        })
        .then(res => res.json())
        .then(isLeo => {
            if (!isLeo) {
                // Already hidden above, nothing more to do
                return;
            }

            // Create gun rack container below the grid
            grid.classList.add('gun-rack-active');
            const rackContainer = document.createElement('div');
            rackContainer.className = 'gun-rack-container';
            grid.parentNode.insertBefore(rackContainer, grid.nextSibling);

            // Move slots into the gun rack container
            for (const slot of rackSlots) {
                slot.style.display = '';
                slot.classList.remove('gun-rack-hidden');
                slot.classList.add('gun-rack-slot');
                rackContainer.appendChild(slot);
            }

            // Inject a style tag for the gun icon - uses ::before which React cannot affect
            if (!document.getElementById('gun-rack-style')) {
                const style = document.createElement('style');
                style.id = 'gun-rack-style';
                style.textContent = '.gun-rack-slot::before { content: "\\1F52B" !important; position: absolute !important; top: 50% !important; left: 50% !important; transform: translate(-50%, -50%) !important; font-size: 32px !important; opacity: 1 !important; pointer-events: none !important; z-index: 999 !important; }';
                document.head.appendChild(style);
            }

            // Observe style changes on gun rack slots to hide icon when item is present
            gunRackObserver = new MutationObserver((mutations) => {
                for (const m of mutations) {
                    if (m.attributeName === 'style' && m.target.classList.contains('gun-rack-slot')) {
                        const bg = m.target.style.backgroundImage || '';
                        const hasItem = bg && !bg.includes('url(none)') && bg !== 'none' && bg !== '';
                        m.target.classList.toggle('gun-rack-has-item', hasItem);
                    }
                }
            });
            for (const slot of rackSlots) {
                const bg = slot.style.backgroundImage || '';
                const hasItem = bg && !bg.includes('url(none)') && bg !== 'none' && bg !== '';
                slot.classList.toggle('gun-rack-has-item', hasItem);
                gunRackObserver.observe(slot, { attributes: true, attributeFilter: ['style'] });
            }
        })
        .catch(() => {});
    }

    // ========================================
    // Shop UI - Transform shop panels into product-card layouts
    // ========================================
    function cleanupShopUI() {
        const rightPanel = document.querySelectorAll('.inventory-grid-wrapper')[1];
        if (rightPanel) {
            rightPanel.removeAttribute('data-inventory-type');
            rightPanel.removeAttribute('data-shop-label');
            rightPanel.style.removeProperty('height');
            const shopIcon = rightPanel.querySelector('.shop-header-icon');
            if (shopIcon) shopIcon.remove();
            const dragHint = rightPanel.querySelector('.shop-drag-hint');
            if (dragHint) dragHint.remove();
        }
    }

    function setupShopUI(label) {
        function trySetup(attempts) {
            const rightPanel = document.querySelectorAll('.inventory-grid-wrapper')[1];
            if (!rightPanel) {
                if (attempts < 20) requestAnimationFrame(() => trySetup(attempts + 1));
                return;
            }
            rightPanel.setAttribute('data-inventory-type', 'shop');
            rightPanel.setAttribute('data-shop-label', label || 'Shop');

            // Add shop icon to header
            const header = rightPanel.querySelector('.inventory-grid-header-wrapper');
            if (header && !header.querySelector('.shop-header-icon')) {
                const icon = document.createElement('div');
                icon.className = 'shop-header-icon';
                icon.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>';
                header.insertBefore(icon, header.firstChild);
            }

            // Add drag hint below grid
            if (!rightPanel.querySelector('.shop-drag-hint')) {
                const hint = document.createElement('div');
                hint.className = 'shop-drag-hint';
                hint.innerHTML = '<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 9l-3 3 3 3"/><path d="M9 5l3-3 3 3"/><path d="M15 19l-3 3-3-3"/><path d="M19 9l3 3-3 3"/><line x1="2" y1="12" x2="22" y2="12"/><line x1="12" y1="2" x2="12" y2="22"/></svg> Drag items to purchase';
                rightPanel.appendChild(hint);
            }

            // Sync height with left (inventory) panel
            const leftPanel = document.querySelectorAll('.inventory-grid-wrapper')[0];
            if (leftPanel) {
                // Small delay to ensure left panel is fully rendered
                setTimeout(function() {
                    const lp = document.querySelectorAll('.inventory-grid-wrapper')[0];
                    const rp = document.querySelectorAll('.inventory-grid-wrapper')[1];
                    if (lp && rp) {
                        rp.style.height = lp.getBoundingClientRect().height + 'px';
                    }
                }, 50);
            }
        }
        requestAnimationFrame(() => trySetup(0));
    }

    window.addEventListener('message', (event) => {
        const data = event.data;
        if (data.action === 'setupInventory') {
            cleanupGunRack();
            cleanupShopUI();
            const rightInv = data.data?.rightInventory;

            // Shop UI detection
            if (rightInv && rightInv.type === 'shop') {
                setupShopUI(rightInv.label);
            }

            // Gun rack detection
            if (rightInv && rightInv.type === 'glovebox' && rightInv.slots >= (GUN_RACK_START_SLOT + 1)) {
                const expectedSlots = rightInv.slots;
                // Wait for React to render the slots before extracting gun rack
                let attempts = 0;
                function waitForSlots() {
                    const rightPanel = document.querySelectorAll('.inventory-grid-wrapper')[1];
                    const grid = rightPanel?.querySelector('.inventory-grid-container');
                    const slots = grid?.querySelectorAll(':scope > .inventory-slot');
                    if (slots && slots.length >= expectedSlots) {
                        setupGunRack();
                    } else if (attempts < 20) {
                        attempts++;
                        requestAnimationFrame(waitForSlots);
                    }
                }
                requestAnimationFrame(waitForSlots);
            }
        } else if (data.action === 'closeInventory') {
            cleanupGunRack();
            cleanupShopUI();
        }
    });
})();
