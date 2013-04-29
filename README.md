Description
===========

Configures and compiles nutch 2.1 and installs it in configured cloudera machine.

Cookbooks
===========================
* nutch21 (default) - Installs nutch on cloudera


How to use
===========================


Create a role in "roles/nutch.rb":

	name "nutch21"
	description "Installs nutch 2.1 with all dependencies on cloudera 4"

	default_attributes(
	  :java => {
		 :oracle => {
		   "accept_oracle_download_terms" => true
		 },
		 "remove_deprecated_packages" => false
	   }
	)

	override_attributes(
	  "cloudera" => {
		"installyarn" => false
	  },
	  "java" => {
		"install_flavor" => "oracle"
	  },
	  "ant" => {
		"install_method" => "source"
	  }
	)

	run_list(
		"recipe[java]",
		"recipe[ant]",
		"recipe[cloudera]",
		"recipe[cloudera::hbase]",
		"recipe[nutch21]"
	)

I've used the following Cheffile:


	#!/usr/bin/env ruby
	#^syntax detection

	site 'http://community.opscode.com/api/v1'

	cookbook "apt"
	cookbook "java", "1.6.0"
	cookbook "ant"
	cookbook "sudo"
	cookbook "vim"
	cookbook "git"
	cookbook "hosts"
	cookbook "openssh"
	cookbook "openssl"
	cookbook "cloudera", :git => "git://github.com/timoschmidt/cloudera.git"
	cookbook "nutch21", :git => "git://github.com/timoschmidt/nutch21-cookbook.git"



Create a Vagrant file (nutch currently not works with hbase 0.94 thats why we use cloudera 3 and lucid32):

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    Vagrant::Config.run do |config|
        config.vm.box = "lucid32"
        config.vm.box_url = "http://files.vagrantup.com/lucid32.box"
        config.vm.network :hostonly, "192.168.33.10"

        config.vm.provision :chef_solo do |chef|
           chef.cookbooks_path = "cookbooks"
           chef.roles_path = "roles"
           chef.add_role "nutch"
         end

      #   chef.validation_client_name = "ORGNAME-validator"
      config.vm.customize ["modifyvm", :id,"--memory", "4096"]
    end


Requirements
============

Cookbooks
--------
java cookbook: https://github.com/opscode-cookbooks/java
cloudera cookbook: https://github.com/timoschmidt/cloudera (https://github.com/danielpoe/cloudera)


Platform
--------

* Ubuntu

Attributes
==========
