# frozen_string_literal: true

require 'application_system_test_case'

class ProjectsTest < ApplicationSystemTestCase
  setup do
    @project = projects(:one)
  end

  test 'visiting the index' do
    visit projects_url
    assert_selector 'h1', text: 'Projects'
  end

  test 'creating a Project' do
    visit projects_url
    click_on 'New Project'

    fill_in 'Date', with: @project.date
    fill_in 'Description', with: @project.description
    fill_in 'Featured image', with: @project.featured_image
    fill_in 'Github url', with: @project.github_url
    fill_in 'Technologies', with: @project.technologies
    fill_in 'Title', with: @project.title
    fill_in 'Website url', with: @project.website_url
    click_on 'Create Project'

    assert_text 'Project was successfully created'
    click_on 'Back'
  end

  test 'updating a Project' do
    visit projects_url
    click_on 'Edit', match: :first

    fill_in 'Date', with: @project.date
    fill_in 'Description', with: @project.description
    fill_in 'Featured image', with: @project.featured_image
    fill_in 'Github url', with: @project.github_url
    fill_in 'Technologies', with: @project.technologies
    fill_in 'Title', with: @project.title
    fill_in 'Website url', with: @project.website_url
    click_on 'Update Project'

    assert_text 'Project was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Project' do
    visit projects_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Project was successfully destroyed'
  end
end
