---
title: "Introduction to fastRhockey"
output: 
  html_document:
    keep_md: true
---


```r
#importing libraries
library(fastRhockey)
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.7
## ✓ tidyr   1.2.0     ✓ stringr 1.4.0
## ✓ readr   2.1.2     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(dplyr)
library(ggplot2)
library(ggimage)
library(sportyR)
```

Let's use the fastRhockey library to first load play by play data from a particular team. Here we will choose the Montreal Canadiens. First we will get the list of game IDs for the Canadiens, and then use those game IDs to pull all the play by play data. First, lets find out what the team ID is for the Montreal Canadiens. 


```r
nhl_teams()
```

```
##    team_id                  name             link abbreviation      team_name
## 1        1     New Jersey Devils  /api/v1/teams/1          NJD         Devils
## 2        2    New York Islanders  /api/v1/teams/2          NYI      Islanders
## 3        3      New York Rangers  /api/v1/teams/3          NYR        Rangers
## 4        4   Philadelphia Flyers  /api/v1/teams/4          PHI         Flyers
## 5        5   Pittsburgh Penguins  /api/v1/teams/5          PIT       Penguins
## 6        6         Boston Bruins  /api/v1/teams/6          BOS         Bruins
## 7        7        Buffalo Sabres  /api/v1/teams/7          BUF         Sabres
## 8        8    Montréal Canadiens  /api/v1/teams/8          MTL      Canadiens
## 9        9       Ottawa Senators  /api/v1/teams/9          OTT       Senators
## 10      10   Toronto Maple Leafs /api/v1/teams/10          TOR    Maple Leafs
## 11      12   Carolina Hurricanes /api/v1/teams/12          CAR     Hurricanes
## 12      13      Florida Panthers /api/v1/teams/13          FLA       Panthers
## 13      14   Tampa Bay Lightning /api/v1/teams/14          TBL      Lightning
## 14      15   Washington Capitals /api/v1/teams/15          WSH       Capitals
## 15      16    Chicago Blackhawks /api/v1/teams/16          CHI     Blackhawks
## 16      17     Detroit Red Wings /api/v1/teams/17          DET      Red Wings
## 17      18   Nashville Predators /api/v1/teams/18          NSH      Predators
## 18      19       St. Louis Blues /api/v1/teams/19          STL          Blues
## 19      20        Calgary Flames /api/v1/teams/20          CGY         Flames
## 20      21    Colorado Avalanche /api/v1/teams/21          COL      Avalanche
## 21      22       Edmonton Oilers /api/v1/teams/22          EDM         Oilers
## 22      23     Vancouver Canucks /api/v1/teams/23          VAN        Canucks
## 23      24         Anaheim Ducks /api/v1/teams/24          ANA          Ducks
## 24      25          Dallas Stars /api/v1/teams/25          DAL          Stars
## 25      26     Los Angeles Kings /api/v1/teams/26          LAK          Kings
## 26      28       San Jose Sharks /api/v1/teams/28          SJS         Sharks
## 27      29 Columbus Blue Jackets /api/v1/teams/29          CBJ   Blue Jackets
## 28      30        Minnesota Wild /api/v1/teams/30          MIN           Wild
## 29      52         Winnipeg Jets /api/v1/teams/52          WPG           Jets
## 30      53       Arizona Coyotes /api/v1/teams/53          ARI        Coyotes
## 31      54  Vegas Golden Knights /api/v1/teams/54          VGK Golden Knights
## 32      55        Seattle Kraken /api/v1/teams/55          SEA         Kraken
##    location_name first_year_of_play   short_name
## 1     New Jersey               1982   New Jersey
## 2       New York               1972 NY Islanders
## 3       New York               1926   NY Rangers
## 4   Philadelphia               1967 Philadelphia
## 5     Pittsburgh               1967   Pittsburgh
## 6         Boston               1924       Boston
## 7        Buffalo               1970      Buffalo
## 8       Montréal               1909     Montréal
## 9         Ottawa               1990       Ottawa
## 10       Toronto               1917      Toronto
## 11      Carolina               1979     Carolina
## 12       Florida               1993      Florida
## 13     Tampa Bay               1991    Tampa Bay
## 14    Washington               1974   Washington
## 15       Chicago               1926      Chicago
## 16       Detroit               1926      Detroit
## 17     Nashville               1997    Nashville
## 18     St. Louis               1967     St Louis
## 19       Calgary               1980      Calgary
## 20      Colorado               1979     Colorado
## 21      Edmonton               1979     Edmonton
## 22     Vancouver               1970    Vancouver
## 23       Anaheim               1993      Anaheim
## 24        Dallas               1967       Dallas
## 25   Los Angeles               1967  Los Angeles
## 26      San Jose               1990     San Jose
## 27      Columbus               1997     Columbus
## 28     Minnesota               1997    Minnesota
## 29      Winnipeg               2011     Winnipeg
## 30       Arizona               1979      Arizona
## 31         Vegas               2016        Vegas
## 32       Seattle               2021      Seattle
##                     official_site_url franchise_id active
## 1     http://www.newjerseydevils.com/           23   TRUE
## 2    http://www.newyorkislanders.com/           22   TRUE
## 3      http://www.newyorkrangers.com/           10   TRUE
## 4  http://www.philadelphiaflyers.com/           16   TRUE
## 5      http://pittsburghpenguins.com/           17   TRUE
## 6        http://www.bostonbruins.com/            6   TRUE
## 7              http://www.sabres.com/           19   TRUE
## 8           http://www.canadiens.com/            1   TRUE
## 9      http://www.ottawasenators.com/           30   TRUE
## 10         http://www.mapleleafs.com/            5   TRUE
## 11 http://www.carolinahurricanes.com/           26   TRUE
## 12    http://www.floridapanthers.com/           33   TRUE
## 13  http://www.tampabaylightning.com/           31   TRUE
## 14 http://www.washingtoncapitals.com/           24   TRUE
## 15  http://www.chicagoblackhawks.com/           11   TRUE
## 16    http://www.detroitredwings.com/           12   TRUE
## 17 http://www.nashvillepredators.com/           34   TRUE
## 18       http://www.stlouisblues.com/           18   TRUE
## 19      http://www.calgaryflames.com/           21   TRUE
## 20  http://www.coloradoavalanche.com/           27   TRUE
## 21     http://www.edmontonoilers.com/           25   TRUE
## 22            http://www.canucks.com/           20   TRUE
## 23       http://www.anaheimducks.com/           32   TRUE
## 24        http://www.dallasstars.com/           15   TRUE
## 25            http://www.lakings.com/           14   TRUE
## 26           http://www.sjsharks.com/           29   TRUE
## 27        http://www.bluejackets.com/           36   TRUE
## 28               http://www.wild.com/           37   TRUE
## 29           http://winnipegjets.com/           35   TRUE
## 30     http://www.arizonacoyotes.com/           28   TRUE
## 31 http://www.vegasgoldenknights.com/           38   TRUE
## 32        https://www.nhl.com/seattle           39   TRUE
##                  venue_name          venue_link   venue_city venue_id
## 1         Prudential Center /api/v1/venues/null       Newark       NA
## 2                 UBS Arena /api/v1/venues/null       Elmont       NA
## 3     Madison Square Garden /api/v1/venues/5054     New York     5054
## 4        Wells Fargo Center /api/v1/venues/5096 Philadelphia     5096
## 5          PPG Paints Arena /api/v1/venues/5034   Pittsburgh     5034
## 6                 TD Garden /api/v1/venues/5085       Boston     5085
## 7            KeyBank Center /api/v1/venues/5039      Buffalo     5039
## 8               Bell Centre /api/v1/venues/5028     Montréal     5028
## 9      Canadian Tire Centre /api/v1/venues/5031       Ottawa     5031
## 10         Scotiabank Arena /api/v1/venues/null      Toronto       NA
## 11                PNC Arena /api/v1/venues/5066      Raleigh     5066
## 12           FLA Live Arena /api/v1/venues/5027      Sunrise     5027
## 13             AMALIE Arena /api/v1/venues/null        Tampa       NA
## 14        Capital One Arena /api/v1/venues/5094   Washington     5094
## 15            United Center /api/v1/venues/5092      Chicago     5092
## 16     Little Caesars Arena /api/v1/venues/5145      Detroit     5145
## 17        Bridgestone Arena /api/v1/venues/5030    Nashville     5030
## 18        Enterprise Center /api/v1/venues/5076    St. Louis     5076
## 19    Scotiabank Saddledome /api/v1/venues/5075      Calgary     5075
## 20               Ball Arena /api/v1/venues/5064       Denver     5064
## 21             Rogers Place /api/v1/venues/5100     Edmonton     5100
## 22             Rogers Arena /api/v1/venues/5073    Vancouver     5073
## 23             Honda Center /api/v1/venues/5046      Anaheim     5046
## 24 American Airlines Center /api/v1/venues/5019       Dallas     5019
## 25         Crypto.com Arena /api/v1/venues/null  Los Angeles       NA
## 26   SAP Center at San Jose /api/v1/venues/null     San Jose       NA
## 27         Nationwide Arena /api/v1/venues/5059     Columbus     5059
## 28       Xcel Energy Center /api/v1/venues/5098     St. Paul     5098
## 29       Canada Life Centre /api/v1/venues/5058     Winnipeg     5058
## 30         Gila River Arena /api/v1/venues/5043     Glendale     5043
## 31           T-Mobile Arena /api/v1/venues/5178    Las Vegas     5178
## 32     Climate Pledge Arena /api/v1/venues/null      Seattle       NA
##     venue_time_zone_id venue_time_zone_offset venue_time_zone_tz division_id
## 1     America/New_York                     -5                EST          18
## 2     America/New_York                     -5                EST          18
## 3     America/New_York                     -5                EST          18
## 4     America/New_York                     -5                EST          18
## 5     America/New_York                     -5                EST          18
## 6     America/New_York                     -5                EST          17
## 7     America/New_York                     -5                EST          17
## 8     America/Montreal                     -5                EST          17
## 9     America/New_York                     -5                EST          17
## 10     America/Toronto                     -5                EST          17
## 11    America/New_York                     -5                EST          18
## 12    America/New_York                     -5                EST          17
## 13    America/New_York                     -5                EST          17
## 14    America/New_York                     -5                EST          18
## 15     America/Chicago                     -6                CST          16
## 16     America/Detroit                     -5                EST          17
## 17     America/Chicago                     -6                CST          16
## 18     America/Chicago                     -6                CST          16
## 19      America/Denver                     -7                MST          15
## 20      America/Denver                     -7                MST          16
## 21    America/Edmonton                     -7                MST          15
## 22   America/Vancouver                     -8                PST          15
## 23 America/Los_Angeles                     -8                PST          15
## 24     America/Chicago                     -6                CST          16
## 25 America/Los_Angeles                     -8                PST          15
## 26 America/Los_Angeles                     -8                PST          15
## 27    America/New_York                     -5                EST          18
## 28     America/Chicago                     -6                CST          16
## 29    America/Winnipeg                     -6                CST          16
## 30     America/Phoenix                     -7                MST          16
## 31 America/Los_Angeles                     -8                PST          15
## 32 America/Los_Angeles                     -8                PST          15
##    division_name division_name_short        division_link division_abbreviation
## 1   Metropolitan               Metro /api/v1/divisions/18                     M
## 2   Metropolitan               Metro /api/v1/divisions/18                     M
## 3   Metropolitan               Metro /api/v1/divisions/18                     M
## 4   Metropolitan               Metro /api/v1/divisions/18                     M
## 5   Metropolitan               Metro /api/v1/divisions/18                     M
## 6       Atlantic                 ATL /api/v1/divisions/17                     A
## 7       Atlantic                 ATL /api/v1/divisions/17                     A
## 8       Atlantic                 ATL /api/v1/divisions/17                     A
## 9       Atlantic                 ATL /api/v1/divisions/17                     A
## 10      Atlantic                 ATL /api/v1/divisions/17                     A
## 11  Metropolitan               Metro /api/v1/divisions/18                     M
## 12      Atlantic                 ATL /api/v1/divisions/17                     A
## 13      Atlantic                 ATL /api/v1/divisions/17                     A
## 14  Metropolitan               Metro /api/v1/divisions/18                     M
## 15       Central                 CEN /api/v1/divisions/16                     C
## 16      Atlantic                 ATL /api/v1/divisions/17                     A
## 17       Central                 CEN /api/v1/divisions/16                     C
## 18       Central                 CEN /api/v1/divisions/16                     C
## 19       Pacific                 PAC /api/v1/divisions/15                     P
## 20       Central                 CEN /api/v1/divisions/16                     C
## 21       Pacific                 PAC /api/v1/divisions/15                     P
## 22       Pacific                 PAC /api/v1/divisions/15                     P
## 23       Pacific                 PAC /api/v1/divisions/15                     P
## 24       Central                 CEN /api/v1/divisions/16                     C
## 25       Pacific                 PAC /api/v1/divisions/15                     P
## 26       Pacific                 PAC /api/v1/divisions/15                     P
## 27  Metropolitan               Metro /api/v1/divisions/18                     M
## 28       Central                 CEN /api/v1/divisions/16                     C
## 29       Central                 CEN /api/v1/divisions/16                     C
## 30       Central                 CEN /api/v1/divisions/16                     C
## 31       Pacific                 PAC /api/v1/divisions/15                     P
## 32       Pacific                 PAC /api/v1/divisions/15                     P
##    conference_id conference_name       conference_link franchise_franchise_id
## 1              6         Eastern /api/v1/conferences/6                     23
## 2              6         Eastern /api/v1/conferences/6                     22
## 3              6         Eastern /api/v1/conferences/6                     10
## 4              6         Eastern /api/v1/conferences/6                     16
## 5              6         Eastern /api/v1/conferences/6                     17
## 6              6         Eastern /api/v1/conferences/6                      6
## 7              6         Eastern /api/v1/conferences/6                     19
## 8              6         Eastern /api/v1/conferences/6                      1
## 9              6         Eastern /api/v1/conferences/6                     30
## 10             6         Eastern /api/v1/conferences/6                      5
## 11             6         Eastern /api/v1/conferences/6                     26
## 12             6         Eastern /api/v1/conferences/6                     33
## 13             6         Eastern /api/v1/conferences/6                     31
## 14             6         Eastern /api/v1/conferences/6                     24
## 15             5         Western /api/v1/conferences/5                     11
## 16             6         Eastern /api/v1/conferences/6                     12
## 17             5         Western /api/v1/conferences/5                     34
## 18             5         Western /api/v1/conferences/5                     18
## 19             5         Western /api/v1/conferences/5                     21
## 20             5         Western /api/v1/conferences/5                     27
## 21             5         Western /api/v1/conferences/5                     25
## 22             5         Western /api/v1/conferences/5                     20
## 23             5         Western /api/v1/conferences/5                     32
## 24             5         Western /api/v1/conferences/5                     15
## 25             5         Western /api/v1/conferences/5                     14
## 26             5         Western /api/v1/conferences/5                     29
## 27             6         Eastern /api/v1/conferences/6                     36
## 28             5         Western /api/v1/conferences/5                     37
## 29             5         Western /api/v1/conferences/5                     35
## 30             5         Western /api/v1/conferences/5                     28
## 31             5         Western /api/v1/conferences/5                     38
## 32             5         Western /api/v1/conferences/5                     39
##    franchise_team_name        franchise_link
## 1               Devils /api/v1/franchises/23
## 2            Islanders /api/v1/franchises/22
## 3              Rangers /api/v1/franchises/10
## 4               Flyers /api/v1/franchises/16
## 5             Penguins /api/v1/franchises/17
## 6               Bruins  /api/v1/franchises/6
## 7               Sabres /api/v1/franchises/19
## 8            Canadiens  /api/v1/franchises/1
## 9             Senators /api/v1/franchises/30
## 10         Maple Leafs  /api/v1/franchises/5
## 11          Hurricanes /api/v1/franchises/26
## 12            Panthers /api/v1/franchises/33
## 13           Lightning /api/v1/franchises/31
## 14            Capitals /api/v1/franchises/24
## 15          Blackhawks /api/v1/franchises/11
## 16           Red Wings /api/v1/franchises/12
## 17           Predators /api/v1/franchises/34
## 18               Blues /api/v1/franchises/18
## 19              Flames /api/v1/franchises/21
## 20           Avalanche /api/v1/franchises/27
## 21              Oilers /api/v1/franchises/25
## 22             Canucks /api/v1/franchises/20
## 23               Ducks /api/v1/franchises/32
## 24               Stars /api/v1/franchises/15
## 25               Kings /api/v1/franchises/14
## 26              Sharks /api/v1/franchises/29
## 27        Blue Jackets /api/v1/franchises/36
## 28                Wild /api/v1/franchises/37
## 29                Jets /api/v1/franchises/35
## 30             Coyotes /api/v1/franchises/28
## 31      Golden Knights /api/v1/franchises/38
## 32              Kraken /api/v1/franchises/39
```
As you can see, the team ID for the Montreal Canadiens is 8. The function nhl_teams() also tells us other useful information like the location and venue ID.


```r
schedules <- load_nhl_schedule(2022) %>%
  filter(home_team_id == 8 | away_team_id == 8)
schedules %>%
  select(away_team_id,away_team_name,home_team_id, home_team_name,  game_date, away_score, home_score) %>%
  head()
```

```
## # A tibble: 6 × 7
##   away_team_id away_team_name  home_team_id home_team_name game_date  away_score
##          <int> <chr>                  <int> <chr>          <date>          <int>
## 1           29 Columbus Blue …            8 MontrÃ©al Can… 2022-02-12          2
## 2           15 Washington Cap…            8 MontrÃ©al Can… 2022-02-11          5
## 3            1 New Jersey Dev…            8 MontrÃ©al Can… 2022-02-09          7
## 4           29 Columbus Blue …            8 MontrÃ©al Can… 2022-01-31          6
## 5           22 Edmonton Oilers            8 MontrÃ©al Can… 2022-01-30          7
## 6           24 Anaheim Ducks              8 MontrÃ©al Can… 2022-01-28          5
## # … with 1 more variable: home_score <int>
```
The above cell loads in the schedule data for the given season, filters to select only games in which either the home or away team is the Montreal Canadiens. Then we can preview the data that we have just filtered out using the head() command. The select function allows us to choose which variables we want to view in our preview. As you can see the most recent game the Canadiens played was against the Columbus Blue Jackets, one in which they lost 6-3. 

You might check this with the official NHL website or another sports page and see that the date is listed as January 30th, and not January 31st as listed above. This is likely because the stats update overnight, so the api records the date as the when the stats are updated. The exact date of the game is usually of little importance, but if you need to change this you could simply update it using the mutate() function. 

Now lets use the schedule data to pull some relevant data and do something interesting. 


```r
habs_game_feed <- nhl_game_feed(schedules$game_id[1])$all_plays #get the first game data

for (val in schedules$game_id[2:nrow(schedules)]) {
  habs_game_feed <- rbind(habs_game_feed, nhl_game_feed(val)$all_plays) #combine each dataframe together into one large data frame, with all the games
}
```
The first chunk of code takes the schedule data to identify the Canadiens game and uses it to build a dataframe of all the Habs 2021-2022 plays. The code uses a loop, which lacks elegance, but it gets the job done with the current library we are working with. 


```r
habs_shot_data <- habs_game_feed %>% #filter to get shots on goal
  filter(result_event_type_id=="SHOT") %>%
  select(team_name, result_description, coordinates_x, coordinates_y, about_period)

habs_shot_data <- habs_shot_data %>% #put one team on each side of the rink 
  mutate(coordinates_x = if_else(team_name != 'Montréal Canadiens', -abs(coordinates_x), abs(coordinates_x))) %>%
  mutate(Shooter = if_else(team_name != 'Montréal Canadiens', 'Opponent', 'Canadiens'))
```

The above code filters the data to select all plays involving a shot on goal, and adding a value to determine if they shot was a Canadiens shot or a shot from a Canadiens opponent. 


```r
nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution",
       caption = "Data: @fastRhockey")
```

![](Intro_fastRHockey_files/figure-html/unnamed-chunk-6-1.png)<!-- -->

Unsurprisingly, both the Canadiens and their opponents have their shots concentrated  close to the goal and spreading out in an outward V shape pattern, as good defense typically aims to clog up the middle and force the opponent to the edges of the rink. Now, lets see how or if this pattern changes as a function of time throughout the game. We can utilize our work from earlier and filter based on period.


```r
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
```

![](Intro_fastRHockey_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

```r
nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data_p2, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution Period 2",
       caption = "Data: @fastRhockey")
```

![](Intro_fastRHockey_files/figure-html/unnamed-chunk-7-2.png)<!-- -->

```r
nhl_rink = geom_hockey('nhl',
                       boards_color= '#13294b') #create the NHL rink
nhl_rink +
  geom_point(data = habs_shot_data_p3, aes(coordinates_x, coordinates_y, color = Shooter)) +
  scale_color_manual(values = c("Opponent" = '#87ceeb','Canadiens' = '#AF1E2D')) +
  #titles and caption
  labs(title = "Canadiens For and Against Shot Distribution Period 3",
       caption = "Data: @fastRhockey")
```

![](Intro_fastRHockey_files/figure-html/unnamed-chunk-7-3.png)<!-- -->

As expected, the pattern holds, as its unlikely strategy on shot location changes very much from period to period. That's it for this tutorial on how to load and explore data using fastRhockey. 

