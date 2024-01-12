# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    describe '#update_post_counter' do
      it 'updates the user posts_counter attribute' do
        user = User.create(name: 'Sintheys')
        post = Post.create(title: 'Good morning', author: user)

        post.update_post_counter

        expect(user.reload.posts_counter).to eq(0)
      end
    end
  end
end
