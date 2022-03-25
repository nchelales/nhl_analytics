#importing libraries
library(fastRhockey)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggimage)
library(sportyR)

nhl_teams() %>% select('team_id','name') %>%
  head(10)

schedules <- load_nhl_schedule(2022) %>%
  filter(home_team_id == 8 | away_team_id == 8)
schedules %>%
  select(away_team_id,away_team_name,home_team_id, home_team_name,  game_date, away_score, home_score) %>%
  head()


pre_all <- vector("list", nrow(schedules)) #pre-allocated list

for (val in schedules$game_id) {
  pre_all[[which(val == schedules$game_id)]] <- nhl_game_feed(val)$all_plays %>%
    filter(result_event_type_id == "SHOT") #combining together all the plays
}

habs_game_feed <- do.call(rbind, pre_all)


habs_shot_data <- habs_game_feed %>% #filter to get shots on goal
  filter(result_event_type_id=="SHOT") %>%
  select(team_name, result_description, coordinates_x, coordinates_y, about_period)

habs_shot_data <- habs_shot_data %>% #put one team on each side of the rink 
  mutate(coordinates_x = if_else(team_name != 'Montréal Canadiens', -abs(coordinates_x), abs(coordinates_x))) %>%
  mutate(Shooter = if_else(team_name != 'Montréal Canadiens', 'Opponent', 'Canadiens'))

nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution",
       caption = "Data: @fastRhockey")

habs_shot_data_p1 <- habs_shot_data %>% #filter based upon period 
  filter(about_period == 1)
habs_shot_data_p2 <- habs_shot_data %>%
  filter(about_period == 2)
habs_shot_data_p3 <- habs_shot_data %>%
  filter(about_period == 3)

nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data_p1, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution Period 1",
       caption = "Data: @fastRhockey")
nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data_p2, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution Period 2",
       caption = "Data: @fastRhockey")
nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data_p3, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution Period 3",
       caption = "Data: @fastRhockey")
