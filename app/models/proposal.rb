class Proposal < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :messages
  has_many :users, through: :messages

  def find_project_name(project_id)
    Project.find(project_id).name
  end
end
