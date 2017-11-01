#
# Cookbook:: jenkins_configuration
# Recipe:: env_config
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

# Update Apt for installation of CIFS
apt_update 'Updates Apt' do
  action :update
end

# Install CIFS for mounts
package 'Install CIFS' do
  package_name 'cifs-utils'
  action :install
end

# Create the configuration direction
directory 'Create configuration directory' do
  path '/mnt/config'
  action :create
  not_if { ::Dir.exist?('/mnt/config') }
end

# Mount the directory on fileshare that houses all of the configurations
mount 'Mount configuration share for containers' do
  device '//storage.solsys.com/config'
  fstype 'cifs'
  options 'rw,username=media_user,password=test'
  mount_point '/mnt/config'
  action [:mount]
end

# Create the direction for the Jenkins configuration
directory 'Create configuration directory for Jenkins' do
  path '/mnt/config/jenkins'
  action :create
  not_if { ::Dir.exist?('/mnt/config/jenkins') }
end

# Create the direction for the chef configuration
directory 'Create configuration directory for chef' do
  path '/mnt/config/chef'
  action :create
  not_if { ::Dir.exist?('/mnt/config/chef') }
end