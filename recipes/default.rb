#Installs nutch 2.1 according to http://wiki.apache.org/nutch/Nutch2Tutorial

# Prepare config files
cookbook_file "/tmp/gora.properties" do
    source "gora.properties"
    mode "0644"
end

cookbook_file "/tmp/nutch-site.xml" do
    source "nutch-site.xml"
    mode "0644"
end

cookbook_file "/tmp/ivy.xml" do
    source "ivy.xml"
    mode "0644"
end

remote_file "/tmp/apache-nutch-2.1-src.tar.gz" do
  source "http://artfiles.org/apache.org/nutch/2.1/apache-nutch-2.1-src.tar.gz"
  notifies :run, "bash[install_nutch]", :immediately
end

# Extract configure for hbase and compile
bash "install_nutch" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf apache-nutch-2.1-src.tar.gz
    cd apache-nutch-2.1
    cp /tmp/nutch-site.xml ./conf/nutch-site.xml
    cp /tmp/gora.properties ./conf/gora.properties
    cp /tmp/ivy.xml ./ivy/ivy.xml
    ant runtime
    cp -r /tmp/apache-nutch-2.1 /opt/nutch
    chmod g+s -R /opt/nutch/
    #replace the delivered hbase libs with hbase 0.94 libs from cloudera
   # rm /opt/nutch/runtime/local/lib/hbase*
   # cp /usr/lib/hbase/hbase.jar /opt/nutch/runtime/local/lib/
  EOH
  action :nothing
end