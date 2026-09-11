/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ['class'],
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        ink: '#0D0D0D',
        coal: '#121212',
        surface: '#1E1E1E',
        surface2: '#2A2A2A',
        line: '#2E3338',
        volt: '#C6FF00',
        voltdim: '#9FD028',
        heat: '#FF5B3D',
        muted2: '#9AA0A6',
      },
      borderRadius: {
        xl2: '1.1rem',
      },
      boxShadow: {
        voltglow: '0 0 24px rgba(198,255,0,.28)',
        card: '0 8px 30px rgba(0,0,0,.35)',
      },
    },
  },
  plugins: [],
}
