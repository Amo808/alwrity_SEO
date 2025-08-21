import type { NextConfig } from 'next';

const isProd = process.env.NODE_ENV === 'production';
const buildWithDocker = process.env.DOCKER === 'true';
const isDesktop = process.env.NEXT_PUBLIC_IS_DESKTOP_APP === '1';

const basePath = process.env.NEXT_PUBLIC_BASE_PATH;
const isStandaloneMode = buildWithDocker || isDesktop;

const standaloneConfig: NextConfig = {
  output: 'standalone',
  outputFileTracingIncludes: { '*': ['public/**/*', '.next/static/**/*'] },
};

// Simplified config for memory-constrained builds
const nextConfig: NextConfig = {
  ...(isStandaloneMode ? standaloneConfig : {}),
  basePath,
  compress: isProd,

  experimental: {
    serverMinification: false,
    optimizePackageImports: [
      '@lobehub/ui',
    ],
  },

  // Disable heavy features during build
  eslint: {
    ignoreDuringBuilds: true,
  },
  
  typescript: {
    ignoreBuildErrors: true,
  },

  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'x-robots-tag',
            value: 'all',
          },
        ],
      },
    ];
  },

  transpilePackages: ['pdfjs-dist'],

  webpack(config) {
    config.experiments = {
      asyncWebAssembly: true,
      layers: true,
    };

    // Reduce memory usage
    config.optimization = {
      ...config.optimization,
      splitChunks: {
        chunks: 'all',
        maxSize: 244000,
      },
    };

    return config;
  },
};

export default nextConfig;
