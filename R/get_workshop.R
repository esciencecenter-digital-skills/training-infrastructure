get_workshop <- function(df, slug){
  df <- df[!is.na(df$slug),] # in case there are NAs left in the df
  selected_ws <- df[df$slug==slug,]
  return(selected_ws)
}
