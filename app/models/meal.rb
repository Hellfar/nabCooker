class Meal < ApplicationRecord
  def favorite? user
    unless user
      return nil
    end

    user.meal_id == self.id
  end
end
