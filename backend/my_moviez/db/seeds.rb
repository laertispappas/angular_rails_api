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
