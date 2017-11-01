#
# Cookbook:: jenkins_configuration
# Recipe:: jenkins_install
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

docker_network 'pipeline' do
  action :create
end

docker_image 'jenkins' do
  repo 'captainfluffytoes/docker_jenkins'
  tag 'latest'
  action :pull_if_missing
end

docker_container 'jenkins-master' do
  container_name 'jenkins-master'
  repo 'captainfluffytoes/docker_jenkins'
  tag 'latest'
  network_mode 'pipeline'
  user 'root'
  volumes ['/mnt/config/jenkins:/var/jenkins_home', '/var/run/docker.sock:/var/run/docker.sock', '/mnt/config/chef:/chef']
  port '8080:8080'
  action :run
end
