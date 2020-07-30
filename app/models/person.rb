class Person < ActiveRecord::Base
    CONSIDERED_ATTRIBUTES = ['email', 'home_phone_number', 'mobile_phone_number', 'address'].freeze
    UNCONSIDERED_ATTRIBUTES = ['firstname', 'lastname'].freeze
    has_paper_trail
    require 'csv'
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            person = Person.find_or_create_by(reference: row['reference'])
            CONSIDERED_ATTRIBUTES.each do |key|
                # retrieve previous attributes from instance and add current one, reify gives the object instead of the version snapshot 
                versionnedAttributes = person.versions.map do |version|
                    unless version.reify.nil?
                       return version.reify[key]
                    end
                end
                unless (versionnedAttributes << person[key]).include? row[key]
                    person.update_attribute(key, row[key])
                end
            end
            UNCONSIDERED_ATTRIBUTES.each do |key|
                person.update_attribute(key, row[key])
            end
        end
    end
end
