Fabricator(:user) do
  email                 Faker::Internet.email
  password              's3cr3t'
  password_confirmation 's3cr3t'
end
