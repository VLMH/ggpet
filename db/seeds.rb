Pet.create([
  { name: 'Dog_1', species: 'dog', breed: 'labrador', age: 2, available_at: '2018-05-07' },
  { name: 'Dog_2', species: 'dog', breed: 'poodle', age: 3, available_at: '2018-05-08' },
  { name: 'Dog_3', species: 'dog', breed: 'spaniel', age: 4, available_at: '2018-05-09' },
  { name: 'Cat_1', species: 'cat', breed: 'abyssinians', age: 2, available_at: '2018-05-07' },
  { name: 'Cat_2', species: 'cat', breed: 'bobtails', age: 3, available_at: '2018-05-08' },
  { name: 'Cat_3', species: 'cat', breed: 'shorthair', age: 4, available_at: '2018-05-09' },
])

Customer.create([
  { name: 'Pet Lover' },
  { name: 'Dog Lover', preferences: { dog: {} } },
  { name: 'Cat Lover', preferences: { cat: {} } },
  { name: 'Dog n Cat Lover', preferences: { dog: {}, cat: {} } },
  { name: 'Labrador Lover', preferences: { dog: { breed: ['labrador'] } } },
  { name: 'Puppy Lover', preferences: { dog: { age_max: 1 } } },
])
