library(tidyverse)
library(readxl)


tmp_file <- tempfile() 

simd2020 <- "https://www.gov.scot/binaries/content/documents/govscot/publications/statistics/2020/01/scottish-index-of-multiple-deprivation-2020-ranks-and-domain-ranks/documents/simd_2020_ranks_and_domain_ranks/simd_2020_ranks_and_domain_ranks/govscot%3Adocument/SIMD_2020_Ranks_and_Domain_Ranks.xlsx"

utils::download.file(simd2020, tmp_file, mode = "wb") 

simd <- read_excel(tmp_file,
                   sheet = 2)

simd <- janitor::clean_names(simd)



simd %>% 
  ggplot(aes(x = simd2020_rank, y = simd2020_crime_domain_rank)) +
  geom_point(aes(size = total_population), alpha = 0.5, colour = "#009dc6") +
  scale_size_area(max_size = 4) +
  geom_smooth(method = "lm",
              se = FALSE,
              colour = "#c63b00") +
  facet_wrap(~ council_area)


simd %>% 
  ggplot(aes(x = simd2020_rank, y = simd2020_education_domain_rank)) +
  geom_point(aes(size = total_population), alpha = 0.5, colour = "#009dc6") +
  scale_size_area(max_size = 4) +
  geom_smooth(method = "lm",
              se = FALSE,
              colour = "#c63b00") +
  facet_wrap(~ council_area)

