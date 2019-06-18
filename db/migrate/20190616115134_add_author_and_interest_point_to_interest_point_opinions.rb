class AddAuthorAndInterestPointToInterestPointOpinions < ActiveRecord::Migration[5.2]
  def change
    add_reference :interest_point_opinions, :user, foreign_key: true
    add_reference :interest_point_opinions, :interest_point, foreign_key: true
  end
end
