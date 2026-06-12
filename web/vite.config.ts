import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  base: './',
  publicDir: false,
  build: {
    outDir: 'build',
    target: 'esnext',
    // Preserve hand-maintained files like assets/custom.css, assets/custom.js,
    // and the LICENSE (all referenced by fxmanifest) across rebuilds.
    // Vite's default `emptyOutDir: true` wipes the entire build/ folder.
    // Trade-off: stale `index-*.{js,css}` bundles from previous builds linger and
    // must be deleted by hand if you want to keep the assets/ folder lean — the
    // current index.html only loads the latest hashed pair, so leftovers are
    // wasted disk but harmless to runtime.
    emptyOutDir: false,
  },
  define: {
    'process.env': {},
  },
  esbuild: {
    logOverride: { 'this-is-undefined-in-esm': 'silent' },
  },
});
