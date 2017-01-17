module AuditedSpecHelpers

  def create_user(attrs = {})
    Models::ActiveRecord::User.create({name: 'Brandon', username: 'brandon', password: 'password', favourite_device: 'Android Phone'}.merge(attrs))
  end

  def build_user(attrs = {})
    Models::ActiveRecord::User.new({name: 'darth', username: 'darth', password: 'noooooooo'}.merge(attrs))
  end

  def create_parent(attrs = {})
    Models::ActiveRecord::Parent.create({name: 'Test Parent'}.merge(attrs))
  end

  def create_versions(n = 2)
    Models::ActiveRecord::User.create(name: 'Foobar 1').tap do |u|
      (n - 1).times do |i|
        u.update_attribute :name, "Foobar #{i + 2}"
      end
      u.reload
    end
  end

end
