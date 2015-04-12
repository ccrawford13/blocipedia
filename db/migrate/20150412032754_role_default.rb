class RoleDefault < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, defualt: 'standard'
  end
end
