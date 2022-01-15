library(shiny)
library(tidyverse)
library(CodeClanData)
library(shinythemes)

publishers <- game_sales %>% 
  distinct(publisher) %>% 
  arrange(publisher) %>% 
  pull()

genres <- game_sales %>% 
  distinct(genre) %>% 
  arrange(genre) %>% 
  pull()

platforms <- game_sales %>% 
  distinct(platform) %>% 
  arrange(platform) %>% 
  pull()

ui <- fluidPage(
  
  theme = shinytheme("superhero"),
  
  titlePanel(h1("Games Data",
                style = "font-size:65px;")),
  
  br(),
  
  sidebarLayout(
    sidebarPanel(
        selectInput(
          inputId = "publisher",
          label = h3("Publisher"),
          choices = c("All", publishers)
        ),
        selectInput(
          inputId = "genre",
          label = h3("Genre"),
          choices = c("All", genres)
        ),
        selectInput(
          inputId = "platform",
          label = h3("Platform"),
          choices = c("All" ,platforms)
        ),
        align = "center",
        style = "font-size:17px;"
    ),
    
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel(
          "Ratings",
          
          titlePanel(h1("Average Game Ratings Over Time",
                        align = "center")),
          
          br(),
          
          column(
            width = 12,
            plotOutput("games_Plot")
          )
        ),
        tabPanel(
          "Top Games",
          
          titlePanel(h1("Top 10 Highest Rated Games",
                        align = "center")),
          
          tableOutput("games_table")
          
        )
      )
    )
  )
)


server <- function(input, output) {
  
  output$games_Plot <- renderPlot({
    if(input$publisher == "All" & input$genre == "All"){
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
    } else if(input$publisher == "All"){
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
    } else if(input$genre == "All"){
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
    } else {
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
    }
  })
  
  output$games_table <- renderTable({
    
    if(input$publisher == "All" & input$genre == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>%
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher)
    } else if(input$publisher == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(genre == input$genre) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher)
    } else if(input$genre == "All"){
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher)
    } else {
      game_sales %>% 
        mutate(total_score = critic_score + user_score) %>% 
        filter(publisher == input$publisher,
               genre == input$genre) %>% 
        slice_max(total_score, n = 10) %>% 
        select(name, genre, platform, publisher)
    }
  })
}


shinyApp(ui = ui, server = server)
