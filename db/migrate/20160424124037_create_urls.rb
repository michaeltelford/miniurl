class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :internal
      t.string :external

      t.timestamps null: false
    end
  end
end
