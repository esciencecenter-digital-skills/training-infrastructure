[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/esciencecenter-digital-skills/training-infrastructure/workflows/R-CMD-check/badge.svg)](https://github.com/esciencecenter-digital-skills/training-infrastructure/actions)

# Traininginfrastructure

## Description

Each of our workshops requires some documents to work with.
This package automates the generation of those documents.

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
library(training-infrastructure)
```

Step 1: Download the Holy Excel Sheet:
```
data <- read_from_drive(path = "General/Digital Skills Workshops 2023.xlsx")
```

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
- create a workshop-specific team in the Instructors Team
- create communication documents, a debriefing and a planning document and upload them to the folder
- create a data.csv file with workshop data necessary for the website, and upload this too

### Troubleshooting

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


## Want to contribute?
Please contact our maintainer [Lieke de Boer](https://github.com/liekelotte).
