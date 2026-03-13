// ============================================================
//  slides/09_finding_noise_practice.typ  –  Noise in practice
// ============================================================
#import "../helpers.typ": *

== Finding 4: Noise Helps in a Realistic RAG Setting Too

  #set text(size: 16pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,

    // ── left ──
    [
      *Realistic setting:* retrieve with the IR system, then pad remaining context with random noise.

      #v(4pt)
      Prompt: #prompt("I", "■ ■ ■", "▲/●", "Q")
      #v(6pt)

      *Accuracy (Llama2-7b, NQ-open test set):*
      #v(4pt)
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 5pt,
        inset: (x: 12pt, y: 8pt),
      )[
        #set text(size: 14pt)
        #grid(
          columns: (1fr, auto),
          gutter: 5pt,
          [4 retrieved only (Contriever)],     text(fill: c-muted)[0.187],
          [+ fill with noise (Contriever)],    text(fill: c-green, weight: "bold")[0.253 #text(size: 11pt)[(+35%)]],
          [4 retrieved only (BM25)],           text(fill: c-muted)[0.203],
          [+ fill with noise (BM25)],          text(fill: c-green, weight: "bold")[0.293 #text(size: 11pt)[(+44%)]],
        )
      ]

      #v(6pt)
      #finding-box[
        Noise boost *carries over* to the realistic setting — and holds for different noise sources (Wikipedia, Reddit, random words).
      ]
    ],

    // ── right ──
    [
      *The retriever trade-off:*
      #v(4pt)
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 5pt,
        inset: (x: 12pt, y: 8pt),
      )[
        #set text(size: 14pt)
        #grid(
          columns: (auto, 1fr),
          gutter: 6pt,
          text(fill: c-green)[*Few retrieved (3–5)*],
          [mostly relevant → high signal],
          text(fill: c-red)[*Many retrieved (8+)*],
          [distractors creep in → accuracy drops],
        )
      ]

      #v(6pt)

      *Falcon:* did _not_ improve with noise in the oracle setting, but *does improve* in this realistic setting — suggesting the benefit is more general than the oracle results imply.

      #v(8pt)
      #warn-box[
        *Sweet spot:* retrieve *3–5 docs*, pad context with noise. More docs → more distractors.
      ]
    ],
  )

