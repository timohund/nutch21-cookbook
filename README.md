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
    description "Installs nutch21 on top of cloudera/ubuntu"

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
      }
    )


    # todo - replace basic by aoe common recipe
    run_list(
        "recipe[java::oracle]",
        "recipe[cloudera]",
        "recipe[cloudera::hbase]"
        "recipe[nutch21]"
    )


Create a Vagrant file:

    # -*- mode: ruby -*-
    # vi: set ft=ruby :
    Vagrant::Config.run do |config|
        config.vm.box = "precise64"

        config.vm.box_url = "http://files.vagrantup.com/precise64.box"
        config.vm.network :hostonly, "192.168.33.10"

        config.vm.provision :chef_solo do |chef|
           chef.cookbooks_path = "cookbooks"
           chef.roles_path = "roles"
           chef.add_role "nutch21"
         end

      #   chef.validation_client_name = "ORGNAME-validator"
      config.vm.customize ["modifyvm", :id,"--memory", "2048"]
    end

Requirements
============

Cookbooks
--------
java cookbook: https://github.com/opscode-cookbooks/java
cloudera cookbook: https://github.com/danielpoe/cloudera


Platform
--------

* Ubuntu

Attributes
==========
