class CreateTagItems < ActiveRecord::Migration
  def change
    create_table :tag_items do |t|
      t.references :item, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end