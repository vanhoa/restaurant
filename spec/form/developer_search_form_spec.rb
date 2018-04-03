# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeveloperSearchForm do
  describe '#search' do
    before do
      @developer = create(:developer, email: 'hoa@gmail.com')
      create(:developer, email: 'hoa1@gmail.com')
      @language = create(:language, code: 'en')
      @programming_language = create(:programming_language, name: 'Ruby')
      create(:developer_language, developer_id: @developer.id, language_id: @language.id)
      create(:developer_programming_language, developer_id: @developer.id, programming_language_id: @programming_language.id)
    end

    context 'with no params' do
      it 'returns all developer' do
        form = DeveloperSearchForm.new({})
        expect(form.search.size).to eq(2)
      end
    end

    context 'with have language' do
      it 'returns one dev' do
        from = DeveloperSearchForm.new(language_id: @language.id)
        expect(from.search.size).to eq(1)
      end
    end

    context 'with have programming_language' do
      it 'returns one dev' do
        from = DeveloperSearchForm.new(programming_language_id: @programming_language.id)
        expect(from.search.size).to eq(1)
      end
    end

    context 'with have programming_language and language' do
      it 'return one dev' do
        from = DeveloperSearchForm.new(language_id: @language.id, programming_language_id: @programming_language.id)
        expect(from.search.size).to eq(1)
      end
    end

    context 'no existing language' do
      it 'return no dev' do
        from = DeveloperSearchForm.new(language_id: 10, programming_language_id: @programming_language.id)
        expect(from.search.size).to eq(0)
      end
    end

    context 'no existing programming_language' do
      it 'return no dev' do
        from = DeveloperSearchForm.new(language_id: @language.id, programming_language_id: 0)
        expect(from.search.size).to eq(0)
      end
    end
  end
end