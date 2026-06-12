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
    emptyOutDir: false,
    rolldownOptions: {
      output: {
        assetFileNames: 'assets/[name][extname]',
        entryFileNames: 'assets/[name].js',
        chunkFileNames: 'assets/[name].js',
      },
    },
  },
});
