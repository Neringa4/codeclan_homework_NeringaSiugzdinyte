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
          
          br(),
          
          tableOutput("games_table")
          
        )
      )
    )
  )
)