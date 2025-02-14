# README


Go to Project Directory
Navigate to the project directory.

Install Required Ruby and Rails Versions

Ruby version: 3.3.3
Rails version: 7.1.5
Run the following commands in the terminal:

    gem install bundler
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed

The seed file will create:
    a user and 10 projects and 3 comments for each of them
    user credentials are: 
        email: user@example.com and password: password

Precompile Assets (if needed):
    rails assets:precompile


Start the Server:
    rails server


Login Details

URL: http://localhost:3000
Email: user@example.com
Password: password



Running Tests
To run the test suite, use the following command:

    rspec








Questions asked to client


Question:

Is it possible to implement a search functionality within the project conversation history?

I would like to know if it's feasible to add a search feature to this application. The idea would be to allow users to search through the comments and status changes in the project conversation history. Specifically, I am interested in knowing if we could:

Search by keywords or phrases: For example, allow users to search for specific terms within the comments (e.g., project name, issue description).
Filter by status changes: Enable filtering by different project statuses (e.g., "open", "closed", etc.).
Support search across multiple fields: Allow searching across both comments and status changes simultaneously.
Performance considerations: Ensure that the search works efficiently even as the conversation history grows in size.
Would it be possible to implement this in a Rails application, and if so, what approach or gems would you recommend for the search functionality?




Answer: 
You can definitely implement search functionality in the project conversation history using Ransack, which is a popular gem for adding search capabilities to your Rails models.









Question:

How can we display the current user's projects separately in the project list?

In the context of the project conversation history, I want to implement a feature where users can easily see their own projects distinctively from other users’ projects. The goals are:

Filter by Current User: I want to show the projects that belong to the logged-in user at the top or in a separate section of the project list.

Separation of Projects: I’m interested in displaying the current user's projects separately from the rest of the projects. This could involve either:

A specific section for "My Projects"
A separate tab or filter option to toggle between "My Projects" and "All Projects"
Implementation Strategy:

Should this be handled by scoping the query to only return projects owned by the current user?
How would you manage the separation, particularly when dealing with pagination or sorting of the projects?
Should we use Rails built-in features, such as current_user from Devise, to scope the projects?





Answer: 

To implement the feature of displaying the current user's projects separately, here's how it can be done effectively:

Approach:
Filter Projects by Current User: The key to filtering the projects by the logged-in user is using Ransack's query parameters. The user has implemented this correctly by adding q: { user_id_eq: current_user.id } to the projects_path. This filters the projects based on the user_id of the logged-in user.

Setting up the Path for the Current User's Projects: In the view, the link to filter and show only the current user's projects








Question:

How can we implement user mentions in comments, and what additional features can be added to enhance this functionality?

I want to allow users to mention other users within the comments section (e.g., using the @username format). Specifically, I’m interested in implementing the following:

Detecting Mentions in Comments:

When a user types @username in a comment, the system should automatically detect and parse this as a mention of another user.
How can we store and manage these mentions effectively in the database (e.g., using a many-to-many relationship)?
Linking Mentions to User Profiles:

The @username should be converted into a clickable link that takes the user to the mentioned user's profile page (e.g., /users/username).
User Notifications:

When a user is mentioned in a comment, they should receive a notification that they were mentioned.
What would be the best way to implement notifications for mentions? Should I use background jobs for real-time updates, or can this be done synchronously?





Answer:
To implement user mentions in comments, the following approach can be taken, with additional features like notifications and links to user profiles:

1. Detecting User Mentions in Comments
To detect mentions like @username in the comment text, a regular expression (regex) can be used. When a user types @username, the system needs to:

Parse the comment for mentions.
Store and manage mentions in the database, optionally using a many-to-many relationship between Comment and User.

2. Linking Mentions to User Profiles
To convert mentions into clickable links, you can use Rails helper methods to generate the link dynamically when rendering the comment content.

3. User Notifications for Mentions
To notify the user when they are mentioned in a comment, ActionMailer can be used to send an email notification. For a better user experience, LetterOpener can be used in development to preview emails.

Step-by-Step Implementation:
Install LetterOpener: Add it to your Gemfile for development:




NOTE:
i have added mention functionality in the comments but due to time limits of submission i have not added the suggest users while mentioning.
