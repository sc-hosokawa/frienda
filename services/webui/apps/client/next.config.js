/** @type {import('next').NextConfig} */
module.exports = {
  reactStrictMode: true,
  transpilePackages: ["ui"],
  images: {
    domains: ["localhost", "firebasestorage.googleapis.com", "i.scdn.co", "images.ctfassets.net"],
  },
};
