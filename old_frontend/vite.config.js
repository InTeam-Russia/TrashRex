import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import { viteSingleFile } from "vite-plugin-singlefile"
import externals from '@yellowspot/vite-plugin-externals'


// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), externals({
    jquery: `jQuery`,
  })],
})
