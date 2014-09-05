class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.string :name
      t.datetime :created_on
      t.references :user, index: true
    end
  end
end
