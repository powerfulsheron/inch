class Building < ActiveRecord::Base
    CONSIDERED_ATTRIBUTES = ['manager_name'].freeze
    UNCONSIDERED_ATTRIBUTES = ['address', 'zip_code','city','country'].freeze
    has_paper_trail
    require 'csv'
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
            building = Building.find_or_create_by(reference: row['reference'])
            CONSIDERED_ATTRIBUTES.each do |key|
                # retrieve previous attributes from instance and add current one, 'reify' gives the object instead of the version snapshot
                versionnedAttributes = building.versions.map do |version|
                    unless version.reify.nil?
                       return version.reify[key]
                    end
                end
                unless (versionnedAttributes << building[key]).include? row[key]
                    building.update_attribute(key, row[key])
                end
            end
            UNCONSIDERED_ATTRIBUTES.each do |key|
                building.update_attribute(key, row[key])
            end
        end
    end
end
