module.exports = {
  darkMode: "class",
  mode: "jit",
  content: ["./*.html", "./src/**/*.purs"],
  theme: {
    extend: {
      fontFamily: {
        Rubik: ["Rubik", "sans-serif"],
        ZenKaku: ["Zen Kaku Gothic New", "sans-serif"],
        default: ["Rubik", "Zen Kaku Gothic New", "sans-serif"],
      },
    },
  },
  plugins: [],
};
