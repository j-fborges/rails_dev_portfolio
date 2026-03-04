# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id             :bigint           not null, primary key
#  title          :string(255)
#  description    :text(65535)
#  date           :date
#  website_url    :string(255)
#  github_url     :string(255)
#  technologies   :string(255)
#  featured_image :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Project < ApplicationRecord
  has_one_attached :featured_image
  has_many_attached :screenshots # if you want multiple images
  validates :title, presence: true
  validates :date, presence: true
  validates :website_url, format: {
    with: URI::DEFAULT_PARSER.make_regexp,
    allow_blank: true
  }
  validates :github_url, format: {
    with: URI::DEFAULT_PARSER.make_regexp,
    allow_blank: true
  }
end
