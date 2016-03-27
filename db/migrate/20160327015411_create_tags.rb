class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :entity, index: true

      t.timestamps null: false
    end
    add_foreign_key :tags, :entities
  end
end
