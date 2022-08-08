
source("R/get_data.R")

seeg <- get_data()

br_emission_2020 <- seeg %>%
  filter(type %in% c("Emissão"), year == 2020) %>%
  summarise(emission = sum(emission, na.rm = TRUE), .groups = "drop") %>%
  mutate(emission = emission * 1e-9) %>%
  pull(emission)

maps_table <- 
  function(data = seeg, seeg_scope = character(), total = FALSE) {
    
    table <- 
      seeg %>% 
      filter(
        type == "Emissão", 
        year == 2020
      )
    
    if (total == FALSE) { table <- table %>% filter(scope == seeg_scope) }
    
    table <- 
      table  %>%
      group_by(state) %>%
      summarise(emission = sum(emission, na.rm = TRUE), .groups = "drop") %>%
      mutate(emission = emission * 1e-6) %>%
      rename(`postal-code` = state)
    
    return(table)
    
  }

emissions_table <-
  function(
    data = seeg,
    total = FALSE, 
    seeg_activity = FALSE, 
    seeg_scope = c(
      "Processos Industriais", "Energia", "Agropecuária",
      "Resíduos", "Mudança de Uso da Terra e Floresta"
    ), 
    type_list = c("Emissão")
  ) {
    
    table <- 
      data %>% 
      filter(
        type %in% type_list, 
        year >= 1990,
        scope %in% c(seeg_scope)
      ) %>%
      mutate(
        type = case_when(
          type == "Emissão" ~ "Emissions", 
          type == "Remoção" ~ "Removals",
          type == "Emissão NCI" ~ "Emissions NCI",
          type == "Remoção NCI" ~ "Removals NCI",
          type == "Bunker" ~ "Bunker"
        )
      )
    
    if (total == TRUE) { 
      
      table <- 
        table %>% 
        group_by(year, type)
      
    } else if (seeg_activity == FALSE) {
      
      table <- 
        table %>% 
        group_by(scope, year, type)
      
    } else {
      
      table <- 
        table %>% 
        group_by(activity, year, type)
      
    }
    
    table <- 
      table %>%
      summarise(emission = sum(emission, na.rm = TRUE), .groups = "drop") %>%
      mutate(emission = emission * 1e-6)
    
    return(table)
    
  }
