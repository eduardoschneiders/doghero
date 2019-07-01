require 'rails_helper'

RSpec.describe Client, type: :model do
	let(:client) { create(:client)}

  it 'should start with no dogs' do
  	expect(client.dogs.to_a).to eql([])
  end

  it 'should be able to add dogs' do
  	client.dogs << build(:dog, name: 'Dog 1')
		client.dogs << build(:dog, name: 'Dog 2')
		client.save

  	expect(client.dogs.map(&:name)).to eql(['Dog 1', 'Dog 2'])
  end
end
