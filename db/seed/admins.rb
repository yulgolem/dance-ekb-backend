class AdminGenerator
  def self.generate!(count)
    count.times do
      new.create!
    end
  end

  def initialize(email = nil, password = nil)
    @email    = email    || Faker::Internet.safe_email
    @password = password || "123456789"
  end

  def create!
    @admin = Admin.create!(
      first_name: Faker::Name.male_first_name,
      last_name: Faker::Name.last_name,
      email: @email,
      password: @password,
      password_confirmation: @password,
      roles: ["admin"]
    )
  end
end

AdminGenerator.new("admin@dev.dance-ekb", "12345678").create!
AdminGenerator.generate! 3

puts "-------------------------------"
puts "  email: admin@dev.dance-ekb   "
puts "  pass:  12345678              "
puts "-------------------------------"
