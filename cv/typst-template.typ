#let hrule() = { line(length: 100%, stroke: 1pt + rgb("#002D72")) }

#let report(
  title: none,
  date: none,
  author: none,
  lang: none,
  content,

) = {
  set document(title: [Curriculum Vitae])
  set document(author: "Kevin B. McGowan")
  set document(date: datetime.today())
  set text(lang: "en")

  set page(
    paper: "us-letter",
    margin: (top: 0.5in, bottom: 1in, x: 0.75in),
  )
  set text(
    lang: "en",
    region: "US",
    font: "Roboto",
    size: 12pt,
  )
  show heading: it => {
    let sizes = (
      "1": 16pt, // Heading level 1
      "2": 12pt, // Heading level 2
    )
    let level = str(it.level)
    let size = sizes.at(level)
    let formatted_heading = if level == "2" { it } else { it }
    let alignment = if level == "2" { center } else { left }

    set text(
      font: "Roboto",
      fill: rgb("#002D72"),
      size: size,
      weight: "bold",
    )
    align(alignment)[#formatted_heading]
  }

  text(
      title,
      font: "Roboto",
      size: 20pt,
      fill: rgb("#002D72"),
      weight: "bold",
  )
  hrule()

  content
}

