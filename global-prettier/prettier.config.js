/** @type {import("prettier").Config} */
export default {
  semi: false,
  singleQuote: true,
  tabWidth: 2,
  printWidth: 120,
  trailingComma: 'es5',
  htmlWhitespaceSensitivity: 'ignore',
  plugins: ['prettier-plugin-jinja-template', 'prettier-plugin-organize-attributes', 'prettier-plugin-tailwindcss'],
  overrides: [
    {
      files: ['*.jinja2'],
      options: {
        parser: 'jinja-template',
      },
    },
  ],
}
