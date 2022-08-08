
a11y_theme <- 
  hc_theme(
    chart = list(backgroundColor = "#ffffff"),
    tooltip = list(
      style = list(fontSize = "18px"),
      valueDecimals = 0,
      shared = TRUE
    ),
    plotOptions = list(
      map = list(
        dataLabels = list(
          enabled = TRUE, 
          format = "{point.postal-code}",
          style = list(fontSize = "16px")
        )
      ),
      series = list(stacking = "normal"), 
      column = list(pointWidth = 22)
    ),
    yAxis = list(
      endOnTick = FALSE, 
      title = list(
        useHTML = TRUE,
        style = list(fontSize = "18px", fontWeight = "bold")
      ),
      labels = list(style = list(fontSize = "18px"))
    ),
    xAxis = list(
      title = list(text = NULL), 
      labels = list(style = list(fontSize = "18px"))
    ),
    legend = list(
      itemStyle = list(fontSize = "16px")
    )
  )
