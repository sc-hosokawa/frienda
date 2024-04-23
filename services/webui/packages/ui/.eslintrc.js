/** @type {import("eslint").Linter.Config} */
module.exports = {
  root: true,
  extends: ["@repo/eslint-config/react-internal.js"],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: "./tsconfig.lint.json",
  },
  ignorePatterns: ["postcss.config.js", "tailwind.config.js"],
  rules: {
    "no-redeclare": ["error", { "builtinGlobals": false }]
  },
};
