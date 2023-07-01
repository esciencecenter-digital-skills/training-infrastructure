#' Choose workshops and activate them
#'
#' @param df data frame with future workshops (use `get_future_workshops()`)
#' @param alert name of the training coordinator who should be alerted automatically in every created channel.
#' the default `alert = "default"` alerts the person who is named as coordinator in `save_post_sharepoint()`.
#'
#' @export
workshop_activate <- function(df, alert="default"){
  if(!verify_post_gfw(df)){
    message("The dataset is incomplete. Please use `get_future_workshops()` first next time!")
    message("Applying `get_future_workshops()` to fix data...")
    df <- get_future_workshops(df)
  }

  df <- df[!is.na(df$slug),]

  if(!"ready" %in% names(df)){
    stop("The data does not contain a column 'ready'.
This is necessary to select workshops that can be prepared.
Please check the name of the columns in the Holy Excel Sheet.")
  }

  df <- df[df$ready == "yes",]
  if(nrow(df) < 1){
    stop("There are currently no workshops ready for activation.
You can mark them in the Holy Excel Sheet by entering 'yes' in the column 'ready'.")
  }

  df <- dplyr::mutate(df,
                        summary = paste(
                          startdate, title, "(lead:", lead_instructor,")", venue
                          ))

  message("The following workshops are ready to go:")
  for(i in 1:nrow(df)){
    state <- paste0(as.character(i), ": ", df$summary[i])
    message(state)
  }

  activews <- readline(
    prompt = "Which workshop do you want to activate? (one at a time...) ")
  activews <- as.numeric(activews)

  if(is.na(activews) | activews < 1 | activews > nrow(df)){
    stop("Invalid input.
Please enter a single number corresponding to the workshop you wish to activate.")
  }

  activews <- df[activews,]

  message(paste0("We are activating ", activews$slug, ". Please stand by!"))

  # make sharepoint
  message("Making sharepoint folder...")
  create_sharepoint_folder(info = activews)

  # make teams channel and post to members
  message("Making Teams channel...")
  create_ws_channel(info = activews)

  message("Alerting team members to the new channel...")
  if(alert == "default"){
    save_post_sharepoint(info = activews)
  }
  else{
    save_post_sharepoint(info = activews, alert = alert)
  }

  # create documents
  message("Creating documents...")
  tempname <- (paste0("tempdir_", activews$slug))
  dir.create(tempname)
  create_files(info = activews, folder = tempname)

  # upload documents
  message("Uploading documents...")
  upload_docs(info = activews, folder = tempname)

  unlink(tempname, recursive=T)
}


