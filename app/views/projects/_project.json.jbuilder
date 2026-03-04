# frozen_string_literal: true

json.extract! project, :id, :title, :description, :date, :website_url,
              :github_url, :technologies, :featured_image,
              :created_at, :updated_at
json.url project_url(project, format: :json)
