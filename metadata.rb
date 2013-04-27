maintainer        "Timo Schmidt"
description       "Installs Nutch 2.1 on cloudera 4"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"

depends "cloudera"
depends "java"

recipe "nutch21", "Installs nutch 2.1 on cloudera"

%w{ ubuntu }.each do |os|
  supports os
end
