export default function Contact() {
  return (
    <div className="max-w-2xl mx-auto p-8">
      <h1 className="text-3xl font-bold mb-4">Contact Us</h1>
      <form className="space-y-4">
        <input type="text" placeholder="Your Name" className="w-full p-3 border rounded" />
        <input type="email" placeholder="Your Email" className="w-full p-3 border rounded" />
        <textarea rows="4" placeholder="Your Message" className="w-full p-3 border rounded" />
        <button className="bg-yellow-400 text-black px-6 py-2 rounded font-semibold">
          Send Message
        </button>
      </form>
    </div>
  )
}

