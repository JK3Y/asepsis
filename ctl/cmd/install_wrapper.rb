def cmd_install_wrapper(options)
    force = options[:force]

    die_if_no_codesign() unless lions? # under lions codesign is not needed

    # prevent installing on future OS versions
    os_version_check() unless force

    # sanity check
    ds_lib = File.join(DS_LIB_FOLDER, "DesktopServicesPriv")
    if desktopservicespriv_wrapper?(ds_lib) then
        die("wrapper framework seems to be installed (#{ds_lib} was created by Asepsis), to reinstall please run: \"asepsisctl uninstall_wrapper\" first")
    end

    unless lions?
      # dry run codesign in a temp folder to test its proper function
      # see https://github.com/binaryage/asepsis/issues/25
      puts
      puts "---- START DRY RUN ----"
      temp_folder = "/tmp/asepsis-codesign-dry-run"
      sys("sudo rm -rf \"#{temp_folder}\"")
      sys("sudo mkdir -p \"#{temp_folder}\"")
      sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{temp_folder}\"")
      temp_lib = "#{temp_folder}/A/DesktopServicesPriv"
      sys("sudo \"#{RESOURCES_PATH}/install_name_tool\" -id \"#{temp_lib}\" \"#{temp_lib}\"")
      sys("sudo \"#{CODESIGN_PATH}\" --deep --file-list - --timestamp=none --force --sign - \"#{temp_lib}\"")

      sys("codesign --verify \"#{temp_lib}\"")
      sys("codesign --verify \"#{temp_folder}/A\"")

      sys("sudo rm -rf \"#{temp_folder}\"")
      sys("sudo mkdir -p \"#{temp_folder}\"")
      sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{temp_folder}\"")
      temp_lib = "#{temp_folder}/A/DesktopServicesPriv"
      sys("sudo cp \"#{DS_WRAPPER_SOURCE_PATH}\" \"#{temp_lib}\"")
      sys("sudo \"#{CODESIGN_PATH}\" --deep --file-list - --timestamp=none --force --sign - \"#{temp_folder}/A\"")

      sys("codesign --verify \"#{temp_lib}\"")
      sys("codesign --verify \"#{temp_folder}/A\"")

      sys("sudo rm -rf \"#{temp_folder}\"")
      puts "---- END DRY RUN ----"
      puts
    end
    
    # forced installation should remove potentially existing backup
    if force and File.exists? DS_LIB_RELOCATED_FOLDER
      sys("sudo rm -rf \"#{DS_LIB_RELOCATED_FOLDER}\"")
    end

    # sanity check
    if File.exists? DS_LIB_RELOCATED_FOLDER
        die("wrapper framework seems to be installed (#{DS_LIB_RELOCATED_FOLDER} exists), to reinstall please run: \"asepsisctl uninstall_wrapper\" first")
    end
    
    # make panic backup (only once, the first time asepsis was installed)
    unless File.exists? DS_LIB_PANIC_BACKUP_FOLDER then
        sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{DS_LIB_PANIC_BACKUP_FOLDER}\"")
    end
    
    # make timestamped panic backup
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    os_marker = os_version_marker()
    panic_backup_folder_with_timestamp = "#{DS_LIB_PANIC_BACKUP_FOLDER}_#{os_marker}_#{timestamp}"
    unless File.exists? panic_backup_folder_with_timestamp then
        sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{panic_backup_folder_with_timestamp}\"")
    end

    # make normal backup
    sys("sudo rm -rf \"#{DS_LIB_BACKUP_FOLDER}\"")
    sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{DS_LIB_BACKUP_FOLDER}\"")
    sys("sudo touch \"#{DS_LIB_ASEPSIS_REV}\"")

    # replace DesktopServicesPriv inplace
    sys("sudo cp -a \"#{DS_LIB_FOLDER}\" \"#{DS_LIB_RELOCATED_FOLDER}\"")
    relocated_lib = "#{DS_LIB_RELOCATED_FOLDER}/DesktopServicesPriv"
    sys("sudo \"install_name_tool\" -id \"#{relocated_lib}\" \"#{relocated_lib}\"")
    # apply code signatures only under Mavericks and higher
    sys("sudo \"#{CODESIGN_PATH}\" --deep --file-list - --timestamp=none --force --sign - \"#{relocated_lib}\"") unless lions?

    sys("codesign --verify \"#{relocated_lib}\"") unless lions?
    sys("codesign --verify \"#{DS_LIB_RELOCATED_FOLDER}\"") unless lions?

    wrapper_lib = "#{DS_LIB_FOLDER}/DesktopServicesPriv"
    sys("sudo cp \"#{DS_WRAPPER_SOURCE_PATH}\" \"#{wrapper_lib}\"")
    # since 10.9.3 it is important to codesing in-place after copying the file, see https://github.com/binaryage/asepsis/issues/13
    sys("sudo \"#{CODESIGN_PATH}\" --deep --file-list - --timestamp=none --force --sign - \"#{DS_LIB_FOLDER}\"") unless lions?
    
    sys("codesign --verify \"#{wrapper_lib}\"") unless lions?
    sys("codesign --verify \"#{DS_LIB_FOLDER}\"") unless lions?
end
