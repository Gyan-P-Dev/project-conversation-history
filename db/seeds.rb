# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



user = User.find_by(email: "user@example.com") || User.create!(username: "user 1", email: "user@example.com", password: "password", password_confirmation: "password")

projects = []
10.times do |i|
  projects << Project.create!(
    name: "project #{i+1}",
    status: "open",
    description: "this is project #{i+1} description",
    user_id: user.id
  )
end

projects.each do |project|
  3.times do |i|
    Comment.create!(
      content: "This is comment #{i+1} for #{project.name}",
      user_id: user.id,
      project_id: project.id
    )
  end
end
