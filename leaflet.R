library(htmlwidgets)
library(leaflet)

metadata_2024 <- metadata |>
  filter(year == 2024)

map_data <- ne_countries(scale = "medium", returnclass = "sf") |>
  left_join(metadata_2024, join_by(iso_a3_eh == iso3))

pal <- colorNumeric(palette = c("#e74c3c", "#ecf0f1"),
                    domain = c(0, 1),
                    na.color = "darkgray")

map_data |>
  leaflet() |>
  #addTiles() |>
  onRender("function(el, x) {el.style.backgroundColor = '#3498db';}") |>
  setView(lng = 0, lat = 25, zoom = 1) |>
  addPolygons(fillColor = ~pal(mcv2),
              fillOpacity = 1,
              color = "white",
              weight = 1,
              opacity = 1,
              label = ~paste0(name, ": ",
                              ifelse(is.na(mcv2), "No Data", percent(mcv2))))


# "#29c1a3"
# "#ecf0f1"
# "#3498db"
# "#f39c12"
# "#e74c3c"
# "#859394"
