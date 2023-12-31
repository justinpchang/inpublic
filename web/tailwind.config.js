/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    screens: {
      sm: "480px",
      md: "760px",
      lg: "976px",
      xl: "1440px",
    },
    extend: {
      colors: {
        mulberry: {
          500: "#C74892",
          600: "#C60F7B",
        },
        teal: {
          500: "#12B5AA",
          600: "#0D9B91",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
