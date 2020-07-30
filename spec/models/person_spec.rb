require 'rails_helper'

RSpec.describe Person, type: :request do
  describe 'Person Controller' do

    it 'should import person data via csv file' do
      file = File.new(File.join(Rails.root, 'persons.csv'))
      Person.import(file)
      person = Person.find_by_reference('1')
      expect(person.email).to eq('h.trodbar@gmail.com')
    end

    it 'should update person' do
      file = File.new(File.join(Rails.root, 'persons.csv'))
      Person.import(file)
      person = Person.find_by_reference('1')
      patch "/persons?reference=1", person: {
          'email': 'Tupac75@gmail.com'
      }
      expect(response.status).to eq 200
      expect { person.reload }.to change { person.email }
        .from('h.trodbar@gmail.com')
        .to('Tupac75@gmail.com')
    end

    it 'should not update person email with a previously existing data via csv import' do
      file = File.new(File.join(Rails.root, 'persons.csv'))
      Person.import(file)
      person = Person.find_by_reference('1')
      patch "/persons?reference=1", person: {
          'email': 'albator75@gmail.com'
      }
      expect(response.status).to eq 200
      expect { person.reload }.to change { person.email }
        .from('h.trodbar@gmail.com')
        .to('albator75@gmail.com')
      Person.import(file)
      expect(person.email).to eq('albator75@gmail.com')
    end

  end
end
