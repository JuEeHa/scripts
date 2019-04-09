#!/usr/bin/awk -f
BEGIN {
    FS="|"
    blank="[    ]"
    blanks=blank"+"
}

# Table head
/^\{\{.*\|.*\}\}$/ {
    if(! intable) print "<table>"
    intable=1
    print "<tr>"

    $0 = substr($0, 3, length($0)-4)
    split($0, a)
    for(i in a) {
        align="center"
        if(match(a[i], "^" blank blanks)) {
            if(! match(a[i], blanks blank "$"))
                align="right"
        } else if(match(a[i], blanks blank "$"))
            align="left"
        print "<th align='"align"'>" a[i] "</th>"
    }
    print "</tr>"
    next
}

# Table lines
/^\{.*\|.*\}$/ {
    if(! intable) print "<table>"
    intable=1
    print "<tr>"

    $0 = substr($0, 2, length($0)-2)
    split($0, a)
    for(i in a) {
        align="center"
        if(match(a[i], "^" blank blanks)) {
            if(! match(a[i], blanks blank "$"))
                align="right"
        } else if(match(a[i], blanks blank "$"))
            align="left"
        print "<td align='"align"'>" a[i] "</td>"
    }
    print "</tr>"
    next
}

# everything else
{
    if(intable) print "</table>"
    intable=0
    print
}
