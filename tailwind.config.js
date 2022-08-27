module.exports = {
  darkMode: "class",
  mode: "jit",
  content: ["./*.html", "./src/**/*.purs"],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        "stripe-y" : "repeating-linear-gradient(0deg,#ffffff00, #ffffff00 2px, #000 2px, #000 4px)",
        "stripe-y-2xl" : "repeating-linear-gradient(var(--tw-rotate),#ffffff00, #ffffff00 30px, #00000000 30px, #00000000 60px)",
      },
      fontFamily: {
        Rubic: ["Rubik", "sans-serif"],
        ZenMaru: ["Zen Maru Gothic", "sans-serif"],
        SourceCodePro: ["Source Code Pro", "monospace"],
        PassionOne: [ 'Passion One', 'cursive'],
        default: ["Rubik", "Zen Maru Gothic", "sans-serif"],
      },
      animation: {
        "glitch-text": "glitch-text 3s linear infinite",
        "glitch": "glitch 3s linear infinite",
      },
      keyframes: {
        "glitch-text": {
          "0%, 9%, 11%, 39%, 41%, 69%, 71%, 79%, 81%, 100%": {
            "text-shadow":
              "0px 0px 4px white, 0px 0px 3px #00A75B, 0px 0px 3px #96007A",
            transform: "translate(0px)",
          },
          "10%": {
            "text-shadow":
              "0px 0px 6px white, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-1px)",
          },
          "40%": {
            "text-shadow":
              "-5px 0px 3px #96007A, 3px 0px 3px #00A75B",
            transform: "translate(2px)",
          },
          "70%": {
            "text-shadow":
              "0px 0px 6px white, 10px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-4px)",
          },
          "80%": {
            "text-shadow":
              "0px 0px 6px white, -30px 0px 3px #00A75B, 3px 0px 3px #96007A",
            transform: "translate(50px)",
          },
        },
        "glitch": {
          "0%, 9%, 11%, 39%, 41%, 69%, 71%, 79%, 81%, 100%": {
            "box-shadow":
              "0px 0px 4px white, 0px 0px 3px #00A75B, 0px 0px 3px #96007A",
            transform: "translate(0px)",
          },
          "10%": {
            "box-shadow":
              "0px 0px 6px white, 5px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-1px)",
          },
          "40%": {
            "box-shadow":
              "-5px 0px 3px #96007A, 3px 0px 3px #00A75B",
            transform: "translate(2px)",
          },
          "70%": {
            "box-shadow":
              "0px 0px 6px white, 10px 0px 3px #00A75B, -3px 0px 3px #96007A",
            transform: "translate(-4px)",
          },
          "80%": {
            "box-shadow":
              "0px 0px 6px white, -30px 0px 3px #00A75B, 3px 0px 3px #96007A",
            transform: "translate(50px)",
          },
        },
      },
    },
  },
  plugins: [],
};
