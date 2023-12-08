class SwipesJob < ApplicationJob
  queue_as :default

  def perform
    pp "Generating Swipes"

    User.find_each do |user|

      eligible_users = User.where(weight_class_id: user.weight_class_id).where.not(id: user.id)

      eligible_users.find_each do |other_user|
        if rand < 0.25
          Swipe.create!(
            swiper_id: user.id,
            swiped_id: other_user.id,
            like: true
            # like: [true, false].sample 
          )
        end
      end
    end

    pp "There are now #{Swipe.count} swipes"
  end
end
