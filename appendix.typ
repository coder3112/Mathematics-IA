#import "code.typ": code
#let appendix_code = [
  #set heading(numbering: none)
  = Appendix A: Code Used
  #show link: underline
  Inspired by #link("https://articulatedrobotics.xyz/tutorials/coordinate-transforms/rotation-matrices-2d/")
  == Rotation Matrices
  #v(8pt)
  #let rot_code = read("rot_matrix.m")
  #show raw: it => text(it, font: "IBM Plex Mono")
  #set raw(theme: "sublime.tmTheme")
  #code( 
    stepnumber:1,
    numbers: true,
    caption: "Code: rot_matrix.m",
  )[#raw(rot_code, lang: "matlab")]

  == Squeeze Matrices
  #v(8pt)
  #let squeeze_code = read("squeeze_matrix.m")
  #code( 
    stepnumber:1,
    numbers: true,
    caption: "Code: squeeze_matrix.m",
  )[#raw(squeeze_code, lang: "matlab")]

  == Scale Matrices
  #v(8pt)
  #let scale_code = read("scale_matrix.m")
  #code( 
    stepnumber:1,
    numbers: true,
    caption: "Code: scale_matrix.m",
  )[#raw(scale_code, lang: "matlab")]
]