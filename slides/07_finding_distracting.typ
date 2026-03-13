// ============================================================
//  slides/07_finding_distracting.typ  –  Distracting docs hurt
// ============================================================
#import "../helpers.typ": *

== Finding 2: Top-Ranked Docs That Miss the Answer #emph[Hurt]

  #set text(size: 16pt)
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,

    // ── left ──
    [
      *Standard assumption in RAG:*
      #v(3pt)
      - Retrieve top-$k$ documents by similarity score
      - Semantically close → helpful context

      #v(6pt)
      *What the paper shows instead:*
      #v(3pt)
      #surprise-box[
        Distracting documents #tag-distracting (high retrieval score, *no answer*) *decrease* LLM accuracy vs.\ using only the gold document.
      ]

      #v(6pt)
      *Example from the paper:*
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 4pt,
        inset: (x: 10pt, y: 7pt),
      )[
        #set text(size: 14pt)
        Query: _"What color was Napoléon's horse?"_
        #v(3pt)
        A doc about Joséphine de Beauharnais' horse scores high in the retriever (same historical context), but *does not contain the answer*.
      ]
    ],

    // ── right ──
    [
      *Baseline comparison (Llama2, Contriever, Near):*

      #v(6pt)
      #block(
        fill: rgb("#f4f6f7"),
        stroke: c-muted + 0.5pt,
        radius: 5pt,
        inset: (x: 12pt, y: 8pt),
      )[
        #set text(size: 14pt)
        #grid(
          columns: (1fr, auto),
          gutter: 6pt,
          [Only gold #prompt("I", "★", "Q")],
          text(fill: c-green, weight: "bold")[0.564],
          [Gold + 1 distracting #prompt("I", "▲", "★", "Q")],
          text(fill: c-red, weight: "bold")[↓ 0.428],
          [Gold + 2 distracting #prompt("I", "▲▲", "★", "Q")],
          text(fill: c-red, weight: "bold")[↓↓ 0.397],
        )
      ]

      #v(8pt)

      #finding-box[
        The *retriever's ranking score is not a reliable signal* for downstream LLM usefulness. High BM25/dense score ≠ helpful in the prompt.
      ]

      #v(4pt)
      #text(size: 13pt, fill: c-muted)[The paper's attention analysis shows the LLM *disproportionately attends* to distracting docs over the gold doc, explaining the wrong answers.]

      #v(4pt)
      #text(size: 13pt, fill: c-muted)[Confirmed with ADORE (hard-negative retriever) — same degradation.]
    ],
  )
