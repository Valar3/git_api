# frozen_string_literal: true

class User < ApplicationRecord
  has_many :blacklisted_repos, dependent: :destroy
end
