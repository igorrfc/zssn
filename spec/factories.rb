FactoryGirl.define do

  factory :survivor do |s|
    name Faker::Name.name
    age 18
    gender "m"
  end

  factory :last_location do |l|
    latitude 15.465465864
    longitude 15.465465999
    l.association :survivor
  end

  factory :inventory do |i|
    i.association :survivor
  end

  factory :resource do |r|
    resource_type_id Faker::Number.between(1, 4)
    r.association :inventory
  end

  factory :infected_report do |i|
    survivor_id Faker::Number.between(1, 10)
  end

end
