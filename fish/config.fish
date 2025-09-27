source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end


set JAVA_HOME /home/thai/applications/java $JAVA_HOME
set PATH $JAVA_HOME/bin $PATH

set M2_HOME /home/thai/applications/apache-maven $M2_HOME
set M2 $M2_HOME/bin $M2
set MAVEN_OPTS "-Xms256m -Xmx512m" $MAVEN_OPTS
set PATH $M2 $PATH

