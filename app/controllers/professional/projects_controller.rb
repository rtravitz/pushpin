class Professional::ProjectsController < ApplicationController
  before_action :set_s3_direct_post, only: [:show]

  def index
    @projects = current_user.possible_projects_professional
  end

  def show
    @project = Project.find_by(slug: params[:project])
    @professional = current_user
    @rating = Rating.new 
    @message = Message.new
    @proposal = @project.proposals.assigned
  end

  private

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
