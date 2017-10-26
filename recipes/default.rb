#
# Cookbook:: jenkins_configuration
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'docker_configuration::default'
include_recipe 'jenkins_configuration::env_config'
include_recipe 'jenkins_configuration::jenkins_install'
include_recipe 'jenkins_configuration::conjur_install'
