# spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    # Use sequence for unique titles
    sequence(:title) { |n| "Project #{n}" }
    
    # Required fields
    date { Date.today }

    # Optional fields with sensible defaults
    description { "A description of the project." }
    technologies { "Ruby, Rails, JavaScript" }

    # URLs – ensure they are valid formats
    website_url { "https://example.com" }
    github_url { "https://github.com/example/project" }

    # Traits (unchanged)
    trait :with_featured_image do
      after(:build) do |project|
        project.featured_image.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/example_image.jpg')),
          filename: 'example_image.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_screenshots do
      after(:build) do |project|
        project.screenshots.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/screenshot1.jpg')),
          filename: 'screenshot1.jpg',
          content_type: 'image/jpeg'
        )
        project.screenshots.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/screenshot2.jpg')),
          filename: 'screenshot2.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :minimal do
      description { nil }
      technologies { nil }
      website_url { nil }
      github_url { nil }
    end
  end
end