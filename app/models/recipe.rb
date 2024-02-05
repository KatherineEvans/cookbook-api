class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :chef, presence: true

  belongs_to :user

  def ingredients_list
    ingredients.split(", ")
  end

  def directions_list
    directions.split(", ")
  end

  def friendly_created_at
    created_at.strftime("%b %e, %l:%M %p")
  end

  def friendly_prep_time
    hours = prep_time / 60
    minutes = prep_time % 60
    results = ""
    results += "#{hours} hours and " if hours > 0
    results += "#{minutes} minutes" if minutes > 0
    results
  end
end
