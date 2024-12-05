#import "@preview/fontawesome:0.1.0": *

//------------------------------------------------------------------------------
// Style
//------------------------------------------------------------------------------

// const color
#let color-darknight = rgb("#131A28")
#let color-darkgray = rgb("#333333")
#let color-middledarkgray = rgb("#414141")
#let color-gray = rgb("#5d5d5d")
#let color-lightgray = rgb("#999999")

#let color-darklue = rgb("#004980")
#let color-accent = rgb("#0088cc") // deciso  in YAML

// Default style
#let color-accent-default = rgb("#dc3522")
#let font-header-default = ("Roboto", "Arial", "Helvetica", "Dejavu Sans")
#let font-text-default = ("Source Sans Pro", "Arial", "Helvetica", "Dejavu Sans")
#let align-header-default = center

// Lula LINK style (more visible )
#let link-style = (content) => {
  text(
    fill: rgb("#0054cc"), // Replace with your desired color
    underline: true       // Apply underline if needed
  )[content]
}

// User defined style
#let color-accent = rgb("7c1c2d")
#let font-header = font-header-default
#let font-text = font-text-default

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

// contaxt text parser
#let unescape_text(text) = {
  // This is not a perfect solution
  text.replace("\\", "").replace(".~", ". ")
}

// layout utility
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

/// Right section for the justified headers
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

/// Right section of a tertiaty headers.
/// - body (content): The body of the right header
#let tertiary-right-header(body) = {
  set text(
    weight: "light", // weight: "light", 
    size: 10pt,
    style: "italic",
    fill: color-darklue,// fill: color-gray,
  )
  body
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right.
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
#let justified-header(primary, secondary) = {
  set block(
    above: 0.7em,
    below: 0.7em,
  )
  pad[
    #__justify_align[
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
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
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
      #text(weight: "bold")[#firstname]
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
    size: 10pt,
    style: "normal",
    weight: "light",
    fill: color-darknight,
  )
  
  set par(leading: 0.65em)
  set list(indent: 1em)
  body
}

#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: ""
) = {
  pad[
    #justified-header(title, location)
    #secondary-justified-header(description, date)
  ]
}

//------------------------------------------------------------------------------
// Resume Template
//------------------------------------------------------------------------------

#let resume(
  title: "CV",
  author: (:),
//  date: datetime.today().display("[month repr:long] [day], [year]"),
  date: datetime.today().display("[day]/[month]/[year]"),
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

  set page(
    paper: "a4",
    margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
    footer: [
      #set text(
        fill: gray,
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
        #counter(page).display()
      ]
    ],
  )

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
      #text[#strong[#text(color-darklue)[#it.body.text.slice(0, 3)]#text(color-darklue)[#it.body.text.slice(3)]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]

  show heading.where(level: 2): it => {
    set text(
      color-middledarkgray,
      size: 12pt,
      weight: "thin"
    )
    it.body
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

// Typst custom formats typically consist of a 'typst-template.typ' (which is
// the source code for a typst template) and a 'typst-show.typ' which calls the
// template's function (forwarding Pandoc metadata values as required)
//
// This is an example 'typst-show.typ' file (based on the default template  
// that ships with Quarto). It calls the typst function named 'article' which 
// is defined in the 'typst-template.typ' file. 
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-template.typ' entirely. You can find
// documentation on creating typst templates here and some examples here:
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#show: resume.with(
  title: [Luisa M. Mimmi],
  author: (
    firstname: unescape_text("Luisa M."),
    lastname: unescape_text("Mimmi"),
    address: unescape_text("Italian citizen | Green card holder"),
    position: unescape_text("Economist | Policy Analyst | Freelance consultant"),
    contacts: ((
      text: unescape_text("lmm76\@georgetown.edu"),
      url: unescape_text("mailto:lmm76\@georgetown.edu"),
      icon: unescape_text("fa envelope"),
    ), (
      text: unescape_text("luisamimmi.org"),
      url: unescape_text("https:\/\/luisamimmi.org"),
      icon: unescape_text("assets/icon/bi-house-fill.svg"),
    ), (
      text: unescape_text("Luisa M. Mimmi"),
      url: unescape_text("https:\/\/www.linkedin.com/in/luisa-m-mimmi"),
      icon: unescape_text("fa brands linkedin"),
    ), (
      text: unescape_text("lulliter"),
      url: unescape_text("https:\/\/github.com/lulliter"),
      icon: unescape_text("fa brands github"),
    )),
  ),
)
= Work Experience
<work-experience>
#resume-entry(title: "Policy Analyst & Data Scientist",location: "Milan, Italy & remote",date: "Jan-2022 - Dec-2024",description: "Freelance Consulting",)
#resume-item[
- Advised different Italian entities (government, academia and think tanks) on data-driven policy analysis
]
#resume-entry(title: "Expert in EU Funds Analysis",location: "Rome, Italy",date: "Feb-2023 - Aug-2024",description: "Italian Presidency of the Council of Ministers",)
#resume-item[
- Advised on monitoring of PNRR (EU funds for regional cohesion)
]
#resume-entry(title: "Sr. Economic Advisor (G20 task force)",location: "Rome, Italy",date: "Feb-2020 - Dec-2021",description: "Italian Ministry of Economy & Finance",)
#resume-item[
- Contributed to the Infrastructure Working Group (IWG) during Italy's G20 Presidency in 2021
]
#resume-entry(title: "Advisor for EU funding proposal",location: "Milan, Italy",date: "Feb-2020 - Mar-2020",description: "CSIL",)
#resume-item[
- Advised on tender for research project on 'EU Lagging Regions: state of play and future challenges' funded by the EU
]
#resume-entry(title: "Research Fellow (Water Division)",location: "Washington DC, US",date: "May-2018 - Jan-2019",description: "Inter-American Development Bank",)
#resume-item[
- Conducted surveys and analyses of supply and demand of Water and Sanitation in Latin America
]
#resume-entry(title: "Senior M&E Specialist (at Multilateral Trust Funds)",location: "Washington DC, US",date: "Mar-2009 - Apr-2018",description: "World Bank",)
#resume-item[
- Designed and managed M&E frameworks for 2 multi-donor development trust funds: WPP and GPOBA
]
#resume-entry(title: "Policy Analyst (Social Protection & Health Div.)",location: "Washington DC, US",date: "Oct-2008 - Feb-2009",description: "Inter-American Development Bank",)
#resume-item[
- Social development project on education and vocational training in Fortaleza, Brazil
]
#resume-entry(title: "Summer Intern (Social Inclusion and Education)",location: "Rio and Belo Horizonte, Brazil",date: "Jun-2007 - Aug-2007",description: "AVSI International NGO",)
#resume-item[
- Initiated empirical study of slum electrification project 'Conviver' (Belo Horizonte)
]
#resume-entry(title: "Business Intelligence Analyst",location: "Milan, Italy",date: "Oct-2001 - Jun-2006",description: "Value Partners Management Consulting",)
#resume-item[
- Business intelligence analyses for several Italian clients and their domestic and international operations
]
= Education
<education>
#resume-entry(title: "M.P.P. in International Policy & Development (2 yr)",location: "Georgetown University",date: "May-2008",description: "International Policy & Development",)
#resume-entry(title: "B.Sc. in Economics & Business Administration (4 yr)",location: "Università di Pavia",date: "Apr-2001",description: "Industrial Economics",)
#resume-entry(title: "[Erasmus Exchange Student] (1 yr)",location: "Universidad Autonoma de Madrid",date: "Jul-1998",description: "EU Economics",)
#resume-entry(title: "High School Diploma (5 yr)",location: "Liceo Scientifico T. Olivelli",date: "Jun-1994",description: "STEM subjects",)
#pagebreak()
= Skills
<skills>
#resume-entry(title: "Languages",description: "Italian (native), English (proficient), Spanish (proficient), Portuguese (basic)",)
#resume-entry(title: "Office Suite",description: "MS Office, GSuite, LibreOffice",)
#resume-entry(title: "Programming Languages",description: "R, Stata, SQL",)
#resume-entry(title: "Misc. Dev. Tools",description: " git, zsh, Markdown, RStudio, VSCode, Quarto, HTML & CSS",)
#resume-entry(title: "Personal Skills",description: " Strong critical thinking and data analysis skills; Drive and resourcefulness in complex projects; Effective communication skills; Love for teaching",)
= Peer-reviewed Publications
<peer-reviewed-publications>
#resume-entry(title: "Italy in Front of the Challenge of Infrastructure Maintenance: Existing Issues and Promising Responses",location: "Public Works Management and Policy",date: "Apr-2024",description: "Luisa M. Mimmi",)
#resume-item[
- https://journals.sagepub.com/doi/10.1177/1087724X231164648
]
#resume-entry(title: "Predicting Housing Deprivation from Space in the Slums of Dhaka",location: "Environment and Planning B: Urban Analytics and City Science",date: "Sep-2022",description: "Amit Patel and Christian Borja-Vega and Luisa M. Mimmi and Tomas Soukup and Jan Kolomaznik",)
#resume-item[
- https://journals.sagepub.com/doi/10.1177/23998083221123589
]
#resume-entry(title: "From Informal to Authorized Electricity Service in Urban Slums: Findings from a Household Level Survey in Mumbai",location: "Energy for Sustainable Development",date: "Aug-2014",description: "Luisa M. Mimmi",)
#resume-item[
- http://linkinghub.elsevier.com/retrieve/pii/S0973082614000507
]
#resume-entry(title: "An Econometric Study of Illegal Electricity Connections in the Urban Favelas of Belo Horizonte, Brazil",location: "Energy Policy",date: "Sep-2010",description: "Luisa M. Mimmi and Sencer Ecer",)
#resume-item[
- http://linkinghub.elsevier.com/retrieve/pii/S0301421510003113
]
= Other Publications
<other-publications>

See complete list on #link("https://scholar.google.com/citations?user=OBYla5gAAAAJ&hl=en&oi=ao")[#strong[Google Scholar profile];]

= Conferences and Talks
<conferences-and-talks>
#resume-entry(title: "Una prospettiva europea per il patrimonio italiano: l'Italia di fronte alla sfida della manutenzione delle infrastrutture: questioni aperte e passi promettenti",location: "Pavia",date: "Feb-2024",description: "Lions Club Pavia Host, Distretto 108 Ib3",)
#resume-entry(title: "Principi, Tecniche e Strumenti per l'analisi Riproducibile Dei Dati",location: "Roma",date: "Jul-2023",description: "Seminario Formativo per Uff. PNRR (Presidenza Del Consiglio)",)
#resume-entry(title: "Infrastructure Maintenance among G20 Top Priorities",location: "online",date: "Nov-2021",description: "MOOC on 'QII and Green, Resilient and Inclusive Development'",)
