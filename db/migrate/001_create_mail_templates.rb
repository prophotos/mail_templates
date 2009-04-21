class CreateMailTemplates < ActiveRecord::Migration
  def self.up
    create_table :mail_templates do |t|
      t.string :name, :null => false
      t.string :display_name
      t.string :subject
      t.text :body
      t.timestamps
    end
    add_index :mail_templates, :name, :unique => true
  end

  def self.down
    drop_table :mail_templates
  end
end
