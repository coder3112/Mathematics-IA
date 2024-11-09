#import "code.typ": code
#let appendix_code = [
  #set heading(numbering: none)
  = Appendix A: Code Used

  == Rotation Matrices
  #show link: underline
  Inspired by #link("https://articulatedrobotics.xyz/tutorials/coordinate-transforms/rotation-matrices-2d/")
  #let rot_code = read("rot_matrix.m")
  #show raw: it => text(it, font: "IBM Plex Mono")
  )
  #code( 
    stepnumber:1,
    numbers: true,
    caption: "Code: rot_matrix.m",
  )[#raw(rot_code, lang: "matlab")]
]