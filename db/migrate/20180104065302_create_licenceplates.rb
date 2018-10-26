# frozen_string_literal: true

class CreateLicenceplates < ActiveRecord::Migration[5.1]
  def change
    create_table :licenceplates do |t|
      t.string :plate
      t.string :province
      t.integer :upvote
      t.integer :downvote

      t.timestamps
    end
  end
end
