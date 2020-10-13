# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import 
    nightrushpkg/procs, 
    nightrushpkg/types,
    strutils

when isMainModule:
    
    

    var employ = Employee()
    while true:
        options_menu()

        display_employ_data(load_data_file(employ))
    




