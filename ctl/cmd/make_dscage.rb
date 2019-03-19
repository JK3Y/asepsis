def cmd_make_dscage(options)
    sys("sudo mkdir -p \"#{PREFIX_PATH}\"")
    sys("sudo chmod 777 \"#{PREFIX_PATH}\"")
end
