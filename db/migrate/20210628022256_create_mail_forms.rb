class CreateMailForms < ActiveRecord::Migration[6.1]
  def change
    create_table :mail_forms do |t|
      t.string :name
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
