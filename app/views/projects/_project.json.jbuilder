json.extract! project, :id, :title, :description, :date, :website_url,
              :github_url, :technologies, :created_at, :updated_at
if project.featured_image.attached?
  json.featured_image url_for(project.featured_image)
else
  json.featured_image nil
end
json.url project_url(project, format: :json)