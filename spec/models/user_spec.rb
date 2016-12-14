require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    context "username" do
      it "is invalid without a username" do
        user = User.new(name: "al", email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "can not be too long" do
        username = "a" * 51
        user = User.new(name: "al", username: username, email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end
    end

    context "password" do
      it "is invalid without a password" do
        user = User.new(name: "al", username: "Al", email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000")

        expect(user).to be_invalid
      end

      it "password cannot be too short" do
        user = User.new(name: "al", email: "al@al.com", password: "pass", password_confirmation: "pass")

        expect(user).to be_invalid
      end
    end

    context "email" do
      it "is invalid without an email" do
        user = User.new(name: "al", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "email address should be unique" do
        User.create(name: "al", email: "al@al.com", password: "password", password_confirmation: "password")
        user = User.create(name: "ali", email: "al@al.com", password: "password1", password_confirmation: "password1")

        expect(user).to be_invalid
      end

      it "email cannot be too long" do
        email = "a" * 244 + "@example.com"
        user = User.new(name: "al", email: email, password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "saves emails as lower-case" do
        email = "Foo@eXamPlE.cOm"
        user = User.create(name: "al", username: "Al", email: email, password: "password", password_confirmation: "password")
        expect(user.email).to eq("foo@example.com")
      end

      it "accepts valid email addresses" do
        user = User.new(name: "al", username: "Al", email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
          first.last@foo.jp alice+bob@baz.cn]

          valid_addresses.each do |valid_address|
            user.email = valid_address
            expect(user).to be_valid
          end
        end

        it "rejects invalid email addresses" do
          user = User.new(name: "al", username: "Al", email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")
          invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
            foo@bar_baz.com foo@bar+baz.com]

            invalid_addresses.each do |invalid_address|
              user.email = invalid_address
              expect(user).to be_invalid
            end
        end
    end

    context "validating other attibutes" do
      it "is invalid without name" do
        user = User.new(username: "Al", email: "al@al.com", status: "active", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "is invalid without status" do
        user = User.new(name: "al", username: "Al", email: "al@al.com", location: "Denver", phone: "303-333-0000", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "is invalid without location" do
        user = User.new(name: "al", username: "Al", email: "al@al.com", status: "active", phone: "303-333-0000", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

      it "is invalid without a phone number" do
        user = User.new(name: "al", username: "Al", email: "al@al.com", status: "active", location: "Denver", password: "password", password_confirmation: "password")

        expect(user).to be_invalid
      end

    end
  end

  describe "relationships" do
    let(:user) { User.new(name: "al", email: "al@al.com", password: "password", password_confirmation: "password") }

    it "has many user_roles" do
      expect(user).to respond_to(:user_roles)
    end

    it "has many roles" do
      expect(user).to respond_to(:roles)
    end

    it "has many ratings" do
      expect(user).to respond_to(:ratings)
    end

    it "has many givers" do
      expect(user).to respond_to(:givers)
    end
  end
end
