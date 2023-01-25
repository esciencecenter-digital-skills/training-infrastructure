skip_on_ci()
load("infotest.rda")
instr_team <- Microsoft365R::get_team("Instructors")

test_that("People are identified as Instructors team members", {
  team_members <- get_people(infotest,
                             alert = c("Dani Bodor", "Mateusz Kuzak"),
                             instr_team)

  expect_true(is.list(team_members))
  expect_equal(length(team_members), 4)
  expect_true("ms_team_member" %in% class(team_members[[1]]))
})

test_that("When people cannot be identified, the program reports this.", {
  errorps <- "Person Notemployed"

  expect_message(get_people(infotest,
                            alert = errorps,
                            instr_team),
                 regexp = "Cannot find team member Person Notemployed")

})

test_that("Some people who were not alerted in the past are identified correctly.",{
  infotest$lead_instructor <- "Sarah Alidoost"
  infotest$supporting_instructor1 <- "Giulia Crocioni"
  infotest$supporting_instructor2 <- "Laura Ootes"
  infotest$helper1 <- "Fakhereh (Sarah) Alidoost"
  infotest$helper2 <- "Barbara Vreede"
  infotest$helper3 <- NA

  team_members <- get_people(infotest,
                             alert = NA,
                             instr_team)

  expect_true(is.list(team_members))
  expect_equal(length(team_members), 3)
  expect_true("ms_team_member" %in% class(team_members[[1]]))

})


