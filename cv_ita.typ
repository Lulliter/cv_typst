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

// Default style
#let color-accent-default = rgb("#dc3522")
#let font-header-default = ("Roboto", "Arial", "Helvetica", "Dejavu Sans")
#let font-text-default = ("Source Sans Pro", "Arial", "Helvetica", "Dejavu Sans")
#let align-header-default = center

// User defined style
#let color-accent = rgb("0088cc")
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
    weight: "thin",
    style: "italic",
    fill: color-accent,
  )
  body
}

/// Right section of a tertiaty headers.
/// - body (content): The body of the right header
#let tertiary-right-header(body) = {
  set text(
    weight: "light",
    size: 9pt,
    style: "italic",
    fill: color-gray,
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

  pad(bottom: 5pt)[
    #block[
      #set text(
        size: 32pt,
        style: "normal",
        font: (font-header),
      )
      #text(fill: color-gray, weight: "thin")[#firstname]
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
    size: 9pt,
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
    size: 9pt,
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
        size: 9pt,
        weight: "regular",
        style: "normal",
      )
      #align(horizon)[
        #for contact in contacts [
          #set box(height: 9pt)
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
  date: datetime.today().display("[month repr:long] [day], [year]"),
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
      #text[#strong[#text(color-accent)[#it.body.text.slice(0, 3)]#text(color-darkgray)[#it.body.text.slice(3)]]]
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
    address: unescape_text("Pavia, Italia"),
    position: unescape_text("Economista | Analista di politiche pubbliche | Consulente freelance"),
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
= Esperienza professionale
<esperienza-professionale>
#resume-entry(title: "Consulente in economia e valutazione di politiche pubbliche",location: "Milano, Italia & remoto",date: "Gen-2022 - Set-2024",description: "Libera Professione",)
#resume-item[
- Consulenza e formazione su gestione di dati e statistica/machine learning per enti pubblici, università, e centri studi
]
#resume-entry(title: "Esperto in Analisi di dati su fondi UE",location: "Roma, Italia",date: "Feb-2023 - Ago-2024",description: "Presidenza del Consiglio dei Ministri",)
#resume-item[
- Contributo al servizio di monitoraggio su interventi in ambito PNRR M5-C3 (coesione territoriale)
]
#resume-entry(title: "Sr. Economic Advisor - dossier infrastrutture",location: "Roma, Italia",date: "Feb-2020 - Dic-2021",description: "Ministero dell'Economia e delle Finanze",)
#resume-item[
- Supporto alla preparazione della Presidenza Italiana del G20 (2021) nel Gruppo di Lavoro Infrastrutture
]
#resume-entry(title: "Advisor",location: "Milano, Italia",date: "Feb-2020 - Mar-2020",description: "CSIL",)
#resume-item[
- Contributo alla preparazione di una proposta di ricerca su 'EU Lagging Regions: state of play and future challenges'
]
#resume-entry(title: "Research Fellow",location: "Washington DC, USA",date: "Mag-2018 - Ott-2019",description: "Banca Inter-Americana dello Sviluppo",)
#resume-item[
- Indagini statistiche multi-paese ed analisi sui dati relativi a offerta e domanda di acqua e servizi igienico-sanitari in America Latina
]
#resume-entry(title: "Sr. Monitoring & Evaluation Specialist",location: "Washington DC, USA",date: "Mar-2009 - Apr-2018",description: "Banca Mondiale",)
#resume-item[
- Ideazione e gestione di 2 sistemi di monitoraggio e valutazione (M&E); redazione di 3 articoli 'peer-reviewed' e vari rapport periodici per i finanziatori Europei di 2 Fondi Fiduciari
]
#resume-entry(title: "Research Assistant",location: "Washington DC, USA",date: "Ott-2008 - Feb-2009",description: "Banca Inter-Americana dello Sviluppo",)
#resume-item[
- Supporto a cooperazione tecnica con il Municipio di Fortaleza (Brasile) sul 'Programma Integrato di Inclusione Sociale per i Giovani' e preparazione di successivo prestito finalizzato
]
#resume-entry(title: "Stagista",location: "Rio e Belo Horizonte, Brasile",date: "Giu-2007 - Ago-2007",description: "AVSI",)
#resume-item[
- Partecipazione ad attività sul campo e raccolta dati sul progetto 'Conviver' promosso da AVSI e CEMIG per l'accesso legale e sostenibile all'energia elettrica dei residenti in alcune favelas di Belo Horizonte
]
#resume-entry(title: "Business Intelligence Analyst",location: "Milano, Italia",date: "Ott-2001 - Giu-2006",description: "Value Partners S.p.A.",)
#resume-item[
- Valutazione posizionamento competitivo e business intelligence per clienti pubblici e privati attivi in Italia, Europa, America Latina, Asia Sud-Orientale e Nord Africa
]
= Competenze professionali
<competenze-professionali>
• Eccellenti #strong[competenze analitiche];, perfezionate nell’ambito di programmi internazionali di sviluppo economico \
• #strong[Affidabilità, intraprendenza, e capacità di lavorare in squadra] dimostrate in ruoli di leadership nella gestione di progetti di ricerca e assistenza tecnica in vari contesti \
• Efficaci #strong[capacità di relazione e comunicazione];, comprovate da proficue collaborazioni professionali e svariate pubblicazioni e presentazioni \

#pagebreak()
= Istruzione
<istruzione>
#resume-entry(title: "Master in Politiche Pubbliche (2 anni)",location: "Georgetown University",date: "Mag-2008",description: "Politica Internazionale e Sviluppo",)
#resume-entry(title: "Laurea in Economia e Commercio (4 anni)",location: "Università di Pavia",date: "Apr-2001",description: "Economia Industriale",)
#resume-entry(title: "Programma Erasmus EU (2 semestri)",location: "Universidad Autonoma de Madrid",date: "Lug-1998",description: "Economia della UE",)
#resume-entry(title: "Diploma di Maturità (5 anni)",location: "Liceo Scientifico T. Olivelli",date: "Giu-1994",description: "Maturità scientifica",)
= Competenze linguistiche e informatiche
<competenze-linguistiche-e-informatiche>
#resume-entry(title: "Lingue",description: "Italiano (madrelingua), Inglese (C2), Spagnolo (C2), Portoghese (B1)",)
#resume-entry(title: "Pacchetti Office",description: "MS Office, GSuite, LibreOffice",)
#resume-entry(title: "Linguaggi di programmazione",description: "R, Stata, SQL",)
#resume-entry(title: "Altri Strumenti",description: " git, zsh, Markdown, RStudio, VSCode, Quarto, HTML & CSS",)
= Pubblicazioni sottoposte a revisione paritaria
<pubblicazioni-sottoposte-a-revisione-paritaria>
#resume-entry(title: "Italy in Front of the Challenge of Infrastructure Maintenance: Existing Issues and Promising Responses",location: "Public Works Management \& Policy",date: "Apr-2024",description: "Luisa M. Mimmi",)
#resume-item[
- https://journals.sagepub.com/doi/10.1177/1087724X231164648
]
#resume-entry(title: "Predicting Housing Deprivation from Space in the Slums of Dhaka",location: "Environment and Planning B: Urban Analytics and City Science",date: "Set-2022",description: "Amit Patel and Christian Borja-Vega and Luisa M. Mimmi and Tomas Soukup and Jan Kolomaznik",)
#resume-item[
- https://journals.sagepub.com/doi/10.1177/23998083221123589
]
#resume-entry(title: "From Informal to Authorized Electricity Service in Urban Slums: Findings from a Household Level Survey in Mumbai",location: "Energy for Sustainable Development",date: "Ago-2014",description: "Luisa M. Mimmi",)
#resume-item[
- http://linkinghub.elsevier.com/retrieve/pii/S0973082614000507
]
#resume-entry(title: "An Econometric Study of Illegal Electricity Connections in the Urban Favelas of Belo Horizonte, Brazil",location: "Energy Policy",date: "Set-2010",description: "Luisa M. Mimmi and Sencer Ecer",)
#resume-item[
- http://linkinghub.elsevier.com/retrieve/pii/S0301421510003113
]
= Altre pubblicazioni
<altre-pubblicazioni>

Vedere lista completa su #link("https://scholar.google.com/citations?user=OBYla5gAAAAJ&hl=en&oi=ao")[#strong[Profilo Google Scholar];]

#block(
fill:luma(221),
inset:8pt,
radius:4pt,
[
#set text(size: 8pt, weight: "medium", fill: rgb("#85144b"))

Autorizzo il trattamento dei miei dati personali ai sensi del Decreto Legislativo 30 giugno 2003, n. 196 e del GDPR (Regolamento UE 2016/679)
])
