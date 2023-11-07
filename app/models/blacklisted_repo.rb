# frozen_string_literal: true

class BlacklistedRepo < ApplicationRecord
  belongs_to :user
end
