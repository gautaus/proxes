require 'proxes/db'
require 'proxes/models/role'
require 'proxes/models/permission'

::ProxES::Container.seeders.each do |seeder|
  seeder.call
end