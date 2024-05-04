const path = require('path');

module.exports = {
    mode: 'development',
    entry: './src/index.jsx',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'build'),
    },
    externalsType: 'script',
    externals: {
        // Вместо YOUR_API_KEY подставить значение настоящего ключа
        ymaps3: 'ymaps3'
    },
    devtool: 'cheap-source-map'
};
