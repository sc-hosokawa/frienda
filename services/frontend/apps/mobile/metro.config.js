const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');
const path = require('path');

/**
 * Metro configuration
 * https://facebook.github.io/metro/docs/configuration
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = {
  watchFolders: [path.resolve(__dirname, '../../node_modules')],
  resolver: {
    unstable_enableSymlinks: true,
    unstable_enablePackageExports: true,
  },
  transformer: {
    /**
     * モノレポでAndroidが静的ファイルを読み込めるようにするための設定
     * Androidの画像のホスト先
     */
    publicPath: '/assets/dark/magic',
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: false,
      },
    }),
  },
  /**
   * モノレポでAndroidが静的ファイルを読み込めるようにするための設定
   * metroはnodeサーバを起動してエミュレーターを動かしている
   * 画像のホスト先を変更し、特定のリクエストを書き換えることで読み込めるようになる
   * assets/dark/magicはmetroがAndroidをビルドする時の画像の出力先になっている
   */
  server: {
    enhanceMiddleware: middleware => {
      return (req, res, next) => {
        if (req.url.startsWith('/assets/dark/magic')) {
          req.url = req.url.replace('/assets/dark/magic', '/assets');
        } else if (req.url.startsWith('/assets/dark')) {
          req.url = req.url.replace('/assets/dark', '/assets/..');
        } else if (req.url.startsWith('/assets')) {
          req.url = req.url.replace('/assets', '/assets/../..');
        }
        return middleware(req, res, next);
      };
    },
  },
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);
