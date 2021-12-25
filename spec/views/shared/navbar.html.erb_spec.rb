# frozen_string_literal: true

require 'rails_helper'

describe 'shared/navbar' do
  # before { I18n.available_locales = %i[en mk] }

  it 'displays navbar links' do
    # assign(, [])

    render partial: 'shared/navbar'

    expect(rendered).to include('Browse salons', 'About', 'Contact us', 'Sign in', 'Sign up')
  end
end
