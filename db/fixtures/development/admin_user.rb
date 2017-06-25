%w[admin].map do |name|
  email = "#{name}@example.com"
  User.find_by(email: email) || User.create(email: email, password: "admin")
end
