FactoryBot.define do
	factory :project do
		name { "Test Project" }
		status { "open" } 
		description { "Sample project description" }
		association :user
	end
end
