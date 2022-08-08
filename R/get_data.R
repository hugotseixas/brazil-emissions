
get_data <- 
  function() {
    
    url <- "https://seeg-br.s3.amazonaws.com/Estat%C3%ADsticas/SEEG9/1-SEEG9_GERAL-BR_UF_2021.10.26_-_SITE.xlsx"
    
    file_path <- here("seeg_states.csv")
    
    if (file_exists(file_path)) {
     
      seeg <- read_csv(file_path)
       
    } else {
      
      curl_download(url, file_path)
      
      seeg <- read_excel(file_path, sheet = 4)
      
      colnames(seeg) <-
        c(
          "level_1", "level_2", "level_3", "level_4", "level_5", "level_6",
          "type", "gas", "state", "activity", "product", 1970:2020
        )
      
      seeg <- seeg %>%
        pivot_longer(cols = 12:62, names_to = "year", values_to = "emission") %>%
        mutate(
          emission = as.numeric(str_remove_all(emission, ",")),
          year = as.numeric(year)
        ) %>%
        filter(gas == "CO2e (t) GWP-AR5") %>%
        select(-c(activity, product))
      
      seeg <- seeg %>%
        pivot_longer(cols = 2:6, names_to = "sublevel", values_to = "activity") %>%
        filter(
          level_1 == "Processos Industriais" & sublevel == "level_2" |
          level_1 == "Resíduos" & sublevel == "level_3" |
          level_1 == "Energia" & sublevel == "level_3" |
          level_1 == "Agropecuária" & type %in% c("Emissão", "Remoção") & sublevel == "level_2" |
          level_1 == "Agropecuária" & type %in% c("Emissão NCI", "Remoção NCI") & sublevel == "level_6" |
          level_1 == "Mudança de Uso da Terra e Floresta" & sublevel == "level_2"
        ) %>%
        rename(scope = level_1) %>%
        select(-c(gas, sublevel))
      
      write_csv(seeg, file_path)
      
    }
    
    return(seeg)
    
  }

