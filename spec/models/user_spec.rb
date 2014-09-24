require 'rails_helper'

RSpec.describe User do
  describe 'validation' do
    context 'email' do
      it 'must be present' do
        subject.valid?
        expect(subject.errors[:email]).to include("can't be blank")
      end

      it 'must be unique' do
        Fabricate(:user, email: 'bobby@example.com')
        subject.email = 'bobby@example.com'
        subject.valid?
        expect(subject.errors[:email]).to include("has already been taken")
      end

      it 'is downcased before validating' do
        subject.email = 'Bobby@example.com'
        subject.valid?
        expect(subject.email).to eql('bobby@example.com')
      end

      context 'must be a valid email address' do
        let(:user) { Fabricate.build(:user) }

        it "needs an @" do
          user.email = 'bobby'
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("is invalid")
        end

        it "needs a domain" do
          user.email = 'bobby@'
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("is invalid")
        end

        it "needs a TLD" do
          user.email = 'bobby@example'
          expect(user).to be_invalid
          expect(user.errors[:email]).to include("is invalid")
        end

        it "is valid with all required parts present" do
          user.email = 'bobby@example.com'
          expect(user).to be_valid
        end
      end
    end

    context 'password' do
      it 'must be at least 3 characters long' do
        subject.valid?
        expect(subject.errors[:password]).to include("is too short (minimum is 3 characters)")
      end

      it 'must be confirmed' do
        subject.valid?
        expect(subject.errors[:password_confirmation]).to include("can't be blank")
      end

      it 'must match confirmation' do
        subject.password = 'foo'
        subject.password_confirmation = 'bar'
        subject.valid?
        expect(subject.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end
end
