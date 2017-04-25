class DropPostsubsTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :postsubs
  end
end
