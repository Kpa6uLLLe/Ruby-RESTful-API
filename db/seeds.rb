
50.times do


  patient = Patient.create!({
    initials: Faker::FunnyName.three_word_name,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    birthdate: Faker::Date.between(from: '1900-01-01', to: '2023-01-01')
  })
  patient.save!
  request = Request.create!({
    patient: patient,
    requestBody: Faker::Lorem.sentence(word_count: 25),
    creationDate: Faker::Date.between(from: '2022-01-01', to: '2023-01-01')
  })
  request.save
  recommendation = Recommendation.create!({
    request: request,
    responseBody: Faker::Lorem.sentence(word_count: 25)
  })
end
