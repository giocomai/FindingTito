if (!require("pacman")) install.packages("pacman")
pacman::p_load("bookdown")
pacman::p_load("knitr")
pacman::p_load("tidyverse")
pacman::p_load("scales")
pacman::p_load("rvest")
# enables nice tables in rmarkdown output
#pacman::p_load("printr")
pacman::p_load("pander")
# maps
pacman::p_load("devtools")
# export to xlsx
pacman::p_load("openxlsx")

install_github(repo = "dgrtwo/gganimate")


devtools::install_github(repo = "dkahle/ggmap")
library("ggmap")
# the CRAN version is old and does not support Google API
#pacman::p_load("ggmap")
 
ExportData <- function(data, filename, xlsx = TRUE, showDataLink = TRUE) {
  if (file.exists("data")==FALSE) {
    dir.create("data")
  }
  saveRDS(object = data, file = file.path("data", paste0(filename, ".rds")))
  write.csv(x = data, file = file.path("data", paste0(filename, ".csv")), row.names = FALSE)
  if (xlsx == TRUE) {
    openxlsx::write.xlsx(x = data, file = file.path("data", paste0(filename, ".xlsx")))
  }
  if (showDataLink==TRUE) {
    if (xlsx == TRUE) {
    cat(paste0("\nThe data are available as a spreadsheet in [.csv]", paste0("(", file.path("data", paste0(filename, ".csv")), "), "), "[.xlsx]", paste0("(", file.path("data", paste0(filename, ".xlsx")), "), "), "and as a data frame in R's [.rds format]", paste0("(", file.path("data", paste0(filename, ".rds")), ").")))
    } else {
      cat(paste0("\nThe data are available as a spreadsheet in [.csv]", paste0("(", file.path("data", paste0(filename, ".csv")), "), "), "and as a data frame in R's [.rds format]", paste0("(", file.path("data", paste0(filename, ".rds")), ").")))
    }
  }
}

ShowTable <- function(data, caption = NULL) {
  data <- as.data.frame(data)
  if (is.null(caption)==TRUE) {
    pandoc.table(data)
  } else {
    pandoc.table(data, caption = caption)
  }
}

ImportData <- function(filename) {
  readRDS(file = file.path("data", paste0(filename, ".rds")))
}


ExportGraph <- function(graph = NULL, filename, width = 8, height = 4.944375773, showGraphLink = TRUE) {
  if (file.exists("graphs")==FALSE) {
    dir.create("graphs")
  }
  if (is.null(graph)==TRUE) {
    ggsave(filename = paste0(filename, ".png"), path = file.path("graphs"), width = width, height = height)
    ggsave(filename = paste0(filename, ".svg"), path = file.path("graphs"), width = width, height = height)
  } else {
    ggsave(filename = paste0(filename, ".png"), plot = graph, path = file.path("graphs"), width = width, height = height)
    ggsave(filename = paste0(filename, ".svg"), plot = graph, path = file.path("graphs"), width = width, height = height)
    saveRDS(object = graph, file = file.path("graphs", paste0(filename, ".rds")))
  }
  if (showGraphLink == TRUE) {
    cat(paste0("\nThis image is available for download in [.png]", paste0("(", file.path("graphs", paste0(filename, ".png")), "), ", "[.svg]", paste0("(", file.path("graphs", paste0(filename, ".svg")), "), ", "and as an object in R's [.rds format]", paste0("(", file.path("graphs", paste0(filename, ".rds")), ").")))))
  }
}


ImportGraph <- function(filename) {
  readRDS(file = file.path("graphs", paste0(filename, ".rds")))
}

# set countries
countries <- c("slovenia", "croatia", "bosnia-herzegovina", "serbia", "montenegro", "kosovo", "macedonia")

# set knitr options
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, message = FALSE, warning = FALSE, results="asis")
