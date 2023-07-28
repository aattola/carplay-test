module.exports = {
    arrowParens: 'avoid',
    bracketSpacing: true,
    singleQuote: true,
    trailingComma: 'none',
    printWidth: 80,
    bracketSameLine: false,
    semi: false,
    importOrder: ['react', '^@tankille/(.*)$', '^[./]'],
    importOrderSeparation: true,
    importOrderSortSpecifiers: true,
    importOrderParserPlugins: ['typescript', 'decorators-legacy', 'jsx']
}
