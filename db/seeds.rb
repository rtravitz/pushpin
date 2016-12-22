class Seed

  def self.start
    seed = Seed.new
    seed.create_users
    seed.create_roles
    seed.create_user_roles_professional
    seed.create_user_roles_requester
    seed.create_projects
    seed.create_proposals
    seed.create_skills
    seed.create_user_skills
    seed.create_project_skills
    seed.create_ratings
  end

  def create_users
    1000.times do |i|
      user = User.create!(
                          name: Faker::Name.name,
                          username: "#{Faker::Internet.user_name}#{i}",
                          location: Faker::Address.city,
                          email: Faker::Internet.email,
                          phone: Faker::PhoneNumber.phone_number,
                          status: "active",
                          password: Faker::Internet.password,
                          image: "/assets/default-user-icon.png"
                          )
      puts "User #{i}: #{user.name} created."
    end
  end

  def create_roles
    role = Role.create!(title: "requester")
    role2 = Role.create!(title: "professional")
    role3 = Role.create!(title: "admin")
    role4 = Role.create!(title: "guest")
    puts "4 roles created"
  end

  def create_user_roles_professional
    role = Role.find_by(title: "professional")
    400.times do |i|
      user = User.find(i+1)
      user_role = UserRole.create!(
                                    user_id: user.id,
                                    role_id: role.id
                          )
      puts "UserRole #{i}: #{user_role.user_id} user created as a #{role.title} role."
    end
  end

  def create_user_roles_requester
    role = Role.find_by(title: "requester")
    600.times do |i|
      user = User.find(40+i)
      user_role = UserRole.create!(
                                    user_id: user.id,
                                    role_id: role.id
                          )
      puts "UserRole #{i}: #{user_role.user_id} user created as a #{role.title} role."
    end
  end

  def create_projects
    10.times do |i|
      user = User.find(Random.new.rand(1..10))
      project = Project.create!(
                                name: Faker::Company.catch_phrase,
                                user_id: user.id,
                                status: "unassigned"
                                )
      puts "Project #{i}: project created for user #{project.user_id} as #{project.name}"
    end
  end

  def create_proposals
    10.times do |i|
      user = User.find(Random.new.rand(1..10))
      project = Project.find(Random.new.rand(1..10))
      proposal = Proposal.create!(
                                  project_id: project.id,
                                  user_id: user.id
                                )

      puts "Proposal #{i}: proposal created for user #{proposal.user_id} and #{proposal.project_id} project"
    end
  end

  def create_skills
    10.times do |i|
      skill = Skill.create!(name: "#{Faker::Company.profession}#{i}")
      puts "Skill #{i}: #{skill.name} created."
    end
  end

  def create_user_skills
    10.times do |i|
      user = User.find(Random.new.rand(1..10))
      skill = Skill.find(Random.new.rand(1..10))
      user_skill = UserSkill.create!(
                                      user_id: user.id,
                                      skill_id: skill.id
                          )
      puts "UserSkill #{i}: #{user_skill.user_id} created with #{user_skill.skill_id} skill."
    end
  end

  def create_project_skills
    10.times do |i|
      skill = Skill.find(Random.new.rand(1..10))
      project = Project.find(Random.new.rand(1..10))
      project_skill = ProjectSkill.create!(
                                          project_id: project.id,
                                          skill_id: skill.id
                                          )

      puts "Project Skill #{i}: project skill created for skill #{project_skill.skill_id} and #{project_skill.project_id} project"
    end
  end

  def create_ratings
    10.times do |i|
      user = User.find(Random.new.rand(1..400))
      giver = User.find(Random.new.rand(401..1000))
      rating = Rating.create!(
                                score: Faker::Number.between(1, 5),
                                comment: Faker::Lorem.sentence,
                                user_id: user.id,
                                giver_id: giver.id,
                                )
      puts "Rating #{i}: created for #{rating.user_id} with score #{rating.score}, given by #{rating.giver_id}"
    end
  end

end

Seed.start
