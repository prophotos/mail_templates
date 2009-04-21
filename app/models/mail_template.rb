# == Schema Information
# Schema version: 20090204113447
#
# Table name: mail_templates
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  display_name :string(255)
#  subject      :string(255)
#  body         :text
#  created_at   :datetime
#  updated_at   :datetime
#

class MailTemplate < ActiveRecord::Base
  validates_presence_of :name, :display_name
  validates_uniqueness_of :name

  def to_param
    name
  end
end
