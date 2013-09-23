class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :title
      t.text :description
      t.string :status_work
      t.datetime :finish_date
      t.datetime :upload_date
      t.boolean :is_bacteria , :default=>true
      t.string :filename
      t.belongs_to :user

      t.timestamps
    end
  end
end
