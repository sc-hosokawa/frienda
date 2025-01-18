const path = require("path");

/** @type {import('next').NextConfig} */
const nextConfig = {
  transpilePackages: ["@ui"],
  webpack: (config) => {
    config.resolve.alias = {
      ...config.resolve.alias,
      "@ui": path.resolve(__dirname, "../../packages/ui"),
    };
    return config;
  },
  images: {
    domains: [
      "localhost",
      "firebasestorage.googleapis.com",
      "i.scdn.co",
      "images.ctfassets.net",
    ],
  },
};

module.exports = nextConfig;
