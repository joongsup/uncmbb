#--------------------------------
# Adam Lucas: Rapid Reactions
#--------------------------------
library(rvest)
library(stringr)
# current year results (a data frame: b)
# url_main <- "http://goheels.com/news/2017/12/6/adam-lucas-lucas-rapid-reactions.aspx"

get_rr <- function(address){

  t <- address %>%
    read_html() %>%
    html_nodes(xpath = "//*[@id=\"main-content\"]/div[2]/article/div[2]/div/div/div") %>%
    html_text() %>%
    str_replace_all(pattern = "\n", replacement = " ") %>%
    str_replace_all(pattern = "\r", replacement = " ") %>%
    str_replace_all(pattern = "\t", replacement = " ") %>%
    str_replace_all(pattern = "\"", replacement = " ") %>%
    str_trim(side = "both")

  t
}

url_main <- "http://goheels.com/news"
dates_for_web <- c("2017/11/10", "2017/11/15", "2017/11/24", "2017/11/29", "2017/12/1", "2017/12/3", "2017/12/6", "2017/12/17")
rr_list <- vector("list", length = length(dates_for_web))

for (date in seq_along(dates_for_web)){
  print(date)
  url_head <- paste0(url_main, "/", dates_for_web[date], "/adam-lucas-lucas-rapid-reactions.aspx")
  print(url_head)
  tryCatch(
    rr_list[date] <- get_rr(url_head),
    error = function(e) NA
  )
}
rr_list <- setNames(rr_list, dates_for_web)

# for some posts, web addresses are different
dates_for_web2 <- c("2017/11/20", "2017/11/23", "2017/11/26")
rr_list2 <- vector("list", length = length(dates_for_web2))
for (date in seq_along(dates_for_web2)){
  print(date)
  url_head2 <- paste0(url_main, "/", dates_for_web2[date], "/mens-basketball-lucas-rapid-reactions.aspx")
  print(url_head)
  tryCatch(
    rr_list2[[date]] <- get_rr(url_head2),
    error = function(e) NA
  )
}
rr_list2 <- setNames(rr_list2, dates_for_web2)

rr_list_all <- c(rr_list, rr_list2)
df_rr_list <- data_frame(gamedate = names(rr_list_all), rr = unlist(rr_list_all))
saveRDS(df_rr_list, file = "/Users/jl939a/projects/blog/backup/rapid_reactions_as_of_20181219.RDS")

library(tidytext)
#d <- data_frame(rr_list_all)
d1 <- df_rr_list %>% unnest_tokens(word, rr)
d2 <- df_rr_list %>% unnest_tokens(word2, rr, token = "ngrams", n = 2)

data(stop_words)
custom_stops <- tibble(word = c("adam", "lucas", "by", "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december", "2017", "tar", "heels", "heel", "carolina"), lexicon = "custom")
stop_words <- rbind(stop_words, custom_stops)

t1 <- d1 %>% filter(!word %in% stop_words$word) %>%
  count(word, sort = TRUE)

t2 <- d2 %>% separate(word2, c("w1", "w2"), sep = " ") %>%
  filter(!w1 %in% stop_words$word, !w2 %in% stop_words$word) %>%
  unite(word2, w1, w2, sep = " ") %>%
  count(word2, sort = TRUE)
