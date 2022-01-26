require 'rails_helper'

shared_examples_for 'a name format' do
  let(:model) { described_class }

  describe '#format_name' do
    it 'downcases the name' do
      expect(model.new(name: 'Category').format_name).to eq('category')
    end

    it 'replaces spaces with dashes' do
      expect(model.new(name: 'New Technology').format_name).to eq('new-technology')
    end

    it 'returns nil if name is nil' do
      expect(model.new(name: nil).format_name).to be_nil
    end
  end
end
