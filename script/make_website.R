# copy combined_slides over to index.html

fs::file_copy(
  here::here("slides", "00-combined_slides.html"),
  here::here("docs", "index.html"),
  overwrite = TRUE
)

# and moving the figure files

fs::dir_copy(
  here::here("slides", "00-combined_slides_files"),
  here::here("docs", "00-combined_slides_files"),
  overwrite = TRUE
)
