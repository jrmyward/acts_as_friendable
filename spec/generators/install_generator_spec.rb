require 'spec_helper'

# Generators are NOT automatically loaded by Rails
require 'generators/acts_as_friendable/install/install_generator'

describe ActsAsFriendable::Generators::InstallGenerator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path("../../../tmp", __FILE__)

  before do
    prepare_destination
    Rails::Generators.options[:rails][:orm] = :active_record
  end

  describe 'no arguments' do
    before { run_generator  }

    describe 'db/migrate/acts_as_friendable.rb' do
      subject { file('db/migrate/create_acts_as_friendable_friendships.rb') }
      it { should be_a_migration }
    end
  end
end