//
// lint-staged.config.js
//

// Setup:
// [run]
// npm pkg set scripts.format:lint-staged="prettier --write"
// npm pkg set scripts.eslint:lint-staged="eslint --fix"
// npm pkg set scripts.stylelint:lint-staged="stylelint --fix"
// npm pkg set scripts.format:dart:lint-staged="dart format --fix"
// npm pkg set scripts.dartlint:lint-staged="dart fix --apply"
// [/run]

const path = require('path');

/** @type {import("lint-staged").configObject} */
const config = {
  // Formatting
  // [Terraform]
  '**/*.tf': (filenames) => filenames.map((filename) => `npm run format:terraform '${filename}'`),
  // [JSON]
  '**/*.json': (filenames) => filenames.map((filename) => `npm run format:lint-staged '${filename}'`),
  // [YAML]
  '**/*.{yaml,yml}': (filenames) => filenames.map((filename) => `npm run format:lint-staged '${filename}'`),
  // [Markdown]
  '**/*.{md,mdx}': (filenames) => filenames.map((filename) => `npm run format:lint-staged '${filename}'`),
  // [Dart]
  //'**/*.dart': (filenames) => filenames.map((filename) => `npm run format:dart:lint-staged '${filename}'`),

  // Linting
  // [Terraform]
  //'**/*.tf': (filenames) => `tflint --recursive`
  '**/*.tf': (filenames) => {
    const directories = filenames.map((filename) => path.dirname(filename));
    const uniqueDirectories = [...new Set(directories)];
    return uniqueDirectories.map((dir) => `tflint --recursive --chdir ${dir}`);
  }
  // Uncomment if needed
  // [JS/TS/Vue]
  // '**/*.{js,jsx,ts,tsx,vue}': (filenames) => filenames.map((filename) => `npm run eslint:lint-staged '${filename}'`),
  // [CSS/SASS/SCSS]
  // '**/*.{sass,scss,css}': (filenames) => filenames.map((filename) => `npm run stylelint:lint-staged '${filename}'`),
  // [Dart]
  //'**/*.dart': (filenames) => filenames.map((filename) => `npm run dartlint:lint-staged '${filename}'`),
  // [Terraform]
}
module.exports = config
