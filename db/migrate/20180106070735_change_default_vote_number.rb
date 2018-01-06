class ChangeDefaultVoteNumber < ActiveRecord::Migration[5.1]
  def change
    change_column_default :licenceplates, :upvote, 0
    change_column_default :licenceplates, :downvote, 0
  end
end
