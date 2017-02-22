pkglist <- c("readr", "dplyr", "shiny", "leaflet", "htmltools")
pkgsToInstall <- pkglist[!(pkglist %in% installed.packages()[,"Package"])]
if(length(pkgsToInstall)) install.packages(pkgsToInstall)

