export default function Hero({ headline, subheadline, ctaText, ctaLink }) {
  return (
    <div className="relative h-screen w-full overflow-hidden">
      {/* Background Image */}
      <div
        className="absolute inset-0 z-0 bg-center"
        style={{
          backgroundImage: "url('/images/FrameForge2.png')",
          backgroundRepeat: "no-repeat",
          backgroundSize: "contain", // changed from "cover" to "contain"
          backgroundPosition: "center",
          backgroundColor: "#111", // fallback color for empty space
        }}
      />

      {/* Overlay */}
      <div className="absolute inset-0 z-10 bg-black bg-opacity-60" />

      {/* Foreground Content */}
      <div className="relative z-20 flex flex-col items-center justify-center h-full text-center p-8">
        <h1 className="text-4xl font-bold text-white mb-4">{headline}</h1>
        <p className="text-lg text-gray-200 mb-6">{subheadline}</p>
        <a
          href={ctaLink}
          className="inline-block bg-yellow-400 text-black font-semibold py-3 px-6 rounded"
        >
          {ctaText}
        </a>
      </div>
    </div>
  );
}

