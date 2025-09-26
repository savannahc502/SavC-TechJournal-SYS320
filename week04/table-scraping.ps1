﻿function gatherClasses() {

$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.19/Courses.html

#Get all the tr elements of a HTML document
$trs = $page.ParsedHTML.body.getElementsByTagName("tr")

#Empty array to hold results
$FullTable = @()
for($i = 1; $i -lt $trs.length; $i++){ #going over every tr element

   # get every td element of current tr element
   $tds = $trs[$i].getElementsByTagName("td")

   # want to separate start time and end time from one time field
   $Times = $tds[5].innerText.Split("-")

   $FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                   "Title" = $tds[1].innerText; `
                                   "Days" = $tds[4].innerText; `
                                   "Time Start" = $Times[0]; `
                                   "Instructor" = $tds[6].innerText; `
                                   "Location" = $tds[9].innerText; `
                                   }
}

return $FullTable
}


function daysTranslator($FullTable){

# Go over every record in the table
for($i=0; $i -lt $FullTable.length; $i++){

    # Empty array to hold days for every record
    $Days = @()

    # If you see "M" -> Monday
    if($FullTable[$i].Days -ilike "*M*"){  $Days += "Monday"  }

    # If you see "T" followed by T, W, or F -> Tuesday
    if($FullTable[$i].Days -ilike "*T[W,F]*"){  $Days += "Tuesday"  }

    # If you see a "W" -> Wednesday
    if($FullTable[$i].Days -ilike "*W*"){  $Days += "Wednesday"  }

    # If you see a "Th" -> Thursday
    if($FullTable[$i].Days -ilike "*TH*"){  $Days += "Thursday"  }

    # If you see a "F" -> Friday
    if($FullTable[$i].Days -ilike "*F*"){  $Days += "Friday"  }

    # Make the Switch
    $FullTable[$i].Days = $Days

}
return $FullTable
}

