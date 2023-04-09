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

alias FanCan.Repo
import Ecto.UUID
alias FanCan.Accounts.User
alias FanCan.Public.Candidate
alias FanCan.Public.Election
alias FanCan.Public.State
alias FanCan.Core.Attachment
alias FanCan.Public.Election.Race

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
      %{username: "jim_the_og", state: :NE, district: nil, email: "jim@jim.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "aaron", state: :NE, district: nil, email: "aaron@aaron.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_boyd", state: :KY, district: nil, email: "User1@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "TheMan98", state: :NE, district: nil, email: "User2@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Anders01", state: :KS, district: nil, email: "User3@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "j_trumpet", state: :NE, district: nil, email: "User4@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "JudFrazier", state: :NE, district: nil, email: "User5@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "MMMM0101", state: :NE, district: nil, email: "User6@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "BigBadRoy", state: :IL, district: nil, email: "User7@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "tatTay33", state: :NE, district: nil, email: "User8@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_r_lays", state: :MI, district: nil, email: "User9@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "redman6", state: :MN, district: nil, email: "redman@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Howitzaaah", state: :NE, district: nil, email: "bbr@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "temp09tem", state: :WV, district: nil, email: "t89t@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(Attachment, [
      %{id: "a7f44567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "Test Democrat", path: "https://upload.wikimedia.org/wikipedia/commons/b/bb/PavelTravnicek2022.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "Test Republican", path: "https://upload.wikimedia.org/wikipedia/commons/c/c4/Roy_Dale_Cope.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a8f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/9/94/Adrian_Smith_116th_Congress.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a6f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/b/bc/Mike_Flood_117th_Congress_%28cropped%29.jpeg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a2f14567-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Rep_2022", path: "https://upload.wikimedia.org/wikipedia/commons/5/5f/Don_Bacon_portrait_%28118th_Congress%29.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44967-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Gov_2018", path: "https://upload.wikimedia.org/wikipedia/commons/b/bd/Sen._Pete_Ricketts_official_portrait%2C_118th_Congress.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f88967-e031-44f1-aae6-972d7aabbb45", type: :image, title: "NE_Gov_2022", path: "https://upload.wikimedia.org/wikipedia/commons/7/72/Jim_Pillen_%28cropped%29.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
      %{id: "a5f44567-e031-44f1-aae6-972d7aabbb49", type: :image, title: "AK_Gov", path: "https://en.wikipedia.org/wiki/Mike_Dunleavy_(politician)#/media/File:Mike_Dunleavy_official_photo.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()}
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
])

Repo.insert_all(Election, [
      %{id: "a1f44567-e031-44f1-aae6-972d7aabbb45", desc: "2022 General Election", election_date: ~D[2022-11-01], state: :NE, year: 2022, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
])

# Elect % 0.0 for non-race (appointments, emergency positions etc...). Add a notes col or table
Repo.insert_all(Race, [
      %{seat: :Senator, election_id: "a1f44567-e031-44f1-aae6-972d7aabbb45", elect_percentage: 0.0, elect: "0e91138f-503f-4218-a801-c8bb7ff3398b", district: nil, candidates: ["0e91138f-503f-4218-a801-c8bb7ff3398b"], attachments: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{seat: :Governor, election_id: "a1f44567-e031-44f1-aae6-972d7aabbb45", elect_percentage: 59.7, elect: "0e97798f-503f-4218-a801-c8bb7ff9498b", district: nil, candidates: ["0e97798f-503f-4218-a801-c8bb7ff3498b", "0e97798f-503f-4218-a801-c8bb7ff9498b"], attachments: nil, updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])






