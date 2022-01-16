server <- function(input, output) {
  
  output$games_Plot <- renderPlot({
    
    if(input$publisher == "All" & input$genre == "All" & input$platform == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$publisher == "All" & input$genre == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, platform, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(platform == input$platform) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$publisher == "All" & input$platform == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, genre, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(genre == input$genre) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$genre == "All" & input$platform == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, publisher, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(publisher == input$publisher) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$publisher == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, genre, platform, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(genre == input$genre,
               platform == input$platform) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$genre == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, publisher, platform, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(publisher == input$publisher,
               platform == input$platform) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else if(input$platform == "All"){
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, publisher, genre, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(publisher == input$publisher,
               genre == input$genre) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
      
    } else {
      game_sales %>%
        mutate(user_score = user_score*10) %>% 
        pivot_longer(critic_score:user_score, 
                     names_to = "score_type", 
                     values_to = "score") %>% 
        group_by(year_of_release, publisher, genre, platform, score_type) %>% 
        summarise(avg_score = mean(score)) %>%
        filter(publisher == input$publisher,
               genre == input$genre,
               platform == input$platform) %>% 
        
        ggplot(aes(x = year_of_release, y = avg_score, colour = score_type)) +
        geom_line(size = 1) +
        labs(x = "\nYear of Release",
             y = "Average Score\n",
             colour = "",
             title = "") +
        scale_colour_discrete(labels = c("Critic Rating", "User Rating")) +
        ylim(0, 100) +
        theme_light() +
        theme(text = element_text(size = 20))
    }
  })
  
  output$games_table <- renderTable({
    
    if(input$publisher == "All" & input$genre == "All" & input$platform == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title)
      
    } else if(input$publisher == "All" & input$genre == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(platform == input$platform) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title)
      
    } else if(input$publisher == "All" & input$platform == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(genre == input$genre) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title)
      
    } else if(input$genre == "All" & input$platform == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title) 
      
    } else if(input$publisher == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(genre == input$genre,
               platform == input$platform) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title)  
      
    } else if(input$genre == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher,
               platform == input$platform) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title)   
      
    } else if(input$platform == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher,
               genre == input$genre) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title) 
      
    } else {
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher,
               genre == input$genre,
               platform == input$platform) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher) %>% 
        rename_with(str_to_title) 
    }
  })
}