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
alias FanCan.Core.Attachments

Repo.insert_all(User, [
      %{id: "a9f44567-e031-44f1-aae6-972d7aabbb45", username: "admin", email: "admin@admin.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "jim_the_og", email: "jim@jim.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "aaron", email: "aaron@aaron.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_boyd", email: "User1@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "TheMan98", email: "User2@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Anders01", email: "User3@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "j_trumpet", email: "User4@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "JudFrazier", email: "User5@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "MMMM0101", email: "User6@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "BigBadRoy", email: "User7@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "tatTay33", email: "User8@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "r_r_lays", email: "User9@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "redman6", email: "redman@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "Howitzaaah", email: "bbr@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()},
      %{username: "temp09tem", email: "t89t@example.com", hashed_password: Bcrypt.hash_pwd_salt("password"), confirmed_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now(), inserted_at: NaiveDateTime.local_now()}
])

Repo.insert_all(Attachments, [
      %{id: "a7f44567-e031-44f1-aae6-972d7aabbb45", title: "Test Candidate", path: "https://upload.wikimedia.org/wikipedia/commons/b/bb/PavelTravnicek2022.jpg", data: nil, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()}
])
# Removing IDs but will need them for prod likely (binary_id vs. int)
Repo.insert_all(Candidate, [
      %{prefix: "Mr.", f_name: "Robert", l_name: "Boyd", suffix: "Jr.", incumbent_since: nil, dob: ~D[2000-01-01], district: 10, attachments: ["a7f44567-e031-44f1-aae6-972d7aabbb45"],
      party: :democrat, cpvi: "D+20", residence: "Douglas", state: :NE, type: "senator", inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()},
])



