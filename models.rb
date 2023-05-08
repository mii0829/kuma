class User < ActiveRecord::Base
    has_many :comments
    has_many :grades
    has_many :user_questions
    has_many :questions, through: :user_questions
    
    has_secure_password
    validates :name,
        presence: true,
        format: { with: /\A\w+\z/ }
    validates :password,
        length: { in: 5..10 }
end

class Subject < ActiveRecord::Base
    belongs_to :genre
    has_many :questions
end

class Genre < ActiveRecord::Base
    has_many :subjects
end

class Question < ActiveRecord::Base
    has_many :comments
    belongs_to :subject
    has_many :question_tags
    has_many :tags, through: :question_tags
    has_many :user_questions
    has_many :users, through: :user_questions
end

class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :question
end

class Tag < ActiveRecord::Base
    has_many :question_tags
    has_many :questions, through: :question_tags
end

class QuestionTag < ActiveRecord::Base
    belongs_to :tag
    belongs_to :question
end

class UserQuestion < ActiveRecord::Base
    belongs_to :user
    belongs_to :question
end

class Grade < ActiveRecord::Base
    belongs_to :user
end
