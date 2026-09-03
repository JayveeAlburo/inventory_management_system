AdminUser.find_or_create_by!(email: 'inventoryadmin@gmail.com') do |user|
  user.password = 'admin123'
  user.password_confirmation = 'admin123'
end