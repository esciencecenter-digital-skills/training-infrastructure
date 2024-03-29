% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_sharepoint_folder.R
\name{create_sharepoint_folder}
\alias{create_sharepoint_folder}
\title{Create Sharepoint site}
\usage{
create_sharepoint_folder(info, drive = "instructors")
}
\arguments{
\item{info}{information about the workshop taken from the holy excel sheet}

\item{drive}{the name of the Sharepoint drive where the folder will be created}
}
\description{
Takes information about the workshop. Checks if a sharepoint folder for a workshop slug already exists.
Creates a folder if it does not exist yet. Throws an error if sharepoint folders cannot be retrieved.
(within the current workflow, this will most likely be from the "Instructors" Sharepoint page)
}
