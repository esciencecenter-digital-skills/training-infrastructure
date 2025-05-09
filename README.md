[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/esciencecenter-digital-skills/training-infrastructure/workflows/R-CMD-check/badge.svg)](https://github.com/esciencecenter-digital-skills/training-infrastructure/actions)

# Traininginfrastructure

## Description

Automates generation of the workshop folder, with in it the planning document, communication document, debriefing document, and `data.csv` as well as generation of the workshop channel in Teams and automatic adding of instructors to it. 

This needs: 

    That year’s holy excel sheet 

    Workshop metadata 

    Template docs coordination 

## Use

### Installation
This package depends on the R language. Install it [via CRAN](https://cran.r-project.org/).

We recommend using the package with RStudio. Install it [via posit](https://posit.co/downloads/).

Inside RStudio, install this package as follows:
```
install.packages("devtools")
devtools::install_github("esciencecenter-digital-skills/training-infrastructure")
```

### Usage

Step 0: load the package
```
library(traininginfrastructure)
```

Step 1: Download the Holy Excel Sheet:
```
data <- read_from_drive(year = "2023")
```
In case this fails: the path to the actual file is hardcoded in
`inst/extdata/rawinfo.csv`. If the Holy Excel file cannot be found
in the location indicate there, this file should be updated.


Step 2: Select future workshops:
```
data <- get_future_workshops(data)
```

Step 3: Activate a workshop:
```
workshop_activate(data)
```
This function is interactive; it will give you a number of workshops to choose
from, and you can activate workshops one at a time by entering their number.
For instance:

```
> workshop_activate(data)
The following workshops are ready to go:
1: 2022-12-12 Good Practices in Research Software Development (Code Refinery) (lead: Barbara Vreede ) Netherlands eScience Center
2: 2022-12-29 Test Workshop (do not remove please) (lead: Barbara Vreede ) Netherlands eScience Center (in person, Amsterdam)
Which workshop do you want to activate? (one at a time...)
```
You can now enter 1 or 2, based on the workshop you want to activate.

The package will now:
- create a folder in the Instructors sharepoint drive
- create a workshop-specific channel in the Instructors Teams channel
- create communication documents, a debriefing and a planning document and upload them to the folder
- create a data.csv file with workshop data necessary for the website, and upload this too
- write a post in the newly created channel that alerts all helpers and instructors (and Fenne).

In case you want to alert anyone other than Fenne, use their Microsoft name specifically:

```
workshop_activate(data, alert="Lieke de Boer")
```

Note that doing this **removes the alert for the current default**, meaning that the workshop coordinator (Fenne) will no longer be alerted. If you want to alert someone in addition to Fenne, use both their names:
```
workshop_activate(data, alert=c("Lieke de Boer","Fenne Riemslagh"))
```


### Troubleshooting

#### Something went wrong! Ack!
It is good to know that you can repeat the `workshop_activate()` workflow (step 3)
as often as necessary. Once a channel exists it will not be recreated, and existing
files will not be overwritten.

That does mean that if there is a problem with a file, you will need to manually
remove it from the sharepoint drive if you want to recreate it with the package.

The exception to this is the final step: every time you run the workflow to activate
a workshop, a post will be made in the sharepoint channel. It does mention that
it is automatically created, so hopefully your colleagues won't be too upset with you.


#### Microsoft365
The package depends heavily on Microsoft 365 infrastructure. You must be logged
in to Office Online with an eScience Center account for it to work. When
encountering any issues, first always check your login.

You can also check your accessibility to the environment by calling, e.g.:
```
Microsoft365R::get_team("Instructors")
```

This should give you the following return:
```
<Team 'Instructors'>
  directory id: 024316da-7d77-4ea3-8783-9826a961135a 
  web link: https://teams.microsoft.com/l/team/19%3a0e34ef49d7c24e7a8f5f250c003aabdc%40thread.tacv2/conversations?groupId=024316da-7d77-4ea3-8783-9826a961135a&tenantId=aa3aeacc-6307-42b2-ac05-787dd5c32574 
  description: This is the group for eScience Center employees who teach at the eScience Academy workshops. We expect all the trainers to follow this group email closely. The training coordination topics are not discussed in this group. To follow coordination topics join the `training` group 
---
  Methods:
    create_channel, delete, delete_channel, do_operation, get_channel,
    get_drive, get_group, get_list_pager, get_member, get_sharepoint_site,
    list_channels, list_drives, list_members, sync_fields, update
```

Unfortunately, Microsoft365R can be buggy, and may not authenticate well or otherwise
deny you access. It can help to uninstall the package, and reinstall it again:

```
remove.packages("Microsoft365R")
install.packages("Microsoft365R")
```

## Want to contribute?
Please contact our maintainer [Lieke de Boer](https://github.com/liekelotte).
