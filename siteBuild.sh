#!/usr/bin/env bash
set -euo pipefail

# 1. Variables
PROJECT_NAME="frame-forge-site"
IMAGE_SRC="/mnt/data/FrameForge1.png"
LOGO_PLACEHOLDER="public/logo.svg"

# 2. Create project folder
echo "→ Creating project directory $PROJECT_NAME"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 3. Initialize npm & install deps
echo "→ Initializing npm and installing dependencies"
npm init -y
npm install next@14.0.0 react@18.2.0 react-dom@18.2.0
npm install -D tailwindcss@^3.2.0 postcss@^8.4.5 autoprefixer@^10.4.0

# 4. Create Next.js config files
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
}
module.exports = nextConfig
EOF

cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./pages/**/*.{js,jsx}",
    "./components/**/*.{js,jsx}"
  ],
  theme: {
    extend: {
      colors: {
        primary: "#1A1A1A",   // placeholder: update with your brand
        accent:  "#FFBF00"    // placeholder: update with your brand
      }
    }
  },
  plugins: [],
}
EOF

# 5. Scaffold directories
echo "→ Creating directories"
mkdir -p public styles components pages

# 6. Copy background image
if [ -f "$IMAGE_SRC" ]; then
  echo "→ Copying background image"
  cp "$IMAGE_SRC" public/background.png
else
  echo "⚠️  Warning: source image $IMAGE_SRC not found. Place your hero image at public/background.png manually."
fi

# 7. Create logo placeholder
cat > "$LOGO_PLACEHOLDER" << 'EOF'
<!-- TODO: Replace this SVG with your real logo -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect width="100" height="100" fill="#ddd"/>
  <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#999">Logo</text>
</svg>
EOF

# 8. Global CSS
cat > styles/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

html, body {
  padding: 0;
  margin: 0;
  font-family: system-ui, sans-serif;
}

a {
  color: inherit;
  text-decoration: none;
}
EOF

# 9. _app.js
cat > pages/_app.js << 'EOF'
import "../styles/globals.css";

export default function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}
EOF

# 10. Hero component
cat > components/Hero.js << 'EOF'
export default function Hero({ headline, subheadline, ctaText, ctaLink }) {
  return (
    <section
      className="h-screen bg-cover bg-center flex items-center justify-center"
      style={{ backgroundImage: "url('/background.png')" }}
    >
      <div className="bg-black bg-opacity-50 p-8 rounded text-center max-w-xl">
        <h1 className="text-4xl font-bold text-white mb-4">{headline}</h1>
        <p className="text-lg text-gray-200 mb-6">{subheadline}</p>
        <a
          href={ctaLink}
          className="inline-block bg-accent text-black font-semibold py-3 px-6 rounded"
        >
          {ctaText}
        </a>
      </div>
    </section>
  );
}
EOF

# 11. Home page
cat > pages/index.js << 'EOF'
import Hero from "../components/Hero";

export default function Home() {
  return (
    <>
      <Hero
        headline="Forge Your Ultimate Gaming PC"
        subheadline="Custom builds, expert tuning, and unrivaled performance."
        ctaText="Get a Free Quote"
        ctaLink="/contact"
      />
      {/* TODO: Add Services, Portfolio, Testimonials sections */}
    </>
  );
}
EOF

# 12. About, Services & Contact stubs
cat > pages/about.js << 'EOF'
export default function About() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">About Us</h1>
      <p>Placeholder content. Describe your story, team, and values here.</p>
    </main>
  );
}
EOF

cat > pages/services.js << 'EOF'
export default function Services() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">Services & Products</h1>
      <p>Placeholder content. List your PC builds, upgrades, and repair services.</p>
    </main>
  );
}
EOF

cat > pages/contact.js << 'EOF'
export default function Contact() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">Contact Us</h1>
      <form className="max-w-md">
        <label className="block mb-2">Name</label>
        <input type="text" className="w-full mb-4 p-2 border" />
        <label className="block mb-2">Email</label>
        <input type="email" className="w-full mb-4 p-2 border" />
        <label className="block mb-2">Message</label>
        <textarea className="w-full mb-4 p-2 border" rows="4" />
        <button className="bg-primary text-white py-2 px-4 rounded">
          Send Message
        </button>
      </form>
    </main>
  );
}
EOF

# 13. Final instructions
echo
echo "✅ Scaffold complete!"
echo "  • cd $PROJECT_NAME"
echo "  • npm run dev"
echo "Then visit http://localhost:3000 to see your new site."
echo "Next steps: swap in your real logo, update colors in tailwind.config.js, fill out page content, add Google Analytics, etc."

