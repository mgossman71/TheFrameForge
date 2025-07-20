#!/usr/bin/env bash
set -euo pipefail

# 1. Variables
PROJECT_NAME="frame-forge-site"
IMAGE_SRC="/mnt/data/FrameForge1.png"   # adjust path if needed

# 2. Create project directory
echo "→ Creating project directory $PROJECT_NAME"
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 3. Initialize npm and install dependencies
echo "→ Initializing npm & installing deps"
npm init -y
npm install next@14.0.0 react@18.2.0 react-dom@18.2.0
npm install -D tailwindcss@^3.2.0 postcss@^8.4.5 autoprefixer@^10.4.0

# 4. Add Next.js scripts
echo "→ Adding Next.js scripts to package.json"
npm pkg set scripts.dev "next dev"
npm pkg set scripts.build "next build"
npm pkg set scripts.start "next start"

# 5. Create config files
cat > next.config.js << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = { reactStrictMode: true }
module.exports = nextConfig
EOF

cat > postcss.config.js << 'EOF'
module.exports = {
  plugins: { tailwindcss: {}, autoprefixer: {} },
}
EOF

cat > tailwind.config.js << 'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./pages/**/*.{js,jsx}", "./components/**/*.{js,jsx}"],
  theme: { extend: {
    colors: {
      primary: "#1A1A1A",    // update to your brand
      accent:  "#FFBF00"     // update to your brand
    }
  }},
  plugins: [],
}
EOF

# 6. Make folders
echo "→ Making folders"
mkdir -p public/images styles components pages

# 7. Copy hero background into images/
if [ -f "$IMAGE_SRC" ]; then
  echo "→ Copying hero image to public/images/FrameForge1.png"
  cp "$IMAGE_SRC" public/images/FrameForge1.png
else
  echo "⚠️  Hero image not found at $IMAGE_SRC. Please place your image at public/images/FrameForge1.png."
fi

# 8. Logo placeholder (SVG)
cat > public/logo.svg << 'EOF'
<!-- TODO: Replace this with your real logo SVG -->
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect width="100" height="100" fill="#ddd"/>
  <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#999">Logo</text>
</svg>
EOF

# 9. Global CSS
cat > styles/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

html, body { margin: 0; padding: 0; font-family: system-ui, sans-serif; }
a { color: inherit; text-decoration: none; }
EOF

# 10. _app.js
cat > pages/_app.js << 'EOF'
import "../styles/globals.css";

export default function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />;
}
EOF

# 11. Hero component (updated path)
cat > components/Hero.js << 'EOF'
export default function Hero({ headline, subheadline, ctaText, ctaLink }) {
  return (
    <section
      className="h-screen bg-cover bg-center flex items-center justify-center"
      style={{ backgroundImage: "url('/images/FrameForge1.png')" }}
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

# 12. Home page
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

# 13. Stub pages
cat > pages/about.js << 'EOF'
export default function About() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">About Us</h1>
      <p>Placeholder for your About content.</p>
    </main>
  );
}
EOF

cat > pages/services.js << 'EOF'
export default function Services() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">Services & Products</h1>
      <p>Placeholder for your Services content.</p>
    </main>
  );
}
EOF

cat > pages/contact.js << 'EOF'
export default function Contact() {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-4">Contact Us</h1>
      <form className="max-w-md space-y-4">
        <div><label>Name</label><input type="text" className="w-full p-2 border rounded"/></div>
        <div><label>Email</label><input type="email" className="w-full p-2 border rounded"/></div>
        <div><label>Message</label><textarea className="w-full p-2 border rounded" rows="4"/></div>
        <button className="bg-primary text-white py-2 px-4 rounded">Send Message</button>
      </form>
    </main>
  );
}
EOF

echo
echo "✅ Scaffold complete!"
echo "   cd $PROJECT_NAME"
echo "   npm install    # (if you haven’t already)"
echo "   npm run dev    # start the dev server"
echo
echo "Visit http://localhost:3000 to see your updated hero background!"

