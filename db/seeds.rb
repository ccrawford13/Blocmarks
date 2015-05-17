require 'faker'

admin = User.new(
  first_name:                'admin',
  last_name:                 'istrator',
  email:                     'chad@example.com',
  password:                  'password',
  password_confirmation:     'password'
  )
admin.skip_confirmation!
admin.save!