class AddAasmStateToItems < ActiveRecord::Migration
  def change
    add_column :items, :aasm_state, :string, null: false
    add_column :items, :published_at, :timestamp
  end
end
