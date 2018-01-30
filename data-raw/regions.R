# create data
northern = c("Jo Daviess", "Stephenson", "Winnebago", "Boone", "McHenry", "Lake", "Carroll", "Ogle", "Whiteside", "Lee", "De Kalb", "Kane", "Du Page", "La Salle", "Kendall", "Grundy", "Will")
central = c("Rock Island", "Henry", "Bureau", "Putnam", "Mercer", "Henderson", "Warren", "Knox", "Stark", "Marshall", "Peoria", "Woodford", "Livingston", "Kankakee", "Iroquois", "Hancock", "McDonough", "Fulton", "Tazewell", "McLean", "Ford", "Adams", "Schuyler", "Mason", "Logan", "De Witt", "Brown", "Cass", "Menard", "Pike", "Scott", "Morgan", "Sangamon", "Christian", "Macon", "Piatt", "Champaign", "Vermilion", "Greene", "Macoupin", "Montgomery", "Shelby", "Moultrie", "Douglas", "Coles", "Edgar")
southern = c("Calhoun", "Jersey", "Cumberland", "Clark", "Madison", "Bond", "Fayette", "Effingham", "Jasper", "Crawford", "St. Clair", "Clinton", "Marion", "Clay", "Richland", "Lawrence", "Monroe", "Washington", "Jefferson", "Wayne", "Edwards", "Wabash", "Randolph", "Perry", "Franklin", "Hamilton", "White", "Jackson", "Williamson", "Saline", "Gallatin", "Union", "Johnson", "Pope", "Hardin", "Alexander", "Pulaski", "Massac")

regions <- data.frame(
  region = c(
    rep("Northern", length(northern)),
    rep("Central", length(central)),
    rep("Southern", length(southern)),
    "Cook"
    ),
  county = c(northern, central, southern, "Cook")
)

# use data
devtools::use_data(regions, overwrite = TRUE)
