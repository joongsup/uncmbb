library(dplyr)
library(readr)

names_to_fill <- c("Where", "Result")

add_column_name <- function(df){
  names(df)[4] <- names_to_fill[1]
  names(df)[7] <- names_to_fill[2]
  df
}

remove_mid_header <- function(df){
  df <- df %>% filter(G != "G")
  df
}

extract_ranking <- function(df){
  df$Opponent_Ranking <- parse_number(df$Opponent)
  df$Opponent_School <- gsub("\\s*\\([^\\)]+\\)", "", df[["Opponent"]])

  df
}

formate_date <- function(df){
  df$Game_Day <- substr(df$Date, 1, 3)
  df$Game_Date <- substr(df$Date, 6, length(df$Date))
  df$Game_Date <- mdy(df$Game_Date)

  df
}

fix_where <- function(df){
  df$Where <- ifelse(df$Where == "@", "A",
                     ifelse(df$Where == "", "H", "N"))
  df
  }

fill_emply <- function(df){
  df$OT <- ifelse(df$OT == "", NA, df$OT)
  df$Arena <- ifelse(df$Arena == "", NA, df$Arena)
  df$Conf <- ifelse(df$Conf == "", NA, df$Conf)

  df
}

fix_type <- function(df){
  df$G <- as.numeric(df$G)
  df$Tm <- as.numeric(df$Tm)
  df$Opp <- as.numeric(df$Opp)
  df$W <- as.numeric(df$W)
  df$L <- as.numeric(df$L)
  df$Opponent_Ranking <- as.numeric(df$Opponent_Ranking)

  df
}


