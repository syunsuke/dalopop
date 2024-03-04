test_that("pop04 test", {
  expect_equal(read_pop04("data/pop02_hosei201701_12.xlsx"),NA)
  expect_error(read_pop04("data/pop04_error_lackarea_jk20231201.xlsx"))
  expect_error(read_pop04("data/pop04_error_diffarea_jk20231201.xlsx"))
})
