class AddTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :word, index: true
      t.string :source, index: true
      t.float :coefficient
    end

    add_index :tokens, [:word, :source], unique: true
  end
end
