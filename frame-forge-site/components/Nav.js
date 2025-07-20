import Link from 'next/link'

export default function Nav() {
  return (
    <nav className="bg-black text-white px-6 py-4 shadow-md">
      <div className="max-w-6xl mx-auto flex justify-between items-center">
        <Link href="/" className="text-xl font-bold tracking-wide">
          Frame Forge
        </Link>
        <div className="space-x-4">
          <Link href="/about">About</Link>
          <Link href="/services">Services</Link>
          <Link href="/contact">Contact</Link>
        </div>
      </div>
    </nav>
  )
}

