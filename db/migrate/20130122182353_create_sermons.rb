class CreateSermons < ActiveRecord::Migration
  def change
    create_table :sermons do |t|
      t.string :name
      t.string :series
      t.string :preacher
      t.date :date
      t.integer :duration
      t.string :url

      t.timestamps
    end
  end
end
