class Movie < ActiveRecord::Base
    def self.ratings()
        val=Movie.all.distinct.pluck('rating')
        return val
    end
end
