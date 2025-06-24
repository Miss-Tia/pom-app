# README


Peace of Mind (POM): Grow Where You Are Planted is a journaling, gardening, and (eventually) recipe tracking application focused on emotional wellness, internal reflection, and nurturing routines like gardening and journaling. It's designed for individuals such as moms with grown children, or anyone else who may be rediscovering themselves and on a journey towards building a life centered around peace, intention, and creativity. Built as a final project for my Ruby on Rails course that I just keep adding on to, POM is a personal and purposeful space to cultivate calm. 


Allows users to track what/when/why they plant in their garden, log personal reflections(wins/struggles/gratitude/random thoughts), and respond to AI generated journal prompts. Also a feature to respond to shadow work writing prompts for deep emotional self-exploration.

Features
- Journaling: Write entries, edit your thoughts, and generate reflection prompts with AI.
- Garden Tracker: Organize gardens, plants, and planting events. Log progress with notes.
- Authentication: Users log in securely and access dashboards based on their role.

Tech
- Ruby on Rails 8.2
- PostgreSQL
- Turbo / Hotwire
- StimulusJS (custom controllers for prompt generation + timestamp formatting)
- RSpec + FactoryBot + Faker
- OpenAI API integration (for prompt generation)

Tests
- Request specs for all major GET, POST, PATCH routes
- Validations and model behavior tested with RSpec
- Full CRUD coverage across journal entries, plantings, and gardens.

Setup Instructions:

1. Clone the repo  
   `git clone https://github.com/your-username/pom-app.git && cd pom-app`

2. Install dependencies  
   `bundle install && yarn install`

3. Set up the database  
   `rails db:create db:migrate db:seed`

4. Set your OpenAI API key  
   Create a `.env` file and add:  
   OPENAI_API_KEY=your_key_here

5. Run the server  
   `bin/dev` (or `rails s` if you're not using foreman)

🗒️ Note: (6/24/25)I will be deploying this app and giving it a web address shortly so you won't need a key to use the AI feature.
         Will update here when it's done.

What I Learned:
- How to build and test full CRUD Rails resources
- Implementing user authentication and role-based access
- Integrating external APIs using POST requests and Stimulus
- Building a custom UI that reflects an app’s emotional tone
- Debugging complex controller/view logic in a real-world project

Future Plans for POM:
- Add image upload and file attachments to journal entries
- Calendar view for planting and watering schedules
- More nuanced AI prompt generation (e.g. shadow work prompts or mood based prompts)
- Recipe keeper that can be tied to a journal entry
- Image upload for Recipe keeper




👩‍🎓 Created by Tia Anderson, a RailsConf 2025 Scholar, software engineer-in-training, and lifelong grower of both gardens and ideas.









