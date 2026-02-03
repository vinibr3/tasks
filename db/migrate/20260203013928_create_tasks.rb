class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.references :task, null: true, foreign_key: { to_table: :tasks }

      t.timestamps
    end
  end
end
