
#!/bin/bash
#finds.sh
pattern=$1
exclude=$2
find . -type f -name "$pattern" ! -path "$exclude/*"

