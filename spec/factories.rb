FactoryGirl.define do

  factory :survivor do |s|
    name Faker::Name.name
    age 18
    gender "m"
  end

  factory :last_location do |l|
    latitude 15.465465864
    latitude 15.465465999
    l.association :survivor
  end

end
