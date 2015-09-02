FactoryGirl.define do
  factory :admin do
    email { Faker::Internet.email }
    password 'qwerty12'
    password_confirmation {|u| u.password}
  end

end
