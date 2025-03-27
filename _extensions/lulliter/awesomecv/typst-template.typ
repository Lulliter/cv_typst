//------------------------------------------------------------------------------
// ICONS
//------------------------------------------------------------------------------
#import "@preview/fontawesome:0.1.0": *

//------------------------------------------------------------------------------
// Style
//------------------------------------------------------------------------------

// const color
#let color-darknight = rgb("#131A28")
#let color-darkgray = rgb("#333333")
#let color-middledarkgray = rgb("#414141")
#let color-gray = rgb("#5d5d5d")
#let color-footergray = rgb("#7d7d7d")
#let color-lightgray = rgb("#999999")
#let color-link = rgb("#0063B2")

// Lula's
#let color-darkblue = rgb("#004980") // dark blue
#let color-accent = rgb("#0084c8") // deciso  in YAML
#let color-accent-red = rgb("#7c1c2d") // antique ruby


// Default style
#let color-accent-default = rgb("#dc3522")
#let font-header-default = ("Roboto", "Arial", "Helvetica", "Dejavu Sans", "Avenir Next", "Optima")
#let font-text-default = ("Source Sans Pro", "Arial", "Helvetica", "Dejavu Sans")
#let align-header-default = center

// User defined style
$if(style.color-accent)$
#let color-accent = rgb("$style.color-accent$")
$else$
#let color-accent = color-accent-default
$endif$
$if(style.font-header)$
#let font-header = "$style.font-header$"
$else$
#let font-header = font-header-default
$endif$
$if(style.font-text)$
#let font-text = "$style.font-text$"
$else$
#let font-text = font-text-default
$endif$

//------------------------------------------------------------------------------
// Helper functions
//------------------------------------------------------------------------------

// icon string parser
#let parse_icon_string(icon_string) = {
  if icon_string.starts-with("fa ") [
    #let parts = icon_string.split(" ")
    #if parts.len() == 2 {
      fa-icon(parts.at(1), fill: color-darknight)
    } else if parts.len() == 3 and parts.at(1) == "brands" {
      fa-icon(parts.at(2), fa-set: "Brands", fill: color-darknight)
    } else {
      assert(false, "Invalid fontawesome icon string")
    }
  ] else if icon_string.ends-with(".svg") [
    #box(image(icon_string))
  ] else {
    assert(false, "Invalid icon string")
  }
}

// contact text parser
#let unescape_text(text) = {
  // This is not a perfect solution
  text.replace("\\", "").replace(".~", ". ")
}


// layout FOOTER (I think!)
#let __justify_align_3(left_body, mid_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(center)[
        #mid_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

// -------- CV ENTRIES -----------
// layout utility (GENERALE)
#let __justify_align(left_body, right_body) = {
  block[
    #box(width: 4fr)[#left_body]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

// layout utility (LOCATION)
#let __justify_align_location(left_body, right_body) = {
  block[
    #box(width: 5fr)[#left_body]
    #box(width: 3fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

/// Right section for the justified headers ------- (LOCATION)
/// - body (content): The body of the right header
#let secondary-right-header(body) = {
  set text(
    size: 10pt,
    weight: "light",
    style: "italic",
    fill: color-accent,
  )
  body
}

/// Right section of a tertiaty headers ------- (FROM-TO)
/// - body (content): The body of the right header
#let tertiary-right-header(body) = {
  set text(
    weight: "light", // weight: "light",
    size: 10pt,
    style: "italic",
    fill: color-darkblue,// fill: color-gray,
  )
  body
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right.
/// - primary (content): The primary section of the header ------- (ORG)
/// - secondary (content): The secondary section of the header ------- (LOCATION)
#let justified-header(primary, secondary) = {
  set block(
    above: 0.7em,
    below: 0.7em,
  )
  pad[
    #__justify_align_location[
      #set text(
        size: 12pt,
        weight: "bold",
        fill: color-darkgray,
      )
      #primary
    ][
      #secondary-right-header[#secondary]
    ]
  ]
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right. This is a smaller header compared to the `justified-header`.
/// - primary (content): The primary section of the header ------- (DESCRIPTION)
/// - secondary (content): The secondary section of the header () ------- (FROM - TO)
#let secondary-justified-header(primary, secondary) = {
  __justify_align[
     #set text(
      size: 10pt,
      weight: "regular",
      fill: color-gray,
    )
    #primary
  ][
    #tertiary-right-header[#secondary]
  ]
}

// Added Option when I want TITLE -- WHERE -- FROM-TO in one line  ---
#let single-line-header(primary, middle, secondary) = {
  set block(
    above: 0.7em,
    below: 0.7em,
  )
  pad[
    #box(width: 7fr)[
      #set text(
        size: 12pt,
        weight: "bold",
        fill: color-darkgray,
      )
      #primary
    ]
    #box(width: 5fr)[
      #align(right)[
        #set text(fill: color-darkblue)
        #middle
      ]
    ]
    #box(width: 3fr)[
      #align(right)[
        #set text(fill: color-accent)
        #secondary
      ]
    ]
  ]
}

//------------------------------------------------------------------------------
// Header
//------------------------------------------------------------------------------

#let create-header-name(
  firstname: "",
  lastname: "",
) = {

  pad(bottom: 7pt)[
    #block[
      #set text(
        size: 26pt,
        style: "normal",
        font: (font-header),
      )
      #text(weight: "bold")[#firstname] // Lula's
      //#text(fill: color-gray, weight: "thin")[#firstname]
      #text(weight: "bold")[#lastname]
    ]
  ]
}

#let create-header-position(
  position: "",
) = {
  set block(
      above: 0.75em,
      below: 0.75em,
    )

  set text(
    color-accent,
    size: 10pt,
    weight: "regular",
  )

  smallcaps[
    #position
  ]
}

#let create-header-address(
  address: ""
) = {
  set block(
      above: 0.75em,
      below: 0.75em,
  )
  set text(
    color-lightgray,
    size: 10pt,
    style: "italic",
  )

  block[#address]
}

// QUI link
#let create-header-contacts(
  contacts: (),
) = {
  let separator = box(width: 2pt)
  if(contacts.len() > 1) {
    block[
      #set text(
        size: 10pt,
        weight: "regular",
        style: "normal",
      )
      #align(horizon)[
        #for contact in contacts [
          #set box(height: 10pt)
          #box[#parse_icon_string(contact.icon) #link(contact.url)[#contact.text]]
          #separator
        ]
      ]
    ]
  }
}

#let create-header-info(
  firstname: "",
  lastname: "",
  position: "",
  address: "",
  contacts: (),
  align-header: center
) = {
  align(align-header)[
    #create-header-name(firstname: firstname, lastname: lastname)
    #create-header-position(position: position)
    #create-header-address(address: address)
    #create-header-contacts(contacts: contacts)
  ]
}

#let create-header-image(
  profile-photo: ""
) = {
  if profile-photo.len() > 0 {
    block(
      above: 15pt,
      stroke: none,
      radius: 9999pt,
      clip: true,
      image(
        fit: "contain",
        profile-photo
      )
    )
  }
}

#let create-header(
  firstname: "",
  lastname: "",
  position: "",
  address: "",
  contacts: (),
  profile-photo: "",
) = {
  if profile-photo.len() > 0 {
    block[
      #box(width: 5fr)[
        #create-header-info(
          firstname: firstname,
          lastname: lastname,
          position: position,
          address: address,
          contacts: contacts,
          align-header: left
        )
      ]
      #box(width: 1fr)[
        #create-header-image(profile-photo: profile-photo)
      ]
    ]
  } else {

    create-header-info(
      firstname: firstname,
      lastname: lastname,
      position: position,
      address: address,
      contacts: contacts,
      align-header: center
    )

  }
}

//------------------------------------------------------------------------------
// Resume Entries
//------------------------------------------------------------------------------

#let resume-item(body) = {
  set text(
    size: 11pt,
    style: "normal",
    weight: "light",
    fill: color-darknight,
  )

  set par(leading: 0.65em)
  set list(indent: 1em)
  body
}

// original EXPERIENCE 2- LINE HEADER
// #let resume-entry(
//   title: none,
//   location: "",
//   date: "",
//   description: ""
// ) = {
//   pad[
//     #justified-header(title, location)
//     #secondary-justified-header(description, date)
//   ]
// }

// QUI - REVISED EXPERIENCE 1- LINE HEADER
#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: ""
) = {
  pad(
    if description == "" [
      #single-line-header(title, location, date)
    ] else [
      #justified-header(title, location)
      #secondary-justified-header(description, date)
    ]
  )
}

//------------------------------------------------------------------------------
// Data to Resume Entries
//------------------------------------------------------------------------------
#let data-to-resume-entries(
  data: (),
) = {
  let arr = if type(data) == "dictionary" { data.values() } else { data }
  for item in arr [
    #resume-entry(
      title: if "title" in item { item.title } else { none },
      location: if "location" in item { item.location } else { "" },
      date: if "date" in item { item.date } else { none },
      description: if "description" in item { item.description } else { "" }
    )
    #if "details" in item {
      resume-item[
        #for detail in item.details [
          - #detail
        ]
      ]
    }
  ]
}


//------------------------------------------------------------------------------
// Resume Template
//------------------------------------------------------------------------------

#let resume(
  title: "CV",
  author: (:),
//  date: datetime.today().display("[month repr:long] [day], [year]"),
  date: datetime.today().display("[day]/[month]/[year]"), // Lula's
  profile-photo: "",
  body,
) = {

  set document(
    author: author.firstname + " " + author.lastname,
    title: title,
  )

  set text(
    font: (font-text),
    size: 11pt,
    fill: color-darkgray,
    fallback: true,
  )
  // [LULA's] LINK color
  // (hover behavior is automatic)
  show link: it => {
     text(fill: color-link)[#it]
   }

//  // ------- FOOTER (start) -------

  set page(
   paper: "a4",
   margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
   footer: [
     #set text(
       fill: color-footergray,
       size: 8pt,
     )
     #__justify_align_3[
       #smallcaps[#date]
     ][
       #smallcaps[
         #author.firstname
         #author.lastname
         #sym.dot.c
         CV
       ]
     ][
      //  #counter(page).display()
    #counter(page).display(
    "1/1",
    both: true,
  )    
      ]
   ],
 )


// ------- FOOTER (end) -------

  // set paragraph spacing
  set heading(
    numbering: none,
    outlined: false,
  )

  show heading.where(level: 1): it => [
    #set block(
      above: 1.5em,
      below: 1em,
    )
    #set text(
      size: 16pt,
      weight: "regular",
    )

    #align(left)[
      // #text[#strong[#text(color-accent)[#it.body.text.slice(0, 3)]#text(color-darkgray)[#it.body.text.slice(3)]]]
      #text[#strong[#text(color-darkblue)[#it.body.text.slice(0, 3)]#text(color-darkblue)[#it.body.text.slice(3)]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]

// LULA: INTERMEDIATE WORK EXPERIENCE HEADER
show heading.where(level: 2): it => { // QUESTO IN REALTA CORRISPONDE A "###" !!!!!!!!!
  set text(
    font: "Avenir Next",  // Using Arial for a wider font
    size: 13pt,
    weight: "regular",
    style: "italic",
    fill: color-accent,
  )
  align(center)[#it.body]
}

  show heading.where(level: 3): it => {
	   set text(
      size: 10pt,
      weight: "regular",
      fill: color-gray,
    )
    smallcaps[#it.body]
  }

  // Contents
  create-header(firstname: author.firstname,
                lastname: author.lastname,
                position: author.position,
                address: author.address,
                contacts: author.contacts,
                profile-photo: profile-photo,)
  body
}
