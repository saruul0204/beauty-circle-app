# frozen_string_literal: true

describe 'dashboard/pages/home.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'renders dashboard-home' do
    render
    expect(rendered).to include('Keep track of your business progress')
  end
end
