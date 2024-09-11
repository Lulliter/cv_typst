# overall --------------------------------------------------------
# This is the INPUT for building a CV with the vitae packg " 
# 
# It works using `vitae::detailed_entries`   
# work %>%
# vitae::detailed_entries(
#   with =  unit , #scambiati x spazio
#   what = title,
#   why = detail,
#   when = glue::glue("{startMonth} {startYear}-{endMonth} {endYear}",.na = ""),
#   where = where #scambiati x spazio
# )

# notes (?) -------------------------------------------------------------------
# `detail` are bullet points stored as VECTOR of strings 
# repetition of lines is to put more then 1 bullet
# 
# INACTIVE HYPERLINKS WILL CRUSH LATEX!!!!!
# LINK can be added with `"\\href{url}{post name}" [BUT IS HAS TO BE THE ENTIRE cell, i.e. not part of a string!?!]


# packg -------------------------------------------------------------------
#devtools::install_github("krlmlr/deparse")

# if (cond) expr
if (!require("pacman")) install.packages("pacman")
p_load('vitae'     # The CV's LaTeX Template
       ,'tibble'    # Data structure for tribbles
       ,'dplyr' 
       ,'lubridate'
       ,'magrittr'  # The Pipe %>%
       ,'here'      # Relative File Paths
       ,'readxl'
       ,'readr'     # Data Loading
       ,'glue'      # String Manipulation
       ,'rorcid'
       ,'RefManageR', 'bibtex'
       ,'scholar'
       ,'bib2df'
       ,'deparse'
       ,'datapasta' 
       #'paint'
)


# *** ---------------------------------------------------------------------

## [ENG] EMPLOYMENT (START/END dd--mm--yyy)--------------------------------------------------------------
# work <- read_csv("data/work.csv", na = "null")
# write.csv(work, file = "data/work.csv",   na = "", qmethod = "escape")
work <- read_csv(here("data", "work.csv"), show_col_types = FALSE)

## [ITA] EMPLOYMENT (START/END dd--mm--yyy)--------------------------------------------------------------
work_ita <- read_csv(here("data", "work_ita.csv"), show_col_types = FALSE)
#work_ita2 <- read_csv(here("data", "work_ita2.csv"), show_col_types = FALSE)
work_ita2 <- read_delim("data/work_ita2.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE, show_col_types = FALSE)

## [ENG] OTHER PROFESSIONAL SERVICE ----------------------------------------
service <- read_csv(here("data", "service.csv"), show_col_types = FALSE)

## [ITA] OTHER PROFESSIONAL SERVICE ----------------------------------------
service_ita <- read_csv(here("data", "service_ita.csv"), show_col_types = FALSE)

## [ENG] DS PROJECTS ----------------------------------------------------------------
projects <- read_csv(here("data", "projects.csv"), show_col_types = FALSE)

projects2 <- read_csv(here("data", "projects2.csv"), show_col_types = FALSE)


## *** [ITA] DS PROJECTS ----------------------------------------------------------------
projects2_ita <- read_csv(here("data", "projects2_ita.csv"), show_col_types = FALSE)

## [ENG] EDUCATION ---------------------------------------------------------------
# Diploma di Laurea, Università degli Studi di Pavia, DATE = 19 of April 2001, ADDRESS = Corso Str. Nuova, 65, 27100 Pavia PV, Italy
# Master of Public Policy, Georgetown University, DATE = 16 of May 2008, ADDRESS = 3700 O St NW, Washington, DC 20057, United States

edu <- read_csv(here("data", "edu.csv"), show_col_types = FALSE)

## [ITA] EDUCATION ---------------------------------------------------------------
edu_ita <- read_csv(here("data", "edu_ita.csv"), show_col_types = FALSE)


## [ENG] HONORS & AWARDS ---------------------------------------------------------------
# Diploma di Laurea, Università di Pavia, DATE = 19 of April 2001, ADDRESS = Corso Str. Nuova, 65, 27100 Pavia PV, Italy
# Master of Public Policy, Georgetown University, DATE = 16 of May 2008, ADDRESS = 3700 O St NW, Washington, DC 20057, United States

honors <- read_csv(here("data", "honors.csv"), show_col_types = FALSE)

## [ITA] HONORS & AWARDS ---------------------------------------------------------------
honors_ita <- read_csv(here("data", "honors_ita.csv"), show_col_types = FALSE)


## [ENG] SOFTWARE ---------------------------------------------------------------
software <- read_csv(here("data", "software.csv"), show_col_types = FALSE)

## [ITA] SOFTWARE ----------------------------------------
software_ita <- read_csv(here("data", "software_ita.csv"), show_col_types = FALSE)


## ***[ENG] LANGUAGES ---------------------------------------------------------------
 
## ***[ITA] LANGUAGES ----------------------------------------
 

##  [ENG] COURSES & TRAINING ----------------------------------------
courses <- read_csv(here("data", "courses.csv"), show_col_types = FALSE)

##  [ITA] COURSES & TRAINING ----------------------------------------
courses_ita <- read_csv(here("data", "courses_ita.csv"), show_col_types = FALSE)


# TALKS (I split COLLECTIONS in Zotero) --------------------------------------------------------
lula_talks <- RefManageR::ReadBib(file = here::here("data", "Lula-MyTalks.bib"),
                                  .Encoding ="UTF-8"
) %>% 
  as.data.frame()

# 
# PUBLICATIONS (I split COLLECTIONS in Zotero) --------------------------------------------------------
lula_pub <- RefManageR::ReadBib(
  file = here::here("data", "Lula-MyPublication-Narrow.bib"),
  .Encoding ="UTF-8") %>%   
  as.data.frame() %>% 
  dplyr::filter(bibtype != "Online")  

#paint(lula_pub)

peer_pub <- lula_pub %>% 
  filter(type == "Peer-reviewed") %>% 
  #mutate(date  =  as.Date(date, format = "%Y-%m") ) %>% 
  mutate(date2  =  lubridate::ym(date)) %>%  # aggiunge giorno
  mutate(year  =  lubridate::year(date2)) %>%   
  mutate(month  =  lubridate::month(date2)) %>%   
  select( author, date, year, month,    journaltitle,   doi)

#paint(peer_pub)
# Functions  --------------------------------------------------------------
#source(here::here("R", "parse-citations.R"))

# filter blogs       
lula_blog <- RefManageR::ReadBib(
  file = here::here("data", "Lula-MyPublication-Narrow.bib"),
  .Encoding ="UTF-8")  %>%   
  as.data.frame() %>% 
  dplyr::filter(bibtype  == "Online")



# *** ---------------------------------------------------------------------

##  [ENG] REFERENCE ----------------------------------------
references <- read_csv(here("data", "reference.csv"), show_col_types = FALSE) 

##  [ITA] REFERENCE ----------------------------------------
references_ita <- read_csv(here("data", "reference_ita.csv"), show_col_types = FALSE)




# [SKILLS/COMPTENCIES just in case]  ----------------------------------------------------

## --> Europrogettista / finanza agev  ---- 
# + EU programmes and funds advisor - Project manager - Foreign investment expert.
# + European Structural and Investment Funds Expert | Esperto in Fondi Strutturali e di Investimento Europei
# + valutazione aspetti economici e finanziari di progetti di investimento agevolabili ai sensi dei principali strumenti agevolativi nazionali e regionali
# + progettazione, gestione e rendicontazione di progetti regionali, nazionali e comunitari.
# + Conoscenza dei fondi comunitari (in particolare PNRR, FESR, FSE+, PON, POR)
# + Conoscenza dei mercati elettronici (MEPA)








