import Head from 'next/head'
import Hero from '../components/Hero'

export default function Home() {
  return (
    <>
      <Head>
        <title>Frame Forge</title>
        <meta name="description" content="Custom high-performance gaming PCs" />
      </Head>

      {/* Hero Section */}
      <Hero
        headline="Forge Your Ultimate Gaming PC"
        subheadline="Custom builds, expert tuning, and unrivaled performance."
        ctaText="Get a Free Quote"
        ctaLink="/contact"
      />
    </>
  )
}

