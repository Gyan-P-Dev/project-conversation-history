class MentionExtractor
	def self.extract(content)
		usernames = content.scan(/@(\w+)/).flatten
		User.where(username: usernames)
	end
end
