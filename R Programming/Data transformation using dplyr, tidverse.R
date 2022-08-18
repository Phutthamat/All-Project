## dplyr
## install new package in RStudio
install.packages("dplyr")
library(dplyr)


##read csv file into R studio
imdb <- read.csv("imdb.csv", stringsAsFactors = FALSE)
View(imdb)

##review data structure
glimpse(imdb)


##print head and tail of data
head(imdb, 10)   
tail(imdb)       


##Select columns
select(imdb,MOVIE_NAME, RATING)
select(imdb, 1, 5)  ##column 1 and 5 

#change column name
select(imdb, movie_name = MOVIE_NAME, released_year = YEAR)

##pipe operator
##pipe imdb to function select and change column name
imdb %>% select(movie_name = MOVIE_NAME, released_year = YEAR)

imdb %>% 
  select(movie_name = MOVIE_NAME, released_year = YEAR) %>% head(10)
  
  
##filter data
imdb %>% filter(SCORE>=9.0)

names(imdb) <- tolower(names(imdb))

imdb %>%
  select(movie_name, year, score)  %>% filter(score >=9)

imdb %>%
  select(movie_name, year, score)  %>% filter(score >=9 & year > 2000)

imdb %>%
  select(movie_name, length, score) %>% filter (score == 8.8)

imdb %>%
  select(movie_name, length, score) %>% filter (score == 8.8 | score == 8.3 )

imdb %>%
  select(movie_name, length, score) %>% filter (score %in% c(8.3, 8.8, 9.0))
  
##Filter string columns
imdb %>%
  select(movie_name, genre, rating) %>%
  filter(rating == "R")

imdb %>%
  select(movie_name, genre, rating) %>%
  filter(rating == "PG-13")

imdb %>%      #find "Drama" in column movie_name
  select(movie_name, genre, rating) %>%
  filter(grepl("Drama", imdb$genre))

imdb %>%     ##find "the" in column movie_name
  select(movie_name) %>%
  filter(grepl("the", imdb$movie_name))

imdb %>%
  select(movie_name) %>%
  filter(grepl("King", imdb$movie_name))  
  
  
# Mutate new columns
## create new columns
imdb %>% 
  mutate(score_group = if_else(score >=9, "High Rating", "Low Rating"))

## create 2 column
imdb %>% 
  select(movie_name, score, length) %>%
  mutate(score_group = if_else(score >=9, "High Rating", "Low Rating"),
         length_group = ifelse(length >= 120, "Lomg Film", "Short Film"))

imdb %>% 
  select(movie_name, score) %>% mutate(score_update = score + 0.1) %>%  head(10)

imdb %>% 
  select(movie_name, score) %>% mutate(score = score + 0.1) %>%  head(10) 
  
  
## Arrange Data sort
## Arrange Data
imdb %>%   ## Sort by length
  arrange(length) %>% head(10)

imdb %>%   ## DESC order
  arrange(desc(length)) %>% head(10)

imdb %>%   ## Sort by rating
  arrange(rating, desc(length))
  
  
## Summary Statistics and group by
##summarise and group by
imdb %>%
  summarise(mean_length = mean (length))

imdb %>%
  summarise(mean_length = mean (length))

imdb %>%
  summarise(mean_length = mean (length))

imdb %>%
  summarise(mean_length = mean (length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length), 
            n = n())

imdb %>%
  filter(rating != "") %>%    ## not Blank
  group_by(rating) %>%        ## Sort By rating
  summarise(mean_length = mean (length),
            sum_length = sum(length),
            sd_length = sd(length),
            min_length = min(length),
            max_length = max(length), 
            n = n())
            
            
##Join Table
favorite_films <- data.frame(id= c(5, 10, 25, 30 , 98))

favorite_films %>%
  inner_join(imdb, by = c("id" = "no"))


## write csv file (export result)
imdb_prep <- imdb %>%
  select(movie_name, released_year = year, rating, length, score) %>%
  filter (rating =="R" & released_year > 2000)

write.csv(imdb_prep,"imdb_prep.csv", row.names = FALSE)




## tidyverse
## installtidyverse
install.packages("tidyverse",dependencies = TRUE) 

## load library
library(tidyverse)

## read data files 
friends <- read.csv("friends.csv")
df1 <- read_delim("text_file_01.txt", delim = ";")   
df2 <- read_delim("text_file_02.txt", delim = "\t") 


## tibble 
## enhanced dataframe
mtcars <- tibble(mtcars)
class(mtcars)


## select columns
select(mtcars, mpg, hp, wt)
select(mtcars, 1, 2, 4, 6)
select(mtcars, 1:3, 8:10)

select(mtcars, starts_with("h"))    ## start with h
select(mtcars, contains("a"))       ## contains a
select(mtcars, ends_with("p"))      ## end with p
select(mtcars, carb, am, everything())  ## move column carb and am to first column

## Change columns name
select(mtcars, horsePower = hp, 
							 milePerGallon = mpg,
					     weight = wt)

## filter rows with conditions
filter(mtcars, mpg < 20)
filter(mtcars, mpg < 20 & hp > 200 & am ==1)
filter(mtcars, mpg < 18 | am == 1)

##combine select + filter
head(mtcars)
mtcars %>% head() ##pipe

mtcars %>%
  select(mpg, hp, wt) %>%
  filter( mpg < 20, hp > 200) %>%
  mutate(double_hp = hp*2,
         log_hp = log(hp),
         exp_log_hp = exp(log_hp))

## arrange data
mtcars %>%
  select(mpg, hp, wt) %>%
  arrange(hp) %>%
  as.data.frame()    ## change tibble to dataframe

mtcars %>%
  select(mpg, hp, wt) %>%
  arrange(desc(hp))

## Change numeric to factor 
mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate(am = factor(am,
                     levels = c(0, 1), 
                     labels = c("Auto", "Manual"))) %>%
										 filter( am == "Auto")

mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate(am = factor(am,
                     levels = c(0, 1), 
                     labels = c("Auto", "Manual"))) %>%
  arrange(desc(am)) %>%
  as.data.frame()


mtcars %>%
  select(mpg, hp, wt, am) %>%
  mutate(am = factor(am,
                     levels = c(0, 1), 
                     labels = c("Auto", "Manual"))) %>%
  arrange(desc(am), wt) %>%
  as.data.frame()


## summarise
mtcars %>%
  summarise(avg_hp = mean(hp),
            sum_hp = sum (hp),
            sd_hp = sd (hp),
            n = n())


mtcars %>%
  mutate(am = factor(am, level=c(0,1),
                     labels=c("Auto", "Manual"))) %>%
  group_by(am) %>%      ## จัดกลุ่ม
  summarise(avg_hp = mean(hp),
            sum_hp = sum (hp),
            sd_hp = sd (hp),
            n = n())

mtcars %>%
  mutate(am = factor(am, level=c(0,1),
                     labels=c("Auto", "Manual"))) %>%
  group_by(am) %>%  ## using group by with summarise to find statistics
  summarise(avg_hp = mean(hp),
            sum_hp = sum (hp),
            sd_hp = sd (hp),
            n = n()) %>%
  ungroup() 


## diamonds package Tidyverse
## type ordinal 

diamonds %>%
  count(cut) %>%  
  mutate(percent = n / sum(n))


diamonds %>%
  count(cut, color) %>%
  mutate(percent = n / sum(n)) %>%
  as.data.frame() %>%
  arrange(desc(percent)) %>%
head()


## export data to csv file
write_csv(result,"Top_ten_diamonds.csv")


## add grand total
df3 <- diamonds %>%
  count(cut)

df4 <- data.frame(cut = "Total", n = length(diamonds$cut))
df3 %>% bind_rows(df4)
