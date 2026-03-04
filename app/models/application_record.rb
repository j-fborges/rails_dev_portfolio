# frozen_string_literal: true

# Base Application Persistence Class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
