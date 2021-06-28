class AddApplicationToMailForms < ActiveRecord::Migration[6.1]
  def change
    add_reference :mail_forms, :application, null: false, foreign_key: true
  end
end
