# spec/integrations/api/posts_spec.rb

require 'swagger_helper'

describe 'Posts API' do
  path '/api/users/{user_id}/posts' do
    get 'Retrieves all posts for a user' do
      tags 'Posts'
      parameter name: :user_id, in: :path, type: :integer

      response '200', 'successful' do
        run_test!
      end
    end
  end
end

path '/api/users/{user_id}/posts/{post_id}/comments' do
    get 'Retrieves all comments for a user\'s post' do
      tags 'Comments'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer

      response '200', 'successful' do
        run_test!
      end
    end

    post 'Adds a comment to a post' do
      tags 'Comments'
      parameter name: :user_id, in: :path, type: :integer
      parameter name: :post_id, in: :path, type: :integer
      parameter name: :comment, in: :body, schema: { type: :object, properties: { content: { type: :string } } }

      response '201', 'successful' do
        run_test!
      end
    end
  end
