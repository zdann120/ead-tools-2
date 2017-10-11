class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :actionable, polymorphic: true, index: true
      t.string :action, null: false
      t.references :user, foreign_key: true, null: true
      t.text :comment, null: true
      t.uuid :uuid, null: false

      t.timestamps
    end
  end
end
