skip_on_ci()
load("infotest.rda")
instr_team <- Microsoft365R::get_team("Instructors")

test_that("People are identified as Instructors team members", {
  team_members <- get_people(infotest,
                             alert = c("Dani Bodor", "Mateusz Kuzak"),
                             instr_team)

  expect_true(is.list(team_members))
  expect_equal(length(team_members), 4) ## 2 teachers in infotest + 2 people in alert
  expect_true("ms_team_member" %in% class(team_members[[1]]))
})

test_that("When people cannot be identified, the program reports this.", {
  errorps <- "Person Notemployed"

  expect_warning(get_people(infotest,
                            alert = errorps,
                            instr_team),
                 regexp = "Cannot find team member Person Notemployed")

})

test_that("Some people who were not alerted in the past are identified correctly.",{

  team_members <- get_people(infotest,
                             alert = c("Heli Jarvenpaa",
                                       "Giulia Crocioni",
                                       "Laura Ootes",
                                       "Thijs van Lankeveld",
                                       "Pablo Rodríguez-Sánchez",
                                       "Carlos Murilo Rocha"),
                             instr_team)

  expect_true(is.list(team_members))
  expect_true("ms_team_member" %in% class(team_members[[1]]))
  expect_equal(length(team_members), 8) # 2 people in infotest + 6 names in alert

})


