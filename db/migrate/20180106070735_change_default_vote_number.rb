class ChangeDefaultVoteNumber < ActiveRecord::Migration[2]
  def change
    change_column_default :licenceplates, :upvote, 0
    change_column_default :licenceplates, :downvote, 0
  end
end
