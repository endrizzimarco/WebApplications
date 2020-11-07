json.extract! movie, :id, :title, :rating, :genres, :casts, :synopsis, :runtime, :release_date, :img_url, :created_at, :updated_at
json.url movie_url(movie, format: :json)
