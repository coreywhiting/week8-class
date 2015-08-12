class Director < ActiveRecord::Base

  has_many :movies, dependent: :nullify

  # General form:
  # has_many :movies, class_name: 'Movie', foriegn_key: 'director_id'

  # def movies
  #   Movie.where(director_id: self.id).order('title')
  # end

end
