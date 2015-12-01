class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
end
