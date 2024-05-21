m2_files <- fs::dir_ls("data-raw", regexp = "M2_.*csv")
m2 <- purrr::map_df(
  m2_files,
  .f = \(x) {
    read.csv(x) |>
      dplyr::rename_with(
        .fn = \(y) dplyr::case_when(y == "numbers" ~ "M2", TRUE ~ y)
      )
  },
  .id = "name"
) |>
  dplyr::rename_with(.fn = tolower) |>
  dplyr::mutate(name = gsub("M2_|\\.csv", "", basename(name)))

usethis::use_data(m2)
rm(m2)
