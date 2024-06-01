const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        maru: ['Zen Maru Gothic', 'serif'],
      },
      colors: {
        'park': '#0A6380',
      },
      textUnderlineOffset: {
        12: '12px',
      },
    },
  },
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "accent": "#E9EEE9",
          "primary": "#059669",
          "neutral": "#d4d4d4",
          "secondary": "#ede9fe",
        },
      },
      "pastel",
    ],
  },
}
