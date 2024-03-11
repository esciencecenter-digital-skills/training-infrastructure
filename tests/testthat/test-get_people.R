skip_on_ci()

test_that("People are identified as Instructors team members", {
  infotest = readRDS(file = "infotest.rda")
  instr_team <- Microsoft365R::get_team("Instructors")
  team_members <- get_people(infotest,
                             alert = c("Dani Bodor", "Mateusz Kuzak"),
                             instr_team)

  expect_true(is.list(team_members))
  expect_equal(length(team_members), 4)
  expect_true("ms_team_member" %in% class(team_members[[1]]))
})
