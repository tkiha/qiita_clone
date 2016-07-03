class CreateFollowTags < ActiveRecord::Migration
  def change
    create_table :follow_tags do |t|
      t.references :user, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
