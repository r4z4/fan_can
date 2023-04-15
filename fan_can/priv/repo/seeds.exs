# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FanCan.Repo.insert!(%FanCan.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# 8d04fd4f-1321-4e9f-911a-7369d57d0b55

alias FanCan.Repo
alias FanCan.Accounts.User
alias FanCan.Accounts.UserFollows
alias FanCan.Public.Candidate
alias FanCan.Public.Election
alias FanCan.Public.State
alias FanCan.Site.Forum
alias FanCan.Core.Attachment
alias FanCan.Public.Election.Race
alias FanCan.Public.Election.Ballot

Repo.insert_all(State, [
      %{id: 1, name: :Alabama, code: :AL, num_districts: 7, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 2, name: :Alaska, code: :AK, num_districts: 0, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 3, name: :Arizona, code: :AZ, num_districts: 9, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 4, name: :Arkansas, code: :AR, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 5, name: :California, code: :CA, num_districts: 52, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 6, name: :Colorado, code: :CO, num_districts: 8, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 7, name: :Connecticut, code: :CT, num_districts: 5, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 8, name: :Delaware, code: :DE, num_districts: 1, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 9, name: :Florida, code: :FL, num_districts: 28, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 10, name: :Georgia, code: :GA, num_districts: 14, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 11, name: :Hawaii, code: :HI, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 12, name: :Idaho, code: :ID, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 13, name: :Illinois, code: :IL, num_districts: 17, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 14, name: :Indiana, code: :IN, num_districts: 9, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 15, name: :Iowa, code: :IA, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 16, name: :Kansas, code: :KS, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 17, name: :Kentucky, code: :KY, num_districts: 6, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 18, name: :Louisiana, code: :LA, num_districts: 6, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 19, name: :Maine, code: :ME, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 20, name: :Maryland, code: :MD, num_districts: 8, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 21, name: :Massachusetts, code: :MA, num_districts: 9, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 22, name: :Michigan, code: :MI, num_districts: 13, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 23, name: :Minnesota, code: :MN, num_districts: 8, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 24, name: :Mississippi, code: :MS, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 25, name: :Missouri, code: :MO, num_districts: 8, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 26, name: :Montana, code: :MT, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 27, name: :Nebraska, code: :NE, num_districts: 3, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 28, name: :Nevada, code: :NV, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 29, name: :New_Hampshire, code: :NH, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 30, name: :New_Jersey, code: :NJ, num_districts: 12, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 31, name: :New_Mexico, code: :NM, num_districts: 3, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 32, name: :New_York, code: :NY, num_districts: 26, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 33, name: :North_Carolina, code: :NC, num_districts: 14, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 34, name: :North_Dakota, code: :ND, num_districts: 3, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 35, name: :Ohio, code: :OH, num_districts: 15, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 36, name: :Oklahoma, code: :OK, num_districts: 5, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 37, name: :Oregon, code: :OR, num_districts: 6, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 38, name: :Pennsylvania, code: :PA, num_districts: 17, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 39, name: :Rhode_Island, code: :RI, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 40, name: :South_Carolina, code: :SC, num_districts: 7, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 41, name: :South_Dakota, code: :SD, num_districts: 1, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 42, name: :Tennessee, code: :TN, num_districts: 9, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 43, name: :Texas, code: :TX, num_districts: 38, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 44, name: :Utah, code: :UT, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 45, name: :Vermont, code: :VT, num_districts: 4, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 46, name: :Virginia, code: :VA, num_districts: 11, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 47, name: :Washington, code: :WA, num_districts: 10, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 48, name: :West_Virginia, code: :WV, num_districts: 2, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 49, name: :Wisconsin, code: :WI, num_districts: 8, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: 50, name: :Wyoming, code: :WY, num_districts: 1, governor: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(User, [
      %{id: "a9f44567-e031-44f1-aae6-972d7aabbb45", username: "admin", state: :NE, district: nil, email: "admin@admin.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "b5f44567-e031-44f1-aae6-972d7aabbb45", username: "jim_the_og", state: :NE, district: nil, email: "jim@jim.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "b3f44567-e031-44f1-aae6-972d7aabbb45", username: "aaron", state: :NE, district: nil, email: "aaron@aaron.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "b1f44567-e031-44f1-aae6-972d7aabbb45", username: "TheMan98", state: :NE, district: nil, email: "User@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "b2f44567-e031-44f1-aae6-972d7aabbb45", username: "Anders01", state: :KS, district: nil, email: "User2@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(Attachment, [
      %{id: "a7f44567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "Test Democrat", path: "https://upload.wikimedia.org/wikipedia/commons/b/bb/PavelTravnicek2022.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "Test Republican", path: "https://upload.wikimedia.org/wikipedia/commons/c/c4/Roy_Dale_Cope.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a8f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/9/94/Adrian_Smith_116th_Congress.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a6f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/b/bc/Mike_Flood_117th_Congress_%28cropped%29.jpeg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a2f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/5/5f/Don_Bacon_portrait_%28118th_Congress%29.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44967-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Gov_2018", path: "https://upload.wikimedia.org/wikipedia/commons/b/bd/Sen._Pete_Ricketts_official_portrait%2C_118th_Congress.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f88967-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Gov_2022", path: "https://upload.wikimedia.org/wikipedia/commons/7/72/Jim_Pillen_%28cropped%29.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44567-e031-44f1-aae6-972d7aabbb49", type: :image, title: "AK_Gov", path: "https://en.wikipedia.org/wiki/Mike_Dunleavy_(politician)#/media/File:Mike_Dunleavy_official_photo.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a1f44367-e031-44f1-aae6-972d7aabbb49", type: :image, title: "JulieSlama", path: "https://upload.wikimedia.org/wikipedia/commons/2/21/Julie_Slama_%2851850518231%29.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "848dd11c-d924-48e7-bdc2-9db000222365", type: :image, title: "DebF", path: "https://upload.wikimedia.org/wikipedia/commons/9/93/Deb_Fischer_official_Senate_photo.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()}
])
# Removing IDs but will need them for prod likely (binary_id vs. int)
Repo.insert_all(Candidate, [
      %{id: "0e31998f-503f-4218-a801-c8bb7ff9498b", prefix: :Mr, f_name: "Robert", l_name: "Boyd", suffix: :Jr, incumbent_since: nil, dob: ~D[1976-05-05], district: 10, attachments: ["a7f44567-e031-44f1-aae6-972d7aabbb45"],
      party: :Democrat, cpvi: "D+20", education: ["University of Nebraska-Lincoln"], birth_state: :NE, state: :NE, seat: :Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e91998f-503f-4218-a801-c8bb7ff9498b", prefix: nil, f_name: "Joe", l_name: "Trumpet", suffix: :III, incumbent_since: ~D[2020-11-04], dob: ~D[1980-09-01], district: 10, attachments: ["a5f44567-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+10", education: ["University of Nebraska-Omaha"], birth_state: :NE, state: :NE, seat: :Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e91798f-503f-4218-a801-c8bb7ff9498b", prefix: :Dr, f_name: "Judson", l_name: "Frazier", suffix: nil, incumbent_since: ~D[2016-11-04], dob: ~D[1980-09-01], district: 3, attachments: nil,
      party: :Republican, cpvi: "R+30", education: ["University of Nebraska-Lincoln"], birth_state: :NE, state: :NE, seat: :Judge, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e91198f-503f-4218-a801-c8bb7ff9498b", prefix: nil, f_name: "Pete", l_name: "Ricketts", suffix: nil, incumbent_since: nil, dob: ~D[1964-08-19], district: nil, attachments: ["a5f44967-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+30", education: ["University of Chicago"], birth_state: :NE, state: :NE, seat: :Governor, end_date: ~D[2023-01-05], inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      # NE Gov Race E.g.
      %{id: "0e97798f-503f-4218-a801-c8bb7ff9498b", prefix: nil, f_name: "Jim", l_name: "Pillen", suffix: nil, incumbent_since: ~D[2023-01-05], dob: ~D[1955-12-31], district: nil, attachments: ["a5f88967-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+30", education: ["University of Nebraska Lincoln", "Kansas State University"], birth_state: :NE, state: :NE, seat: :Governor, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e97798f-503f-4218-a801-c8bb7ff3498b", prefix: nil, f_name: "Carol", l_name: "Blood", suffix: nil, incumbent_since: ~D[2017-01-04], dob: ~D[1961-03-05], district: 3, attachments: nil,
      party: :Democrat, cpvi: "D+20", education: ["Metropolitan Community College"], birth_state: :NE, state: :NE, seat: :Legislator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},

      # NE House Reps
      %{id: "0e97798f-503f-4218-a801-c8bb1ff9498b", prefix: nil, f_name: "Mike", l_name: "Flood", suffix: nil, incumbent_since: ~D[2022-07-12], dob: ~D[1975-02-23], district: 1, attachments: ["a6f14567-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+9", education: ["University of Notre Dame", "University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :Representative, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e97798f-503f-4218-a801-c8bb2ff9498b", prefix: nil, f_name: "Don", l_name: "Bacon", suffix: nil, incumbent_since: ~D[2017-01-03], dob: ~D[1963-08-16], district: 2, attachments: ["a2f14567-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "EVEN", education: ["Northern Illinois University", "University of Phoenix", "National War College"], birth_state: :IL, state: :NE, seat: :Representative, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e97798f-503f-4218-a801-c8bb3ff9498b", prefix: nil, f_name: "Adrian", l_name: "Smith", suffix: nil, incumbent_since: ~D[2007-01-04], dob: ~D[1970-12-19], district: 3, attachments: ["a8f14567-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+29", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :Representative, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},

      %{id: "0e91138f-503f-4218-a801-c8bb7ff3398b", prefix: nil, f_name: "Pete", l_name: "Ricketts", suffix: nil, incumbent_since: ~D[2023-01-23], dob: ~D[1964-08-19], district: nil, attachments: ["a5f44967-e031-44f1-aae6-972d7aabbb45"],
      party: :Republican, cpvi: "R+30", education: ["University of Chicago"], birth_state: :NE, state: :NE, seat: :Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "0e91778f-503f-4218-a801-c8bb7ff9498b", prefix: nil, f_name: "Mike", l_name: "Dunleavy", suffix: nil, incumbent_since: ~D[2018-12-03], dob: ~D[1961-05-06], district: nil, attachments: ["a5f44567-e031-44f1-aae6-972d7aabbb49"],
      party: :Republican, cpvi: "R+30", education: ["Misericordia University", "University of Alaska Fairbanks"], birth_state: :PA, state: :AK, seat: :Governor, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},

      # Senators
      %{id: "9b9b951e-3f3c-4350-8ffb-a36a981e376d", prefix: nil, suffix: nil, incumbent_since: ~D[2012-01-05], dob: ~D[1951-03-01], attachments: ["848dd11c-d924-48e7-bdc2-9db000222365"], district: nil, l_name: "Fischer", f_name: "Deb",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "55f7e3e6-883a-4c4a-b04c-b69bcc741273", prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: nil, l_name: "Shelton", f_name: "Alicia",
      party: :Democrat, cpvi: "EVEN", education: ["Xavier University", "Bellevus University"], birth_state: :NE, state: :NE, seat: nil, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      # NE State Senators
      %{id: "0e33778f-503f-4218-a801-c8bb7ff9498b", prefix: nil, suffix: nil, incumbent_since: ~D[2019-01-09], dob: ~D[1996-05-02], attachments: ["a1f44367-e031-44f1-aae6-972d7aabbb49"], district: 1, l_name: "Slama", f_name: "Julie",
      party: :Republican, cpvi: "EVEN", education: ["Yale University"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 2, l_name: "Clements", f_name: "Robert",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 3, l_name: "Blood", f_name: "Carol",
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 4, l_name: "von Gillern", f_name: "Brad",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 5, l_name: "McDonnell", f_name: "Mike",
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 6, l_name: "Cavanaugh", f_name: "Machaela",
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 7, l_name: "Vargas", f_name: "Tony", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 8, l_name: "Hunt", f_name: "Megan", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 9, l_name: "Cavanaugh", f_name: "John", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 10, l_name: "DeBoer", f_name: "Wendy", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 11, l_name: "McKinney", f_name: "Terrell", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 12, l_name: "Riepe", f_name: "Merv", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 13, l_name: "Wayne", f_name: "Justin", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 14, l_name: "Arch", f_name: "John", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 15, l_name: "Walz", f_name: "Lynne",
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 16, l_name: "Hansen", f_name: "Ben", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 17, l_name: "Albrecht", f_name: "Joni", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 18, l_name: "Armendariz", f_name: "Christy", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 19, l_name: "Dover", f_name: "Robert", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 20, l_name: "Fredrickson", f_name: "John", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 21, l_name: "Ballard", f_name: "Beau", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 22, l_name: "Moser", f_name: "Mike", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: ~D[2017-01-04], dob: nil, attachments: nil, district: 23, l_name: "Bostelman", f_name: "Bruce", 
      party: :Republican, cpvi: "EVEN", education: ["Bellevue University"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 24, l_name: "Hughes", f_name: "Jana", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 25, l_name: "Bosn", f_name: "Carolyn", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 26, l_name: "Dungan", f_name: "George", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: ~D[2017-01-04], dob: ~D[1985-01-02], attachments: nil, district:  27, l_name: "Wishart", f_name: "Anna", 
      party: :Democrat, cpvi: "EVEN", education: ["Middlebury College"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 28, l_name: "Raybould", f_name: "Jane", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 29, l_name: "Bostar", f_name: "Eliot", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 30, l_name: "Dorn", f_name: "Myron", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 31, l_name: "Kauth", f_name: "Kathleen", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 32, l_name: "Brandt", f_name: "Tom", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 33, l_name: "Halloran", f_name: "Steve", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 34, l_name: "Lippincott", f_name: "Loren",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 35, l_name: "Aguilar", f_name: "Raymond", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 36, l_name: "Holdcroft", f_name: "Rick", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: :Sr, incumbent_since: nil, dob: nil, attachments: nil, district: 37, l_name: "Lowe", f_name: "John",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 38, l_name: "Murman", f_name: "Dave", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 39, l_name: "Linehan", f_name: "Lou Ann", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 40, l_name: "DeKay", f_name: "Barry", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 41, l_name: "Briese", f_name: "Tom", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 42, l_name: "Jacobson", f_name: "Mike", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 43, l_name: "Brewer", f_name: "Tom", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 44, l_name: "Ibach", f_name: "Teresa", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 45, l_name: "Sanders", f_name: "Rita", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 46, l_name: "Conrad", f_name: "Danielle", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 47, l_name: "Erdman", f_name: "Steve", 
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 48, l_name: "Hardin", f_name: "Brian",
      party: :Republican, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: Ecto.UUID.generate(), prefix: nil, suffix: nil, incumbent_since: nil, dob: nil, attachments: nil, district: 49, l_name: "Day", f_name: "Jen", 
      party: :Democrat, cpvi: "EVEN", education: ["University of Nebraska Lincoln"], birth_state: :NE, state: :NE, seat: :State_Senator, end_date: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()}

])

Repo.insert_all(Election, [
      %{id: "a1f44567-e031-44f1-aae6-972d7aabbb45", desc: "2022 Midterm Election", election_date: ~D[2021-11-01], state: :NE, year: 2022, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "bfe75d28-b2eb-4478-82f5-17828f9c82c6", desc: "2024 General Election", election_date: ~D[2023-11-01], state: :NE, year: 2024, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},   
])

# Elect % 0.0 for non-race (appointments, emergency positions etc...). Add a notes col or table
Repo.insert_all(Race, [
      %{seat: :Senator, election_id: "a1f44567-e031-44f1-aae6-972d7aabbb45", elect_percentage: 0.0, elect: "0e91138f-503f-4218-a801-c8bb7ff3398b", district: nil, candidates: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], attachments: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{seat: :Governor, election_id: "a1f44567-e031-44f1-aae6-972d7aabbb45", elect_percentage: 59.7, elect: "0e97798f-503f-4218-a801-c8bb7ff9498b", district: nil, candidates: ["0e97798f-503f-4218-a801-c8bb7ff3498b", "0e97798f-503f-4218-a801-c8bb7ff9498b"], attachments: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      # 2024
      %{seat: :Senator, election_id: "bfe75d28-b2eb-4478-82f5-17828f9c82c6", elect_percentage: nil, elect: nil, district: nil, candidates: ["9b9b951e-3f3c-4350-8ffb-a36a981e376d", "55f7e3e6-883a-4c4a-b04c-b69bcc741273"], attachments: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},

])

Repo.insert_all(Forum, [
      %{id: "8d04fd4f-1321-4e9f-911a-7369d57d0b55", title: "Issues", desc: "Forum for all generic site related issues. All users will be subscribed.", category: :Site, moderator: "a9f44567-e031-44f1-aae6-972d7aabbb45", members: ["a9f44567-e031-44f1-aae6-972d7aabbb45"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "8d04fd4f-1321-4e9f-911a-7399d57d0b55", title: "2024 Election", desc: "It's almost here.", category: :Politics, moderator: "b5f44567-e031-44f1-aae6-972d7aabbb45", members: ["b5f44567-e031-44f1-aae6-972d7aabbb45"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(Ballot, [
      %{id: "0bf74d8b-edc4-432c-a1db-732168966ea3", election: "bfe75d28-b2eb-4478-82f5-17828f9c82c6", columns: 3, attachment: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{id: "52e101ec-4106-4603-9be4-782c9d42299f", election: "a1f44567-e031-44f1-aae6-972d7aabbb45", columns: 4, attachment: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])
# "Follow" = "Subscribe"
Repo.insert_all(UserFollows, [
      # All need to follow admin
      %{user_id: "b5f44567-e031-44f1-aae6-972d7aabbb45", type: :user, follow_ids: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{user_id: "b3f44567-e031-44f1-aae6-972d7aabbb45", type: :user, follow_ids: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{user_id: "b1f44567-e031-44f1-aae6-972d7aabbb45", type: :user, follow_ids: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{user_id: "b2f44567-e031-44f1-aae6-972d7aabbb45", type: :user, follow_ids: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      # Set up some initial candidate follows
      %{user_id: "b5f44567-e031-44f1-aae6-972d7aabbb45", type: :candidate, follow_ids: ["0e97798f-503f-4218-a801-c8bb7ff9498b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{user_id: "b3f44567-e031-44f1-aae6-972d7aabbb45", type: :candidate, follow_ids: ["0e97798f-503f-4218-a801-c8bb7ff3498b", "0e97798f-503f-4218-a801-c8bb7ff9498b"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      # Set up some initial election follows
      %{user_id: "b5f44567-e031-44f1-aae6-972d7aabbb45", type: :election, follow_ids: ["a1f44567-e031-44f1-aae6-972d7aabbb45"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      # Set up some initial forum follows
      %{user_id: "b5f44567-e031-44f1-aae6-972d7aabbb45", type: :forum, follow_ids: ["8d04fd4f-1321-4e9f-911a-7369d57d0b55"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{user_id: "b3f44567-e031-44f1-aae6-972d7aabbb45", type: :forum, follow_ids: ["8d04fd4f-1321-4e9f-911a-7369d57d0b55", "8d04fd4f-1321-4e9f-911a-7399d57d0b55"], updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

# Ecto.UUID.bingenerate()






