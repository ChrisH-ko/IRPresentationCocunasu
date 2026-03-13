// ============================================================
//  slides/10_why_noise_helps.typ  –  Attention entropy hypothesis
// ============================================================
#import "../helpers.typ": *

== Why Does Noise Help? The Attention Entropy Hypothesis

  #grid(
    columns: (1fr, 1fr),
    gutter: 24pt,

    // ── left ──
    [
      *Attention entropy experiment:*
      #v(6pt)
      Compare #prompt("I", "★", "Q") vs #prompt("I", "■■", "★", "Q"):

      #v(6pt)
      #block(
        fill: c-green.lighten(82%),
        stroke: c-green + 0.8pt,
        radius: 4pt,
        inset: 10pt,
      )[
        Attention entropy *increases ≈ 3×* when random documents are added.
      ]

      #v(10pt)

      *What is "entropy collapse"?*
      #v(4pt)
      Prior work (Attanasio et al., 2022; Hoffmann et al., 2023) shows that:

      #v(4pt)
      - Pathologically *low* attention entropy → degenerate, repetitive outputs
      - Also linked to worse factual grounding
    ],

    // ── right ──
    [
      #finding-box[
        *Hypothesis:* random documents act as "attention anchors," preventing the model from collapsing onto a narrow region of the context. Higher entropy = more distributed, more robust attention → better answers.
      ]

      #v(10pt)

      #warn-box[
        This is an *open hypothesis*, not a proven mechanism. The paper shows *correlation* (noise → higher entropy → better accuracy) but not causation. Explicitly flagged as future work.
      ]
    ],
  )
