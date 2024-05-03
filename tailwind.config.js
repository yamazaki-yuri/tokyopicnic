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
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
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
    require('@tailwindcss/forms'),
    require("daisyui")
  ],
  daisyui: {
    themes: [
      {
        mytheme: {
          "accent": "#E9EEE9",
          "primary": "96D691",
        },
      },
      "pastel",
    ],
  },
}
