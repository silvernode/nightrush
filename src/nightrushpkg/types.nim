
type
    Employee* = object
        name*: TaintedString
        cpm*: string
        start*: int
        stop*: int