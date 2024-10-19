#import "@preview/ctheorems:1.1.0": *
#import "@preview/wordometer:0.1.3": *

#let template(
  title: "Title",
  subtitle: "Subtitle",

  authors: (),
  affiliations: (),

  font-face: "New Computer Modern",

  colour_fg: rgb(0,0,0),
  colour_bg: rgb(255,255,255),
  colour_accent: rgb(0,0,0),

  header_title: "Short title", 
  paper_size: "a4",
  heading_numbering: "1.1.1",
  body
) = {
  set document(title: title, author: authors.map(author => author.name))
  show link: it => [#text(fill: colour_accent)[#it]]
  show ref: it => [#text(fill: colour_accent)[#it]]

  set page(
    fill: colour_bg,
    paper_size,
    margin: (left: 12%, right: 12%, top:8.8%, bottom:8.8%), // 1 inch on A4
    header: {
      align(right, text(header_title, colour_fg.lighten(10%)))
    },
    footer: block(
      width: 100%,
      stroke: (top: 1pt + gray),
      inset: (top: 8pt, right: 2pt),
      [
        #grid(columns: (75%, 25%),
          align(left, text(size: 9pt, fill: gray.darken(50%),
              (
                {datetime.today().display("[year]-[month]-[day]")}
              )
          )),
          align(right)[
            #text(
              size: 9pt, fill: gray.darken(50%)
            )[
              #counter(page).display() of #locate((loc) => {counter(page).final(loc).first()})
            ]
          ]
        )
      ]
    ),
  )
  set par(justify: true)
  show: thmrules
  show par: set block(spacing: 1em)
  /// Need to comment for now, because it is very annoying to have double spaced documents when working
  // set text(top-edge: 0.7em, bottom-edge: -0.3em) // Double spacing
  // set par(leading: 1em) // Needed for double spacing
  set text(font: font-face, size: 12pt)
  // Configure equation numbering and spacing.
  set math.equation(numbering: none)
  show math.equation: set block(spacing: 1em)
  show math.equation: set text(style: "normal", size: 12pt, weight: "regular", font: "New Computer Modern Math")
  
  set heading(numbering: heading_numbering)
  show heading: it => locate(loc => {
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(loc)
    set text(12pt, weight: 400)
    if it.level == 1 [
      // First-level headings are centered smallcaps.
      // We don't want to number of the acknowledgment section.
      #let is-ack = it.body in ([Acknowledgment], [Acknowledgement])
      // #set align(center)
      #set text(if is-ack { 12pt } else { 12pt })
      #show: smallcaps
      #v(20pt, weak: true)
      #if it.numbering != none and not is-ack {
        numbering(heading_numbering, ..levels)
        [.]
        h(7pt, weak: true)
      }
      #strong(it.body)
      #v(13.75pt, weak: true)
    ] else if it.level == 2 [
      // Second-level headings are run-ins.
      #set par(first-line-indent: 0pt)
      #set text(weight: "bold", size: 12pt)
      #v(10pt, weak: true)
      #if it.numbering != none {
        numbering(heading_numbering, ..levels)
        [.]
        h(12pt, weak: true)
      }
      #it.body
      #v(10pt, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 {
        numbering(heading_numbering, ..levels)
        [. ]
      }
      #underline((it.body)+":")
    ]
  })
  
  box(inset: (bottom: 2pt), text(17pt, weight: "bold", fill: colour_fg, title))
  v(-7pt)
  line(length: 93%)
  if subtitle != none {
    parbreak()
    box(text(14pt, fill: colour_fg.lighten(20%), subtitle))
  }
  v(-10pt)
  // table of contents
  text(outline(depth: 3, indent: 2em, title: "Table of Contents"))
  
  // Display the paper's contents.
  pagebreak()
  body
}

#let theorem = thmbox("theorem", "Theorem", stroke: rgb("000000"), radius: 0pt, clip: true)

#let properties = thmbox("property", "Properties", inset: (x: 0.2em, top: -1em, bottom:.2em))

#let corollary = thmplain(
  "corollary",
  "Corollary",
  base: "theorem",
  titlefmt: strong
)

#let definition = thmbox("definition", "Definition", inset: (x: 0.4em, top: 0.5em, bottom:.4em), stroke:1.2pt + black, radius: 0pt)

#let example = thmplain("example", "Example").with(numbering: none)

#let proof = thmplain(
  inset: (x: 0.2em, top: 1.2em, bottom:1.2em),
  "proof",
  "Proof",
  base: "theorem",
  titlefmt: strong,
  clip: true,
  bodyfmt: body => [#body \ #h(1fr) QED]
).with(numbering: none)

#let cong = $eq.triple$
#let implies = $arrow.double$