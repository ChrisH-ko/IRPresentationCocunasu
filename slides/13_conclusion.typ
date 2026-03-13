// ============================================================
//  slides/13_conclusion.typ  –  Summary + open questions
// ============================================================
#import "../helpers.typ": *

== Conclusions

  #grid(
    columns: (1fr, 1fr),
    gutter: 24pt,

    // ── left: three takeaways ──
    [
      *Three key findings — remember these:*

      #v(6pt)
      - *Position matters.* Place relevant docs *near the query* — the LLM cannot attend well to distant context.
      - *Distracting docs hurt.* Non-relevant top-$k$ docs *reduce* accuracy.
      - *Noise helps.* Random docs *improve* accuracy by up to 35–44%.

      #v(8pt)
      #finding-box[
        *Published at SIGIR 2024.* Code & data released at \
        #text(font: ("Courier New", "Courier", "Monaco"), size: 13pt)[github.com/florin-git/The-Power-of-Noise] \
        #text(size: 13pt, fill: c-muted)[129 citations as of Feb 2026.]
      ]
    ],

    // ── right: open questions ──
    [
      *Open questions & future work:*

      #v(6pt)
      - *Why* does noise help? The entropy hypothesis is suggestive but not proven.
      - Which properties make a document useful as filler?
      - Can we *train* a retriever with an objective aligned to LLM accuracy, not just relevance?
      - Do these findings hold for larger LLMs (13B, 70B)?
      - How do results change with instruction-tuned / RLHF models?
    ],
  )
