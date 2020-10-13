import 
    types,
    strformat,
    os,
    strutils,
    streams,
    regex


# create a file contining infrmation on a given employee
proc mk_employee*() =
    var employ: Employee
    stdout.write("Name of new employee: ")
    employ.name = readLine(stdin)
    
    let lines = [
        fmt"{employ.name}"]
    try:
        let file = open(fmt"{employ.name}.txt", fmWrite)

        defer: file.close()

        for line in lines:
            file.writeLine(line)
    except: echo "something went wrong"


proc load_data_file*(employ: Employee): Employee=
    var employ = employ
    if not existsFile(fmt"{employ.name}.txt"):

        mk_employee()

    else:
        
        var fileStream = newFileStream(fmt"{employ.name}.txt", fmRead)
        var line = ""
        

        defer: fileStream.close()
        var myData: seq[TaintedString]
        var myDataLen = 0
        #var lines = fileStream.readLine()
        while fileStream.readLine(line):
            myDataLen = myData.len()
            myData.add(line)
            
        employ.name = myData[0]
        

        echo employ.name
        

    return employ

            



# add a number of cases to a given employee
proc inputCases*(employ: var Employee): float =
    employ = employ

    
    stdout.write(fmt"input cases for {employ.name}: ")
    var cases = readLine(stdin)

    

proc display_employ_data*(employ: Employee) =

    echo fmt"Name: {employ.name}"
    echo fmt"CPM: {employ.cpm}"
    

proc switch_employee*(employ_name: var TaintedString): Employee =
    var employ: Employee

    employ.name = employ_name

    return employ

proc calc_cpm*(employ: var Employee) =

    employ.name = employ.name

    stdout.write(fmt"How many cases does {employ.name} have?: ")

    var cases = readLine(stdin).parseFloat()

    if $cases == "q":
        quit(0)

    elif $cases == "m":
        return

    elif re"[^0-9.]" in $cases:
        echo "Can only contain numbers"

    stdout.write("How many hours did it take?: ")
    var hours = readLine(stdin).parseFloat()

    if $hours == "q":
        quit(0)

    elif $hours == "m":
        return

    elif re"[^0-9.]" in $hours:
        echo "Can only be numbers"

    else:
        if hours < 10:
            hours = hours * 60

        var cpm = cases / hours

        employ.cpm = $cpm

        display_employ_data(load_data_file(employ))
proc process_input*(choice: var TaintedString) =
    var employ: Employee


    try:
        case choice
            of "ls":
                echo "Show list of employees"

            of "a":
                mk_employee()

            of "r":
                echo "Remove employee"

            of "s":
                stdout.write("Which employee?: ")
                var employ_name = readLine(stdin)
                
                employ.name = load_data_file(switch_employee(employ_name)).name
                calc_cpm(employ)
                return
                
    except:
        echo "bad input"

proc options_menu*() =
    echo """
    a) Add employee
    r) Remove Employee
    s) Select Employee
    g) generate report

    """
    stdout.write("Choose: ")
    var choice = readLine(stdin)
    process_input(choice)


