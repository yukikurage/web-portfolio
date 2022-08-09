module.exports = {
  darkMode: "class",
  mode: "jit",
  content: ["./*.html", "./src/**/*.purs"],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
      },
      fontFamily: {
        Rubik: ["Rubik", "sans-serif"],
        ZenKaku: ["Zen Kaku Gothic New", "sans-serif"],
        Bungee: ["Bungee", "cursive"],
        SourceCodePro: ["Source Code Pro", "monospace"],
        default: ["Rubik", "Zen Kaku Gothic New", "sans-serif"],
      },
      animation: {
        "glitch-text": "glitch-text 3s linear infinite",
        "glitch": "glitch 3s linear infinite",
      },
      keyframes: {
        "glitch-text": {
          "0%, 9%, 11%, 39%, 41%, 69%, 71%, 79%, 81%, 100%": {
            "text-shadow":
              "0px 0px 6px black, 0px 0px 3px #00A75B, 0px 0px 3px #96007A",
            transform: "translate(0px)",
          },
          "10%": {
            "text-shadow":
              "0px 0px 6px black, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-1px)",
          },
          "40%": {
            "text-shadow":
              "0px 0px 6px black, -5px 0px 3px #96007A, 3px 0px 3px #00A75B",
            transform: "translate(2px)",
          },
          "70%": {
            "text-shadow":
              "0px 0px 6px black, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-3px)",
          },
          "80%": {
            "text-shadow":
              "0px 0px 6px black, -5px 0px 3px #00A75B, 3px 0px 3px #96007A",
            transform: "translate(2px)",
          },
        },
        "glitch": {
          "0%, 9%, 11%, 39%, 41%, 69%, 71%, 79%, 81%, 100%": {
            "box-shadow":
              "0px 0px 6px black, 0px 0px 3px #00A75B, 0px 0px 3px #96007A",
            transform: "translate(0px)",
          },
          "10%": {
            "box-shadow":
              "0px 0px 6px black, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-1px)",
          },
          "40%": {
            "box-shadow":
              "0px 0px 6px black, -5px 0px 3px #96007A, 3px 0px 3px #00A75B",
            transform: "translate(2px)",
          },
          "70%": {
            "box-shadow":
              "0px 0px 6px black, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-3px)",
          },
          "80%": {
            "box-shadow":
              "0px 0px 6px black, -5px 0px 3px #00A75B, 3px 0px 3px #96007A",
            transform: "translate(2px)",
          },
        },
      },
    },
  },
  plugins: [],
};
