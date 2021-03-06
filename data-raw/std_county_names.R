# define standard county names
county_name <- c(
  "Adams", "Alexander", "Bond", "Boone", "Brown",
  "Bureau", "Calhoun", "Carroll", "Cass", "Champaign",
  "Christian", "Clark", "Clay", "Clinton", "Coles",
  "Cook", "Crawford", "Cumberland", "DeKalb", "De Witt",
  "Douglas", "DuPage", "Edgar", "Edwards", "Effingham",
  "Fayette", "Ford", "Franklin", "Fulton", "Gallatin",
  "Greene", "Grundy", "Hamilton", "Hancock", "Hardin",
  "Henderson", "Henry", "Iroquois", "Jackson", "Jasper",
  "Jefferson", "Jersey", "Jo Daviess", "Johnson", "Kane",
  "Kankakee", "Kendall", "Knox", "Lake", "LaSalle",
  "Lawrence", "Lee", "Livingston", "Logan", "McDonough",
  "McHenry", "McLean", "Macon", "Macoupin", "Madison",
  "Marion", "Marshall", "Mason", "Massac", "Menard",
  "Mercer", "Monroe", "Montgomery", "Morgan", "Moultrie",
  "Ogle", "Peoria", "Perry", "Piatt", "Pike",
  "Pope", "Pulaski", "Putnam", "Randolph", "Richland",
  "Rock Island", "St. Clair",  "Saline", "Sangamon", "Schuyler",
  "Scott", "Shelby", "Stark", "Stephenson", "Tazewell",
  "Union", "Vermilion", "Wabash", "Warren", "Washington",
  "Wayne", "White", "Whiteside", "Will", "Williamson",
  "Winnebago", "Woodford"
)

county_std <- data.frame(
  fips_number = seq(1, 203, 2) + 17000,
  county_name,
  stringsAsFactors = FALSE
)
