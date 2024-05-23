/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
  theme: {
    screens: {
      "md": {"max": "1300px"},
      "sm": {"max": "900px"}
    },
    extend: {
      colors: {
        "container": "var(--container)",
        "highlight": "var(--highlight)"
      }
    },
  },
  plugins: [
    function ({ addVariant }) {
      addVariant('child', '& > *');
      addVariant('child-hover', '& > *:hover');
    }
  ],
}
