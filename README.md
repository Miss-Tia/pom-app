# README


🌱 Peace of Mind (POM): Grow Where You Are Planted


Peace of Mind (POM) is a journaling, gardening, and (eventually) recipe-tracking application focused on emotional wellness, internal reflection, and nurturing routines like gardening and journaling.
It’s designed for individuals rediscovering themselves—like moms with grown children or anyone on a journey toward a more peaceful, intentional life.
Built as a final project for my Ruby on Rails course (that I just keep building on), POM is a personal and purposeful space to cultivate calm.

Features
- Journaling: Write entries, edit thoughts, and generate AI-powered reflection prompts.
- Garden Tracker: Organize gardens, plants, and planting events. Log progress with timestamped notes.
- Authentication: Users log in securely with role-based dashboard access.
- Prompt Generator: AI integration for mindfulness and future shadow work prompts.

Tech
- Ruby on Rails 8.0.2
- PostgreSQL 
- Turbo / Hotwire
- StimulusJS (custom controllers for prompt generation + timestamp formatting)
- RSpec + FactoryBot + Faker
- OpenAI API integration (for prompt generation)

Tests
- Request specs for all major GET, POST, PATCH routes
- Validations and model behavior tested with RSpec
- Full CRUD coverage across journal entries, plantings, and gardens.

URL: https://pom-app.onrender.com/

What I Learned:
- How to build and test full CRUD Rails resources
- Implementing user authentication and role-based access
- Integrating external APIs using POST requests and Stimulus
- Building a custom UI that reflects an app’s emotional tone
- Debugging complex controller/view logic in a real-world project

Future Plans for POM:
- Image uploads and file attachments for journal entries
- Calendar view for planting, watering, and harvesting
- Mood-based and shadow work prompt generation
- A recipe keeper tied to journal reflections
- Image uploads for recipes


👩‍🎓 Created by Tia Anderson, a RailsConf 2025 Scholar, software engineer-in-training, and lifelong grower of both gardens and ideas.









