class AddAuthorAndReceptorToMessages < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :author, foreign_key: { to_table: :users}
    add_reference :messages, :receptor, foreign_key: { to_table: :users}
  end
end
