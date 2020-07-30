require 'rails_helper'

RSpec.describe Building, type: :request do
  describe 'Building Controller' do

    it 'should import building data via csv file' do
      file = File.new(File.join(Rails.root, 'buildings.csv'))
      Building.import(file)
      building = Building.find_by_reference('1')
      expect(building.address).to eq('10 Rue La bruyère')
    end

    it 'should update building' do
      file = File.new(File.join(Rails.root, 'buildings.csv'))
      Building.import(file)
      building = Building.find_by_reference('1')
      patch "/buildings?reference=1", building: {
          'manager_name': 'Jean Bon'
      }
      expect(response.status).to eq 200
      expect { building.reload }.to change { building.manager_name }
        .from('Martin Faure')
        .to('Jean Bon')
    end

    it 'should not update bulding manager name with a previously existing data via csv import' do
      file = File.new(File.join(Rails.root, 'buildings.csv'))
      Building.import(file)
      building = Building.find_by_reference('1')
      patch "/buildings?reference=1", building: {
          'manager_name': 'Jean Bon'
      }
      expect(response.status).to eq 200
      expect { building.reload }.to change { building.manager_name }
        .from('Martin Faure')
        .to('Jean Bon')
      Building.import(file)
      expect(building.manager_name).to eq('Jean Bon')
    end

  end
end
