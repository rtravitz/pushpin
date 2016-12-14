
class Seed

  def self.start
    seed = Seed.new
    seed.create_users
    seed.create_projects
    # seed.create_orders
  end

  def create_users
    10.times do |i|
      user = User.create!(
                          name: Faker::Name.name,
                          username: Faker::Internet.user_name,
                          location: Faker::Address.city,
                          email: Faker::Internet.email,
                          phone: Faker::PhoneNumber.phone_number,
                          status: "active",
                          password: Faker::Internet.password
                          )
      puts "User #{i}: #{user.name} created."
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
      end
    puts "Project #{i}: project created for user #{project.user_id} with #{project.name}"
  end

  def create_proposals
    10.times do |i|
      user = User.find(Random.new.rand(1..10))
      proposal = Proposal.create!(
                                name: Faker::Company.catch_phrase,
                                user_id: user.id,
                                status: "unassigned"
                                )
      end
    puts "Project #{i}: project created for user #{project.user_id} with #{project.name}"
  end

  create_table "proposals", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_proposals_on_project_id", using: :btree
    t.index ["user_id"], name: "index_proposals_on_user_id", using: :btree
  end

  def create_orders
    100.times do |i|
      user = User.find(Random.new.rand(1..10))
      order = Order.create!(
        amount: Faker::Commerce.price,
        user_id: user.id
        )
        add_items(order)
      puts "Order #{i}: order created for user #{order.user_id} with #{order.items.count} items."
    end
  end

  private
    def add_items(order)
      random_num = rand(1..10)
      random_num.times do |i|
        item = Item.find(Random.new.rand(1..100))
        order.items << item
      end
    end
end
