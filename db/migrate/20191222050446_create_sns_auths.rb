class CreateSnsAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :sns_auths do |t|
      t.string :provider, null: false
      t.string :uid,      null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
