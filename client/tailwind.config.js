/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{vue,js,ts,jsx,tsx}"],
  theme: {
    screens: {
      "md": {"max": "1300px"},
      "sm": {"max": "900px"},
      "convene-break": {"max": "1500px"}
    },
    extend: {
      colors: {
        "container": "var(--container)",
        "highlight": "var(--highlight)",
        "description": "var(--description)",

        "quality5": "var(--quality5)",
        "quality4": "var(--quality4)",
        "quality3": "var(--quality3)",
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
