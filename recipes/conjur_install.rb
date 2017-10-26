#
# Cookbook:: jenkins_configuration
# Recipe:: conjur_install
#
# Copyright:: 2017,  Darren Khan
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

images = ['cyberark/conjur', 'postgres', 'conjurinc/cli5']

images.each do |image|
  docker_image image do
    action :pull_if_missing
  end
end

docker_container 'database' do
  container_name 'database'
  repo 'postgres'
  network_mode 'pipeline'
  action :run
end

execute 'Getting key for conjur' do
  command 'docker run --rm cyberark/conjur data-key generate > key.file'
  action :run
end

key = File.read(key.file)

docker_container 'conjur' do
  container_name 'conjur-master'
  repo 'cyberark/conjur'
  network_mode 'pipeline'
  command 'server'
  port '3000:3000'
  env ['DATABASE_URL=postgres://postgres@database/postgres', "CONJUR_DATA_KEY=#{key}"]
  action :run
end
