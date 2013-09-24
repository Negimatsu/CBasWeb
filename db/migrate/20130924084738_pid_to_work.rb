class PidToWork < ActiveRecord::Migration
  def change
    add_column :works , :pid , :string
  end
end
