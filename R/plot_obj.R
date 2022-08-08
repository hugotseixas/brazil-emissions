
source("R/fig_theme.R")

maps_plot <-
  function(data = plot_data, min_color, max_color) {
    
    plot <-
      hcmap(
        map = "countries/br/br-all", 
        download_map_data = TRUE,
        data = data,
        joinBy = "postal-code", 
        value = "emission"
      ) %>%
      hc_colorAxis(minColor = min_color, maxColor = max_color) %>%
      hc_tooltip(valueSuffix = "Mt") %>%
      hc_add_theme(a11y_theme)
    
  }

emissions_plot <-
  function(total = FALSE, color_list = vector(), group_id = "activity") {
    
    plot <-
      hchart(
        object = plot_data, 
        type = "column", 
        hcaes(x = year, y = emission, group = !!group_id)
      ) %>%
      hc_yAxis(title = list(text = "CO<sub>2</sub>-eq emissions (Mt)")) %>%
      hc_tooltip(valueSuffix = "Mt") %>%
      hc_add_theme(a11y_theme) %>%
      hc_colors(colors = as.vector(color_list))
    
  }
