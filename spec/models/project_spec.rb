# spec/models/project_spec.rb
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    it 'is valid with default factory attributes' do
      project = build(:project)
      expect(project).to be_valid
    end

    it 'requires a title' do
      project = build(:project, title: nil)
      expect(project).not_to be_valid
      expect(project.errors[:title]).to include("can't be blank")
    end

    it 'requires a date' do
      project = build(:project, date: nil)
      expect(project).not_to be_valid
      expect(project.errors[:date]).to include("can't be blank")
    end

    describe 'website_url format' do
      it 'allows blank website_url' do
        project = build(:project, website_url: '')
        expect(project).to be_valid
      end

      it 'accepts valid http URLs' do
        project = build(:project, website_url: 'http://example.com')
        expect(project).to be_valid
      end

      it 'accepts valid https URLs' do
        project = build(:project, website_url: 'https://example.com')
        expect(project).to be_valid
      end

      it 'rejects invalid URLs' do
        project = build(:project, website_url: 'not-a-url')
        expect(project).not_to be_valid
        expect(project.errors[:website_url]).to include('is invalid')
      end
    end

    describe 'github_url format' do
      it 'allows blank github_url' do
        project = build(:project, github_url: '')
        expect(project).to be_valid
      end

      it 'accepts valid http URLs' do
        project = build(:project, github_url: 'http://github.com/user/repo')
        expect(project).to be_valid
      end

      it 'accepts valid https URLs' do
        project = build(:project, github_url: 'https://github.com/user/repo')
        expect(project).to be_valid
      end

      it 'rejects invalid URLs' do
        project = build(:project, github_url: 'github.com')
        expect(project).not_to be_valid
        expect(project.errors[:github_url]).to include('is invalid')
      end
    end
  end

  describe 'Active Storage attachments' do
    # Test the relationship existence (these don't require saving)
    it 'has one attached featured_image' do
      expect(Project.new.featured_image).to be_an_instance_of(ActiveStorage::Attached::One)
    end

    it 'has many attached screenshots' do
      expect(Project.new.screenshots).to be_an_instance_of(ActiveStorage::Attached::Many)
    end

    # Test that the factory traits actually attach files
    # These require a saved record because ActiveStorage needs an ID
    describe 'factory traits' do
      # Ensure you have a sample image at spec/fixtures/files/example_image.jpg
      it 'can create a project with a featured image' do
        # Use create (not build) to persist the record so attachments can be saved
        project = create(:project, :with_featured_image)
        expect(project.featured_image).to be_attached
      end

      it 'can create a project with screenshots' do
        project = create(:project, :with_screenshots)
        expect(project.screenshots).to be_attached
        expect(project.screenshots.count).to eq(2)
      end
    end
  end
end