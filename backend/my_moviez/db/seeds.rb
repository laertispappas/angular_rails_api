# TODO Poor implementation change to lib/migrations/dataset.rb
CONTEXT_CONDITIONS = {
  time: ['morning', 'afternoon', 'evening', 'night'],
  daytype: ['workday', 'weekend', 'holiday'],
  season: ['spring', 'summer', 'autumn', 'winter'],
  location: ['home', 'public place', 'friend house'],
  weather: ['sunny', 'clear', 'rainy', 'stormy', 'snowy', 'cloudy'],
  social: ['alone', 'my partner', 'friends', 'colleagues', 'parents', 'public', 'my family'],
  endEmo: ['sad', 'happy', 'scared', 'surprised', 'angry', 'disgusted', 'neutral'],
  mood: ['positive', 'neutral', 'negative'],
  physical: ['healthy', 'ill'],
  decision: ['user decoded which movie to watch', 'user was given a movie to watch'],
  interaction: ['first interaction with a movie', 'n-th interaction with a movie']
}


# Persist Context Variables in DB
CONTEXT_CONDITIONS.each do |context, conditions|
  context = Context.find_or_create_by!(name: context)
  conditions.each do |cond_name|
    context.conditions.find_or_create_by!(name: cond_name)
  end
end


# Parse LDOS-CoMoData and persist
require 'csv'
dataset_dir = Rails.root.join('db', 'dataset')

# Load Movies
# movies = [{id: 1, title: 2}, {}, {}, {}, {}]
# movies = {
#   "1" => {
#     title: 'some',
#     director: 'aaa'
#   }
# }
movies = {}
movie_file = dataset_dir.join('movie_titles.csv')
CSV.foreach(movie_file, headers: false) do |row|
  movies[row[0]] = Hash.new({})
  movies[row[0]][:title] = row[1]
end

# Movie Data / Movie Metadata
fields_meta = {}
movies_meta = {}

movie_meta_data_fields = dataset_dir.join('movie_meta_data_fields.csv')
CSV.foreach(movie_meta_data_fields, headers: true) do |row|
  fields_meta[row['Id']] = row['Value']
end

movie_data = dataset_dir.join('movie_data.csv')
CSV.foreach(movie_data, headers: true) do |row|
  item_id = row['ItemId']
  field = fields_meta[row['FieldId']]
  value = row['Value']
  movies[item_id][field.downcase.to_sym] = value
end
# Movies data structure (After ratings are applied below)
# {
#   "1" => { 
#           "title" =>"CENTURION",
#           "Director"=>"Neil Marshall",
#           "Country"=>"United Kingdom",
#           "Language"=>"English",
#           "Year"=>"2010",
#           "Genre1"=>"Action",
#           "Genre2"=>"Adventure",
#           "Genre3"=>"History",
#           "Actor1"=>"Dominic West",
#           "Actor2"=>"Michael Fassbender",
#           "Actor3"=>"Olga Kurylenko",
#           "Budget"=>"10000000",
#           "ratings" => [
#             "user_id" => 1,
#             "rating" => "4",
#             "time" => 1,
#             "season" => "2",
#             ....
#           ]
# }

# User data structure
# {
#   "1" => {
#     "age" => "12",
#     "sex" => 1,
#     "city" => "12", // ??? No value info
#     "country" => "3"  // ??? No value info
#   }
# }

# Create movies - and ratings
# Before creating ratings make sure no previous one exist
# So we delete all items ratings if some found
Rating.where(id: movies.keys).destroy_all

ratings_file = dataset_dir.join('ratings.csv')
persisted_movie_id_mappings = {}
persisted_user_id_mappings = {}
counter = 1
CSV.foreach(ratings_file, headers: true) do |row|
  item_id = row['itemID']
  user_id = row['userID']
  score = row['rating']
  age = row['age'].to_i
  sex = row['sex'] == '1' ? 'male' : 'female'
  # Dataset City ID
  city = row['city']

  movie = Movie.find_or_create_by!(title: movies[item_id][:title], year: movies[item_id][:year])
  movie.director = movies[item_id][:director]
  movie.country = movies[item_id][:country]
  movie.language = movies[item_id][:language]
  movie.language = movies[item_id][:budget]
  movie.save!

  movie.genres.find_or_create_by!(name: movies[item_id][:genre1])
  movie.genres.find_or_create_by!(name: movies[item_id][:genre2])
  movie.genres.find_or_create_by!(name: movies[item_id][:genre3])
  movie.actors.find_or_create_by!(name: movies[item_id][:actor1])
  movie.actors.find_or_create_by!(name: movies[item_id][:actor2])
  movie.actors.find_or_create_by!(name: movies[item_id][:actor3])

  user = User.find_or_initialize_by(email: "user-#{user_id}@allpolls.com")
  user.city_id = city
  user.password = 'pappaspappas'
  user.password_confirmation = 'pappaspappas'
  user.birthday = Date.new(Time.now.year - age.to_i) if age.to_i != -1
  user.gender = sex
  user.save!

  rating = Rating.new(movie: movie, user: user, score: score)
  CONTEXT_CONDITIONS.each do |type, conditions|
    ctx_id = row[type.to_s].to_i
    ctx_condition = nil
    if ctx_id != -1
      ctx_condition = conditions[ctx_id - 1]
    else
      ctx_condition = 'unknown'
    end
    context = Context.find_or_create_by!(name: type)
    condition = context.conditions.find_or_create_by!(name: ctx_condition)

    rating.rating_conditions.build(condition: condition)
  end
  rating.save!

  puts "#{counter += 1}/#{movies.size}"
end
