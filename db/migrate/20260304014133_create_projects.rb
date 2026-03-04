# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.date :date
      t.string :website_url
      t.string :github_url
      t.string :technologies
      t.string :featured_image

      t.timestamps
    end
  end
end
