class User < ApplicationRecord
  has_many :blacklisted_repos, dependent: :destroy
end
