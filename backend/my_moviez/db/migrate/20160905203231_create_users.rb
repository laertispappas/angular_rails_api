class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, uniq: true, index: true
      t.string :password_digest

      # Profile data. This could belong to a profile table instead
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birthday

      t.timestamps
    end
  end
end
