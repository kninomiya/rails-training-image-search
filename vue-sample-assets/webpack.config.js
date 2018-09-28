const CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = function(env, argv) {

    return {
        mode: argv.mode === 'production' ? "production" : "development",
        // メインとなるJavaScriptファイル（エントリーポイント）
        entry: './src/app.ts',
        // ファイルの出力設定
        output: {
            //  出力ファイルのディレクトリ名
            path: __dirname + "/js/",
            // 出力ファイル名
            filename:   'app.js'
        },
        devtool: argv.mode === 'production' ? false : "source-map",
        module: {
            rules: [
                {
                    test: /\.vue.html$/,
                    loader: 'html-loader',
                    exclude: /node_modules/,
                    options: {
                        minimize: true
                    }
                },
                {
                    test: /\.tsx?$/,
                    loader: 'ts-loader',
                    exclude: /node_modules/,
                    options: {
                        appendTsSuffixTo: [/\.vue$/],
                    }
                }
            ]
        },
        // import 文で .ts ファイルを解決するため
        resolve: {
            extensions: ['.ts', '.js', '.vue'],
            // Webpackで利用するときの設定
            alias: {
                vue: 'vue/dist/vue.js'
            }
        },
        plugins: [
            new CopyWebpackPlugin([
                {
                    from: __dirname + "/css/app.css",
                    to: __dirname + "/../app/assets/stylesheets/vue-sample-app.css",
                },
                {
                    from: __dirname + "/node_modules/vue-material/dist/vue-material.min.css",
                    to: __dirname + "/../app/assets/stylesheets/vue-material.min.css",
                },
                {
                    from: __dirname + "/node_modules/vue-material/dist/theme/default.css",
                    to: __dirname + "/../app/assets/stylesheets/default.css",
                },
                {
                    from: __dirname + "/js/app.js",
                    to: __dirname + "/../app/assets/javascripts/vue-sample-app.js",
                }
            ])
        ]
    };
};
